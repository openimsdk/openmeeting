import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';
import 'package:sprintf/sprintf.dart';
import '../../../../data/models/define.dart';
import '../../../../widgets/meeting/desktop/m_x_n_layout_view.dart';
import '../../../../widgets/meeting/desktop/meeting_alert_dialog.dart';
import '../../../../widgets/meeting/desktop/one_x_n_layout_view.dart';
import '../../../../widgets/meeting/meeting_view.dart';
import '../../../../widgets/meeting/participant_info.dart';

class MeetingDesktopRoom extends MeetingView {
  const MeetingDesktopRoom(super.room, super.listener,
      {super.key, required super.roomID, super.onParticipantOperation, super.options, super.onOperation, super.onSubjectInit});

  @override
  MeetingViewState<MeetingDesktopRoom> createState() => _MeetingRoomState();
}

class _MeetingRoomState extends MeetingViewState<MeetingDesktopRoom> {
  //
  List<ParticipantTrack> participantTracks = [];

  EventsListener<RoomEvent> get _listener => widget.listener;

  bool get fastConnection => widget.room.engine.fastConnectOptions != null;

  ScrollPhysics? scrollPhysics;
  final _pageController = PageController();
  int _pages = 0;
  ParticipantTrack? focusParticipantTrack;

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
    ..on<RoomDisconnectedEvent>((event) => _meetingClosed(event))
    ..on<RoomRecordingStatusChanged>((event) {})
    ..on<LocalTrackPublishedEvent>((_) => _sortParticipants())
    ..on<LocalTrackUnpublishedEvent>((_) => _sortParticipants())
    ..on<ParticipantConnectedEvent>((_) => _sortParticipants())
    ..on<ParticipantDisconnectedEvent>((_) => _sortParticipants())
    ..on<RoomMetadataChangedEvent>((event) => _parseRoomMetadata())
    ..on<TrackMutedEvent>((event) => _onTrackMuted(event))
    ..on<TrackUnmutedEvent>((event) => _onTrackUnMuted(event))
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

    Logger.print('participant: ${event.participant?.identity} metadata: $map');

    if (map['operation'] == null) return;

    final operation = List<Map<String, dynamic>>.from(map['operation']);

    final operateUser = operation.firstWhereOrNull((element) {
      return element['userID'] == widget.room.localParticipant?.identity;
    });

    if (operateUser == null) return;

    final operationEntry = Map<String, dynamic>.from(operateUser['operation']);
    final cameraOnEntry = operationEntry['cameraOnEntry'] as bool?;
    final microphoneOnEntry = operationEntry['microphoneOnEntry'] as bool?;

    if (cameraOnEntry != null) {
      if (cameraOnEntry) {
        MeetingAlertDialog.show(context, '', sprintf(StrRes.requestXDoHint, [StrRes.meetingUnmute]),
            forMobile: true, confirmText: StrRes.confirm, cancelText: StrRes.keepClose, onConfirm: () {
          widget.room.localParticipant?.setCameraEnabled(cameraOnEntry);
        });
      } else {
        widget.room.localParticipant?.setCameraEnabled(cameraOnEntry);
      }
    }
    if (microphoneOnEntry != null) {
      if (microphoneOnEntry) {
        MeetingAlertDialog.show(context, '', sprintf(StrRes.requestXDoHint, [StrRes.meetingEnableVideo]),
            forMobile: true, confirmText: StrRes.confirm, cancelText: StrRes.keepClose, onConfirm: () {
          widget.room.localParticipant?.setMicrophoneEnabled(microphoneOnEntry);
        });
      } else {
        widget.room.localParticipant?.setMicrophoneEnabled(microphoneOnEntry);
      }
    }
    Logger.print(jsonStr);
  }

  void _parseRoomMetadata() {
    Logger.print('room parseRoomMetadata: ${widget.room.metadata}');

    if (widget.room.metadata != null) {
      final json = jsonDecode(widget.room.metadata!);
      meetingInfo = MeetingInfoSetting()..mergeFromProto3Json(json['detail']);
      meetingInfoChangedSubject.add(meetingInfo!);
      setState(() {});
    }
  }

  void _onTrackMuted(TrackMutedEvent event) {
    if (focusParticipantTrack != null && event.participant.identity == focusParticipantTrack!.participant.identity) {
      setState(() {
        focusParticipantTrack = null;
      });
    }

    final track = _configureTrack(event.participant);
    final index = participantTracks.indexWhere((element) => element.participant.identity == track.participant.identity);
    participantTracks[index] = track;

    participantsSubject.add(participantTracks);
  }

  void _onTrackUnMuted(TrackUnmutedEvent event) {
    if (wasClickedUserID != null || watchedUserID != null || focusParticipantTrack != null) return;
    final track = _configureTrack(event.participant);

    setState(() {
      focusParticipantTrack = track;
    });

    final index = participantTracks.indexWhere((element) => element.participant.identity == track.participant.identity);
    participantTracks[index] = track;

    participantsSubject.add(participantTracks);
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
      if (widget.roomID == participant.identity) {
        continue;
      }

      final track = _configureTrack(participant);
      participantTracks.add(setWatchedTrack(track));
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
    } else if (focusParticipantTrack != null) {
      track = focusParticipantTrack;
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
      final track = _configureTrack(widget.room.localParticipant!);

      return setWatchedTrack(track);
    }
    return null;
  }

  ParticipantTrack _configureTrack(Participant participant) {
    VideoTrack? videoTrack;
    VideoTrack? screenShareTrack;
    for (final t in participant.videoTrackPublications) {
      if (t.isScreenShare) {
        screenShareTrack = t.track as VideoTrack?;
      } else {
        videoTrack = t.track as VideoTrack?;
      }
    }

    final track = ParticipantTrack(
      participant: participant,
      videoTrack: videoTrack,
      screenShareTrack: screenShareTrack,
      isHost: hostUserID == participant.identity,
    );

    return track;
  }

  bool get anyOneHasVideo =>
      participantTracks.any((e) => (e.screenShareTrack != null && !e.screenShareTrack!.muted) || (e.videoTrack != null && !e.videoTrack!.muted));

  // _onPageChange(int pages) {
  //   setState(() {
  //     _pages = pages;
  //   });
  // }

  _fixPages(int count) {
    _pages = min(_pages, count - 1);
    return count;
  }

  int get pageCount => _fixPages((participantTracks.length % 4 == 0 ? participantTracks.length ~/ 4 : participantTracks.length ~/ 4 + 1) +
      (null == _firstParticipantTrack ? 0 : 1));

  @override
  Widget buildChild() {
    return Container(
      color: Colors.white,
      child: Stack(children: [
        anyOneHasVideo
            ? OxNLayoutView(
                focusParticipantTrack: _firstParticipantTrack,
                participantTracks: participantTracks,
              )
            : MxNLayoutView(
                participantTracks: participantTracks,
              ),
      ]),
    );
  }

  void _meetingClosed(RoomDisconnectedEvent event) {
    Logger.print('_meetingClosed: ${event.reason == DisconnectReason.disconnected}');
    if (event.reason == DisconnectReason.reconnectAttemptsExceeded || event.reason == DisconnectReason.duplicateIdentity) {
      return;
    }
    MeetingAlertDialog.show(context, '', event.reason == DisconnectReason.disconnected ? StrRes.meetingIsOver : StrRes.meetingClosedHint,
        confirmText: event.reason == DisconnectReason.disconnected ? StrRes.iKnew : null, onConfirm: () {
      widget.onOperation?.call(context, OperationType.onlyClose);
    });
  }
}

class FirstPageZoomNotification extends Notification {
  bool isZoom;

  FirstPageZoomNotification({this.isZoom = false});
}
