import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:openmeeting/app/widgets/meeting/desktop/meeting_alert_dialog.dart';
import 'package:openmeeting/app/widgets/meeting/select_member_view.dart';
import 'package:rxdart/rxdart.dart';
import 'package:synchronized/synchronized.dart';

import '../../data/models/define.dart';
import '../../data/models/meeting.pb.dart';
import '../../data/models/meeting_option.dart';
import 'appbar.dart';
import 'desktop/meeting_pop_menu.dart';
import 'meeting_close_sheet.dart';
import 'meeting_detail_sheet.dart';
import 'meeting_members.dart';
import 'meeting_settings_sheet.dart';
import 'overlay_widget.dart';
import 'participant_info.dart';
import 'toolsbar.dart';

class ControlsView extends StatefulWidget {
  const ControlsView(
    this.room,
    this.participant, {
    super.key,
    required this.child,
    required this.meetingInfoChangedSubject,
    required this.participantsSubject,
    required this.hostUserInfo,
    this.onParticipantOperation,

    // this.onClose,
    this.onMinimize,
    this.onInviteMembers,
    this.startTimerCompleter,
    this.enableFullScreen = false,
    this.options = const MeetingOptions(),
    this.onOperation,
  });

  final Room room;
  final LocalParticipant participant;
  final Widget child;
  final BehaviorSubject<MeetingInfoSetting> meetingInfoChangedSubject;
  final BehaviorSubject<List<ParticipantTrack>> participantsSubject;
  // final ValueChanged<BuildContext?>? onClose;
  final Function()? onMinimize;
  final Function()? onInviteMembers;
  final Completer<bool>? startTimerCompleter;
  final bool enableFullScreen;
  final MeetingOptions options;
  final UserInfo hostUserInfo;

  final void Function<T>(BuildContext? context, OperationType type, {T? value})? onOperation;
  final Future<bool> Function<T>({OperationParticipantType type, String userID, T to})? onParticipantOperation;

  @override
  State<ControlsView> createState() => _ControlsViewState();
}

class _ControlsViewState extends State<ControlsView> {
  LocalParticipant get _participant => widget.participant;
  MeetingInfoSetting? _meetingInfo;
  Timer? _callingTimer;
  int _duration = 0;
  final StreamController<String> _durationController = StreamController.broadcast();
  bool _openSpeakerphone = true;

  // Use this object to prevent concurrent access to data
  final _lockVideo = Lock();
  final _lockAudio = Lock();
  final _lockScreenShare = Lock();

  List<MediaDevice>? _audioInputs;
  List<MediaDevice>? _audioOutputs;
  List<MediaDevice>? _videoInputs;

  StreamSubscription? _devicesSubscription;

  late StreamSubscription _meetingInfoChangedSub;

  bool get _isHost => _meetingInfo?.hostUserID == _participant.identity;

  MeetingSetting? get setting => _meetingInfo?.setting;

  bool get _disabledMicrophone =>
      !_participant.isMicrophoneEnabled() && setting?.canParticipantsUnmuteMicrophone == false && !_isHost;

  bool get _disabledCamera =>
      !_participant.isCameraEnabled() && setting?.canParticipantsEnableCamera == false && !_isHost;

  bool get _disabledScreenShare => setting?.canParticipantsShareScreen == false && !_isHost;

  int get membersCount => widget.room.remoteParticipants.length + 1;

  @override
  void initState() {
    _devicesSubscription = Hardware.instance.onDeviceChange.stream.listen((List<MediaDevice> devices) {
      _loadDevices(devices);
    });
    Hardware.instance.enumerateDevices().then(_loadDevices);

    _openSpeakerphone = widget.options.enableSpeaker;
    _participant.addListener(_onChange);
    _meetingInfoChangedSub = widget.meetingInfoChangedSubject.listen(_onChangedMeetingInfo);
    widget.startTimerCompleter?.future.then((value) => _startCallingTimer());
    _enableSpeakerphone(_openSpeakerphone);
    super.initState();
  }

  @override
  void dispose() {
    _stopBackgroundService();
    _participant.removeListener(_onChange);
    _meetingInfoChangedSub.cancel();
    _callingTimer?.cancel();
    _durationController.close();
    super.dispose();
  }

  void _startCallingTimer() {
    _callingTimer ??= Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) return;
        _durationController.add(IMUtils.seconds2HMS(_duration + 1));
        setState(() {
          ++_duration;
        });
      },
    );
  }

  void _onChangedMeetingInfo(meetingInfo) {
    if (!mounted) return;
    setState(() {
      _meetingInfo = meetingInfo;
    });
  }

  void _loadDevices(List<MediaDevice> devices) async {
    _audioInputs = devices.where((d) => d.kind == 'audioinput').toList();
    _audioOutputs = devices.where((d) => d.kind == 'audiooutput').toList();
    _videoInputs = devices.where((d) => d.kind == 'videoinput').toList();
    setState(() {});
  }

  void _onChange() {
    // trigger refresh
    // setState(() {});
  }

  void _selectAudioOutput(MediaDevice device) async {
    await widget.room.setAudioOutputDevice(device);
    setState(() {});
  }

  void _selectAudioInput(MediaDevice device) async {
    await widget.room.setAudioInputDevice(device);
    setState(() {});
  }

  _toggleAudio() async {
    await _lockAudio.synchronized(() async {
      if (_participant.isMicrophoneEnabled()) {
        await _participant.setMicrophoneEnabled(false);
      } else {
        await _participant.setMicrophoneEnabled(true);
      }
    });
  }

  _toggleVideo({bool forceDisable = false}) async {
    final cameras = await Helper.cameras;

    if (cameras.isEmpty) {
      return;
    }

    await _lockVideo.synchronized(() async {
      if (forceDisable) {
        await _participant.setCameraEnabled(false);
      } else {
        if (_participant.isCameraEnabled()) {
          await _participant.setCameraEnabled(false);
        } else {
          await _participant.setCameraEnabled(true);
        }
      }
    });
  }

  void _toggleScreenShare() async {
    await _lockScreenShare.synchronized(() async {
      if (_participant.isScreenShareEnabled()) {
        await _disableScreenShare();
      } else {
        await _enableScreenShare();
      }
    });
  }

  void _stopBackgroundService() {
    if (FlutterBackground.isBackgroundExecutionEnabled) {
      FlutterBackground.disableBackgroundExecution();
    }
  }

  Future _enableScreenShare() async {
    if (lkPlatformIsDesktop()) {
      try {
        final source = await showDialog<DesktopCapturerSource>(
          context: context,
          builder: (context) => ScreenSelectDialog(),
        );
        if (source == null) {
          return;
        }
        var track = await LocalVideoTrack.createScreenShareTrack(
          ScreenShareCaptureOptions(
            sourceId: source.id,
            maxFrameRate: 15.0,
          ),
        );
        await _participant.publishVideoTrack(track);
      } catch (e) {
        print('could not publish video: $e');
      }
      return;
    }

    _toggleVideo(forceDisable: true);

    if (lkPlatformIs(PlatformType.android)) {
      // Android specific
      requestBackgroundPermission([bool isRetry = false]) async {
        // Required for android screenshare.
        try {
          bool hasPermissions = await FlutterBackground.hasPermissions;
          if (!isRetry) {
            final androidConfig = FlutterBackgroundAndroidConfig(
              notificationTitle: StrRes.screenShare,
              notificationText: StrRes.screenShareHint,
              notificationImportance: AndroidNotificationImportance.Default,
              notificationIcon: const AndroidResource(name: 'ic_launcher', defType: 'mipmap'),
            );
            hasPermissions = await FlutterBackground.initialize(androidConfig: androidConfig);
          }
          if (hasPermissions && !FlutterBackground.isBackgroundExecutionEnabled) {
            await FlutterBackground.enableBackgroundExecution();
          }
        } catch (e) {
          if (!isRetry) {
            return await Future<void>.delayed(const Duration(seconds: 1), () => requestBackgroundPermission(true));
          }
          print('could not publish video: $e');
        }
      }

      await requestBackgroundPermission();
    }
    if (lkPlatformIs(PlatformType.iOS)) {
      var track = await LocalVideoTrack.createScreenShareTrack(
        const ScreenShareCaptureOptions(
            useiOSBroadcastExtension: true, maxFrameRate: 15.0, params: VideoParametersPresets.screenShareH720FPS15),
      );
      await _participant.publishVideoTrack(track);

      return;
    }
    await _participant.setScreenShareEnabled(true, captureScreenAudio: true);
  }

  Future _disableScreenShare() async {
    await _participant.setScreenShareEnabled(false);
    if (Platform.isAndroid) {
      // Android specific
      try {
        //   await FlutterBackground.disableBackgroundExecution();
      } catch (error, s) {
        Logger.print('error disabling screen share: $error  $s');
      }
    }
  }

  void _enableSpeakerphone(bool enabled) {
    Hardware.instance.setSpeakerphoneOn(enabled);
  }

  void _onTapSpeaker() async {
    _openSpeakerphone = !_openSpeakerphone;
    _enableSpeakerphone(_openSpeakerphone);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          if (PlatformExt.isDesktop) SizedBox(height: 32),
          Visibility(
              visible: !widget.enableFullScreen,
              child: PlatformExt.isDesktop
                  ? MeetingRoomDesktopAppBar(
                      title: _meetingInfo?.meetingName ?? '',
                      time: IMUtils.seconds2HMS(_duration),
                      onViewMeetingDetail: (ctx) => _viewMeetingDetail(ctx: ctx),
                    )
                  : MeetingRoomMobileAppBar(
                      title: _meetingInfo?.meetingName,
                      time: IMUtils.seconds2HMS(_duration),
                      openSpeakerphone: _openSpeakerphone,
                      onMinimize: widget.onMinimize,
                      onEndMeeting: () {
                        _onEndMeeting(context);
                      },
                      onTapSpeakerphone: _onTapSpeaker,
                      onViewMeetingDetail: _viewMeetingDetail,
                    )),
          Expanded(child: widget.child),
          Visibility(
            visible: !widget.enableFullScreen,
            child: PlatformExt.isDesktop
                ? ToolsBarDesktop(
                    openedCamera: _participant.isCameraEnabled(),
                    openedMicrophone: _participant.isMicrophoneEnabled(),
                    openedScreenShare: _participant.isScreenShareEnabled(),
                    enabledMicrophone: !_disabledMicrophone,
                    enabledCamera: !_disabledCamera,
                    enabledScreenShare: !_disabledScreenShare,
                    onTapCamera: _toggleVideo,
                    onTapMicrophone: _toggleAudio,
                    onTapMicrophoneRightIcon: _selectDevices,
                    onTapScreenShare: _toggleScreenShare,
                    onTapSettings: _openSettingsSheet,
                    onTapMemberList: _openMembersSheet,
                    membersCount: membersCount,
                    isHost: _isHost,
                    onEndMeeting: (ctx) {
                      _onEndMeeting(ctx);
                    },
                  )
                : ToolsBarMobile(
                    openedCamera: _participant.isCameraEnabled(),
                    openedMicrophone: _participant.isMicrophoneEnabled(),
                    openedScreenShare: _participant.isScreenShareEnabled(),
                    enabledMicrophone: !_disabledMicrophone,
                    enabledCamera: !_disabledCamera,
                    enabledScreenShare: !_disabledScreenShare,
                    onTapCamera: _toggleVideo,
                    onTapMicrophone: _toggleAudio,
                    onTapScreenShare: _toggleScreenShare,
                    onTapSettings: _openSettingsSheet,
                    onTapMemberList: _openMembersSheet,
                    membersCount: membersCount,
                    isHost: _isHost,
                  ),
          ),
        ],
      ),
    );
  }

  void _openMembersSheet() {
    if (PlatformExt.isDesktop) {
      widget.onOperation?.call(context, OperationType.participants);
      return;
    }
    OverlayWidget().showBottomSheet(
      context: context,
      child: (AnimationController? controller) => MeetingMembersSheetView(
        controller: controller,
        participantsSubject: widget.participantsSubject,
        meetingInfoChangedSubject: widget.meetingInfoChangedSubject,
        onInvite: widget.onInviteMembers,
        isHost: _isHost,
        onOperation: widget.onParticipantOperation,
      ),
    );
  }

  void _openSettingsSheet() {
    if (null == _meetingInfo) return;

    if (PlatformExt.isDesktop) {
      Logger.print('open setting sheet for desktop');
      return;
    }

    OverlayWidget().showBottomSheet(
      context: context,
      child: (AnimationController? controller) => MeetingSettingsSheetView(
        controller: controller,
        allowParticipantUnmute: setting?.canParticipantsUnmuteMicrophone == true,
        allowParticipantVideo: setting?.canParticipantsEnableCamera == true,
        onlyHostCanShareScreen: setting?.canParticipantsShareScreen == false,
        joinMeetingDefaultMute: setting?.disableMicrophoneOnJoin == true,
        onConfirm: _confirmSettings,
      ),
    );
  }

  void _onEndMeeting(BuildContext ctx) {
    if (PlatformExt.isMobile) {
      OverlayWidget().showBottomSheet(
        context: context,
        child: (AnimationController? controller) => MeetingCloseSheetView(
          controller: controller,
          isHost: _isHost,
          onEnd: () async {
            Logger().printInfo(info: '========= onEnd =======');
            widget.onOperation?.call(context, OperationType.end);
          },
          onLeave: () {
            Logger().printInfo(info: '========= onLeave =======');
            if (_isHost) {
              OverlayWidget().showBottomSheet(
                context: context,
                child: (AnimationController? controller) {
                  return SelectMemberViewForMobile(
                      participants: widget.participantsSubject.value,
                      onSelected: (value) {
                        controller?.reverse();
                        MeetingAlertDialog.show(context, 'Are you sure?', onConfirm: () async {
                          await widget.onParticipantOperation
                              ?.call(type: OperationParticipantType.setHost, userID: value);
                          if (mounted) {
                            widget.onOperation?.call(context, OperationType.leave);
                          }
                        });
                      });
                },
              );
            } else {
              widget.onOperation?.call(context, OperationType.leave);
            }
          },
        ),
      );
    } else {
      if (_isHost) {
        MeetingPopMenu.showMeetingWidget(ctx, onTap2: () {
          MeetingPopMenu.showSimpleWidget(
            ctx,
            SelectMemberViewForDesktop(
                participants: widget.participantsSubject.value,
                onSelected: (value) {
                  MeetingAlertDialog.show(context, 'Are you sure?', onConfirm: () async {
                    await widget.onParticipantOperation?.call(type: OperationParticipantType.setHost, userID: value);
                    if (mounted) {
                      widget.onOperation?.call(context, OperationType.leave);
                    }
                  });
                }),
          );
        }, onTap3: () {
          widget.onOperation?.call(ctx, OperationType.end);
        });
      } else {
        MeetingPopMenu.showMeetingWidget(ctx, onTap2: () {
          widget.onOperation?.call(ctx, OperationType.leave);
        });
      }
    }
  }

  void _confirmSettings(MeetingSetting request) {
    Logger().printInfo(info: '========= _confirmSettings: ${request.toProto3Json()}');
    widget.onOperation?.call(context, OperationType.roomSettings, value: request);
  }

  _viewMeetingDetail({BuildContext? ctx}) {
    if (PlatformExt.isDesktop) {
      MeetingPopMenu.showMeetingDetailWidget(ctx ?? context,
          title: _meetingInfo!.meetingName,
          meetingID: _meetingInfo!.meetingID,
          invitedInfo: '',
          host: widget.hostUserInfo.nickname,
          myName: widget.room.localParticipant?.name ?? '',
          joinDurationStream: _durationController.stream);
    } else {
      OverlayWidget().showBottomSheet(
        context: context,
        child: (AnimationController? controller) => MeetingDetailSheetView(
          info: _meetingInfo!,
          hostNickname: '',
          hostUserInfo: widget.hostUserInfo,
        ),
      );
    }
  }

  void _selectDevices(BuildContext? ctx) {
    MeetingPopMenu.showSelectDevices(ctx ?? context,
        speakers: _audioOutputs ?? [],
        inputs: _audioInputs ?? [],
        defaultAudioInputDeviceID: widget.room.selectedAudioInputDeviceId,
        defaultSpeakerDeviceID: widget.room.selectedAudioOutputDeviceId, onComfirm: (value) {
      final inputs = value.inputs;
      final speakers = value.speaker;

      if (inputs != null) {
        _selectAudioInput(inputs);
      }
      if (speakers != null) {
        _selectAudioOutput(speakers);
      }
    });
  }
}
