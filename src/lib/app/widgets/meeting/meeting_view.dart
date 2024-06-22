import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/models/define.dart';
import '../../data/models/meeting.pb.dart';
import '../../data/models/pb_extension.dart';
import '../../data/models/meeting_option.dart';
import '../../modules/meeting/meeting_room/meeting_client.dart';
import 'controls.dart';
import 'participant_info.dart';

abstract class MeetingView extends StatefulWidget {
  const MeetingView(
    this.room,
    this.listener, {
    super.key,
    required this.roomID,
    this.options = const MeetingOptions(),
    this.onOperation,
    this.onParticipantOperation,
    this.onSubjectInit,
  });

  final Room room;
  final EventsListener<RoomEvent> listener;
  final String roomID;
  final MeetingOptions options;
  final void Function<T>(BuildContext? context, OperationType type, {T? value})? onOperation;
  final Future<bool> Function<T>({OperationParticipantType type, String userID, T to})? onParticipantOperation;
  final void Function(BehaviorSubject<MeetingInfoSetting> meetingInfoChangedSubject, BehaviorSubject<List<ParticipantTrack>> participantsSubject)?
      onSubjectInit;
}

abstract class MeetingViewState<T extends MeetingView> extends State<T> {
  final meetingInfoChangedSubject = BehaviorSubject<MeetingInfoSetting>();
  final participantsSubject = BehaviorSubject<List<ParticipantTrack>>();
  final startTimerCompleter = Completer<bool>();

  bool minimize = false;

  bool _enableFullScreen = false;

  //Alignment(0.9, -0.9),
  double alignX = 0.9;
  double alignY = -0.9;

  MeetingInfoSetting? meetingInfo;

  String? watchedUserID;

  String? wasClickedUserID;

  bool get joinDisabledMicrophone => meetingInfo?.setting.disableMicrophoneOnJoin == true;

  bool get joinDisabledVideo => meetingInfo?.setting.disableCameraOnJoin == true;

  String? get hostUserID => meetingInfo?.creatorUserID;

  bool get _isLandscapeScreen {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape;
  }

  @override
  void initState() {
    widget.onSubjectInit?.call(meetingInfoChangedSubject, participantsSubject);
    super.initState();
  }

  @override
  void dispose() {
    meetingInfoChangedSubject.close();
    participantsSubject.close();
    _portraitScreen();
    super.dispose();
  }

  customWatchedUser(String userID);

  /// 设置当前被看的流
  setWatchedTrack(ParticipantTrack track) {
    return track;
  }

  onMoveSmallWindow(DragUpdateDetails details) {
    final globalDy = details.globalPosition.dy;
    final globalDx = details.globalPosition.dx;
    setState(() {
      alignX = (globalDx - .5.sw) / .5.sw;
      alignY = (globalDy - .5.sh) / .5.sh;
    });
  }

  onTapMinimize() async {
    _portraitScreen();
    setState(() {
      minimize = true;
    });
  }

  onTapMaximize() {
    setState(() {
      minimize = false;
    });
  }

  onInviteMembers() async {
    onTapMinimize();
    Logger().printInfo(info: '========= onInviteMembers =======');
  }

  void rotateScreen() {
    if (_isLandscapeScreen) {
      _portraitScreen();
    } else {
      _landscapeScreen();
    }
  }

  void _portraitScreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if (mounted) {
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {});
      });
    }
  }

  void _landscapeScreen() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {});
    });
  }

  void toggleFullScreen() {
    setState(() {
      _enableFullScreen = !_enableFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          AnimatedScale(
            scale: minimize ? 0 : 1,
            alignment: Alignment(alignX, alignY),
            duration: const Duration(milliseconds: 200),
            onEnd: () {},
            child: Material(
              color: PlatformExt.isDesktop ? Colors.white : Styles.c_000000,
              child: Stack(
                children: [
                  // ImageRes.liveBg.toImage
                  //   ..fit = BoxFit.cover
                  //   ..width = 1.sw
                  //   ..height = 1.sh,
                  if (widget.room.localParticipant != null)
                    ControlsView(
                      widget.room,
                      widget.room.localParticipant!,
                      meetingInfoChangedSubject: meetingInfoChangedSubject,
                      // onClose: widget.onClose,
                      onMinimize: onTapMinimize,
                      onInviteMembers: onInviteMembers,
                      participantsSubject: participantsSubject,
                      startTimerCompleter: startTimerCompleter,
                      enableFullScreen: _enableFullScreen,
                      options: widget.options,
                      hostUserInfo: UserInfo(userID: MeetingClient().userInfo.userID, nickname: MeetingClient().userInfo.nickname),
                      onOperation: widget.onOperation,
                      onParticipantOperation: widget.onParticipantOperation,
                      child: buildChild(),
                    ),
                ],
              ),
            ),
          ),
          if (minimize)
            Align(
              alignment: Alignment(alignX, alignY),
              // alignment: const Alignment(0.9, -0.9),
              child: AnimatedOpacity(
                opacity: minimize ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onTapMaximize,
                  onPanUpdate: onMoveSmallWindow,
                  child: Container(
                    width: 84.w,
                    height: 101.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Styles.c_0C1C33_opacity60,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageRes.meetingVideo.toImage
                          ..width = 48.w
                          ..height = 48.h,
                        8.verticalSpace,
                        StrRes.videoMeeting.toText..style = Styles.ts_FFFFFF_12sp,
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );

  Widget buildChild();
}
