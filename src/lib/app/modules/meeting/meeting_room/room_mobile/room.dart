import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/widgets/meeting/desktop/meeting_alert_dialog.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../data/models/define.dart';
import '../../../../data/models/meeting.pb.dart';
import '../../../../data/services/repository/repository.dart';
import '../../../../widgets/meeting/meeting_view.dart';
import '../../../../widgets/meeting/overlay_widget.dart';
import '../../../../widgets/meeting/page_content.dart';
import '../../../../widgets/meeting/participant.dart';
import '../../../../widgets/meeting/participant_info.dart';
import '../meeting_client.dart';

class MeetingRoom extends MeetingView {
  const MeetingRoom(super.room, super.listener, {super.key, required super.roomID, super.onParticipantOperation, super.onOperation, super.options});

  @override
  MeetingViewState<MeetingRoom> createState() => _MeetingRoomState();
}

class _MeetingRoomState extends MeetingViewState<MeetingRoom> {
  //
  List<ParticipantTrack> participantTracks = [];

  EventsListener<RoomEvent> get _listener => widget.listener;

  bool get fastConnection => widget.room.engine.fastConnectOptions != null;

  ScrollPhysics? scrollPhysics;
  final _pageController = PageController();
  int _pages = 0;
  String loginUserID = MeetingClient().userInfo.userID;
  final repository = MeetingRepository();

  @override
  void initState() {
    super.initState();
    widget.room.addListener(_onRoomDidUpdate);
    _setUpListeners();
    _sortParticipants();
    _parseRoomMetadata();
    WidgetsBindingCompatible.instance?.addPostFrameCallback((_) {
      startTimerCompleter.complete(true);
      if (!fastConnection) {
        _askPublish();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    // always dispose listener
    (() async {
      widget.room.removeListener(_onRoomDidUpdate);
      await _listener.dispose();
      // for (var e in widget.room.participants.values) {
      //   await e.dispose();
      // }
      await widget.room.localParticipant?.dispose();
      await widget.room.disconnect();
      await widget.room.dispose();
    })();
    super.dispose();
  }

  void _setUpListeners() => _listener
    ..on<RoomDisconnectedEvent>((event) => _meetingClosed())
    ..on<RoomRecordingStatusChanged>((event) {})
    ..on<LocalTrackPublishedEvent>((_) => _sortParticipants())
    ..on<LocalTrackUnpublishedEvent>((_) => _sortParticipants())
    ..on<ParticipantConnectedEvent>((_) => _sortParticipants())
    ..on<ParticipantDisconnectedEvent>((_) => _sortParticipants())
    ..on<RoomMetadataChangedEvent>((event) => _parseRoomMetadata())
    ..on<DataReceivedEvent>((event) => _parseDataReceived(event));

  void _askPublish() async {
    Logger.print('joinDisabledVideo: $joinDisabledVideo');
    Logger.print('joinDisabledMicrophone: $joinDisabledMicrophone');
    // video will fail when running in ios simulator
    try {
      final enable = !joinDisabledVideo && widget.options.enableVideo;
      await widget.room.localParticipant?.setCameraEnabled(enable);
    } catch (error) {
      Logger.print('could not publish video: $error');
    }
    try {
      final enable = !joinDisabledMicrophone && widget.options.enableMicrophone;
      await widget.room.localParticipant?.setMicrophoneEnabled(enable);
    } catch (error) {
      Logger.print('could not publish audio: $error');
    }
  }

  void _parseDataReceived(DataReceivedEvent event) {
    final jsonStr = utf8.decode(event.data);
    final map = jsonDecode(jsonStr);
    final result = StreamOperateData()..mergeFromProto3Json(map);
    Logger.print('participant: ${event.participant?.identity} metadata: $map');

    if (result.operation.isEmpty || result.operatorUserID == widget.room.localParticipant?.identity) {
      return;
    }

    final operateUser = result.operation.firstWhereOrNull((element) {
      return element.userID == widget.room.localParticipant?.identity;
    });

    if (operateUser == null) return;

    final cameraOnEntry = operateUser.cameraOnEntry;
    final microphoneOnEntry = operateUser.microphoneOnEntry;

    if (cameraOnEntry) {
      MeetingAlertDialog.show(context, '', sprintf(StrRes.requestXDoHint, [StrRes.meetingEnableVideo]),
          forMobile: true, confirmText: StrRes.confirm, cancelText: StrRes.keepClose, onConfirm: () {
        widget.room.localParticipant?.setCameraEnabled(cameraOnEntry);
      });
    } else {
      widget.room.localParticipant?.setCameraEnabled(cameraOnEntry);
    }

    if (microphoneOnEntry) {
      MeetingAlertDialog.show(context, '', sprintf(StrRes.requestXDoHint, [StrRes.meetingUnmute]),
          forMobile: true, confirmText: StrRes.confirm, cancelText: StrRes.keepClose, onConfirm: () {
        widget.room.localParticipant?.setMicrophoneEnabled(microphoneOnEntry);
      });
    } else {
      widget.room.localParticipant?.setMicrophoneEnabled(microphoneOnEntry);
    }

    Logger.print(jsonStr);
  }

  void _parseRoomMetadata() {
    Logger.print('room parseRoomMetadata: ${widget.room.metadata}');

    if (widget.room.metadata?.isNotEmpty == true) {
      meetingInfo = (MeetingMetadata()..mergeFromProto3Json(jsonDecode(widget.room.metadata!))).detail;
      meetingInfoChangedSubject.add(meetingInfo!);

      setState(() {});
    }
  }

  @override
  customWatchedUser(String userID) {
    if (wasClickedUserID == userID) return;
    final track = participantTracks.firstWhereOrNull((e) =>
        e.participant.identity == userID &&
        (e.screenShareTrack != null && !e.screenShareTrack!.muted || e.videoTrack != null && !e.videoTrack!.muted));
    wasClickedUserID = track?.participant.identity;
    if (null != wasClickedUserID) _sortParticipants();
  }

  void _onRoomDidUpdate() {
    _sortParticipants();
  }

  void _sortParticipants() {
    List<ParticipantTrack> participantTracks = [];

    for (var participant in widget.room.remoteParticipants.values) {
      // 排除观察者
      if (widget.roomID == participant.identity) {
        continue;
      }
      VideoTrack? videoTrack;
      VideoTrack? screenShareTrack;
      for (var t in participant.videoTrackPublications) {
        if (t.isScreenShare) {
          screenShareTrack = t.track;
        } else {
          videoTrack = t.track;
        }
      }
      participantTracks.add(setWatchedTrack(ParticipantTrack(
        participant: participant,
        videoTrack: videoTrack,
        screenShareTrack: screenShareTrack,
        isHost: hostUserID == participant.identity,
      )));
    }

    if (null != _localParticipantTrack) {
      participantTracks.add(_localParticipantTrack!);
    }

    participantTracks.sort((a, b) {
      // joinedAt
      return a.participant.joinedAt.millisecondsSinceEpoch - b.participant.joinedAt.millisecondsSinceEpoch;
    });

    participantsSubject.add(participantTracks);

    setState(() {
      this.participantTracks = [...participantTracks];
    });
  }

  ParticipantTrack? get _firstParticipantTrack {
    ParticipantTrack? track;
    if (null != watchedUserID) {
      track = participantTracks.firstWhere((e) => e.participant.identity == watchedUserID);
    } else if (null != wasClickedUserID) {
      track = participantTracks.firstWhere((e) => e.participant.identity == wasClickedUserID);
    } else {
      track = participantTracks.firstWhereOrNull((e) => e.screenShareTrack != null || e.videoTrack != null);
    }
    Logger.print('first watch track : ${track == null} '
        'videoTrack:${track?.videoTrack == null} '
        'screenShareTrack:${track?.screenShareTrack == null} '
        'muted:${track?.videoTrack?.muted} '
        'muted:${track?.screenShareTrack?.muted}');
    return track;
  }

  ParticipantTrack? get _localParticipantTrack {
    if (widget.room.localParticipant != null) {
      VideoTrack? videoTrack;
      VideoTrack? screenShareTrack;
      final localParticipantTracks = widget.room.localParticipant!.videoTrackPublications;
      for (var t in localParticipantTracks) {
        if (t.isScreenShare) {
          screenShareTrack = t.track;
        } else {
          videoTrack = t.track;
        }
      }
      return setWatchedTrack(ParticipantTrack(
        participant: widget.room.localParticipant!,
        videoTrack: videoTrack,
        screenShareTrack: screenShareTrack,
        isHost: hostUserID == widget.room.localParticipant!.identity,
      ));
    }
    return null;
  }

  _onPageChange(int pages) {
    setState(() {
      _pages = pages;
    });
  }

  _fixPages(int count) {
    _pages = min(_pages, count - 1);
    return count;
  }

  int get pageCount => _fixPages((participantTracks.length % 4 == 0 ? participantTracks.length ~/ 4 : participantTracks.length ~/ 4 + 1) +
      (null == _firstParticipantTrack ? 0 : 1));

  @override
  Widget buildChild() => Container(
        color: Color(0xFF333333),
        child: Stack(
          children: [
            widget.room.remoteParticipants.isEmpty
                ? (_localParticipantTrack == null
                    ? const SizedBox()
                    : ParticipantWidget.widgetFor(_localParticipantTrack!, options: widget.options, isZoom: true, useScreenShareTrack: true,
                        onTapSwitchCamera: () {
                        _localParticipantTrack!.toggleCamera();
                      }))
                : StatefulBuilder(
                    builder: (v, status) {
                      return GestureDetector(
                        child: NotificationListener(
                          onNotification: (v) {
                            if (v is FirstPageZoomNotification) {
                              scrollPhysics = v.isZoom ? const NeverScrollableScrollPhysics() : null;
                              status.call(() {});
                              return true;
                            }
                            return false;
                          },
                          child: PageView.builder(
                            physics: scrollPhysics,
                            itemBuilder: (context, index) {
                              final existVideoTrack = null != _firstParticipantTrack;
                              if (existVideoTrack && index == 0) {
                                return GestureDetector(
                                  child: FirstPage(
                                    participantTrack: _firstParticipantTrack!,
                                    options: widget.options,
                                  ),
                                  onTap: () {
                                    toggleFullScreen();
                                  },
                                );
                              }
                              return OtherPage(
                                participantTracks: participantTracks,
                                pages: existVideoTrack ? index - 1 : index,
                                options: widget.options,
                                onDoubleTap: (t) {
                                  setState(() {
                                    customWatchedUser(t.participant.identity);
                                    _pageController.jumpToPage(0);
                                  });
                                },
                              );
                            },
                            itemCount: pageCount,
                            onPageChanged: _onPageChange,
                            controller: _pageController,
                          ),
                        ),
                      );
                    },
                  ),
            if (widget.room.remoteParticipants.isNotEmpty && pageCount > 1)
              Positioned(
                bottom: 8.h,
                child: PageViewDotIndicator(
                  currentItem: _pages,
                  count: pageCount,
                  size: Size(8.w, 8.h),
                  unselectedColor: Styles.c_FFFFFF_opacity50,
                  selectedColor: Styles.c_FFFFFF,
                ),
              ),
            Positioned(
              right: 16.w,
              bottom: 16.h,
              child: ImageRes.meetingRotateScreen.toImage
                ..width = 44.w
                ..height = 44.h
                ..onTap = rotateScreen,
            )
          ],
        ),
      );

  void _meetingClosed() => OverlayWidget().showDialog(
        context: context,
        child: CustomDialog(
          onTapLeft: OverlayWidget().dismiss,
          onTapRight: () {
            OverlayWidget().dismiss();
            widget.onOperation?.call(context, OperationType.leave);
          },
          title: StrRes.meetingClosedHint,
        ),
      );
}

class FirstPageZoomNotification extends Notification {
  bool isZoom;

  FirstPageZoomNotification({this.isZoom = false});
}
