import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:openmeeting/app/widgets/meeting/desktop/meeting_alert_dialog.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/models/define.dart';
import '../../data/models/meeting.pb.dart';
import 'overlay_widget.dart';
import 'participant_info.dart';

class MeetingMembersSheetView extends StatefulWidget {
  const MeetingMembersSheetView({
    super.key,
    required this.participantsSubject,
    required this.meetingInfoChangedSubject,
    this.controller,
    required this.localUerID,
    this.onOperation,
  });

  final BehaviorSubject<List<ParticipantTrack>> participantsSubject;
  final BehaviorSubject<MeetingInfoSetting> meetingInfoChangedSubject;
  final AnimationController? controller;
  final String localUerID;
  final Future<bool> Function<T>({OperationParticipantType type, String userID, T to})? onOperation;

  @override
  State<MeetingMembersSheetView> createState() => _MeetingMembersSheetViewState();
}

class _MeetingMembersSheetViewState extends State<MeetingMembersSheetView> {
  late StreamSubscription _pSub;
  late StreamSubscription _iSub;
  MeetingInfoSetting? _meetingInfo;
  MeetingSetting? get setting => _meetingInfo?.setting;
  final List<ParticipantTrack> _participantTracks = [];
  // List<String> get _pinedUserIDList => setting?.pinedUserIDList ?? [];

  // List<String> get _beWatchedUserIDList => setting?.beWatchedUserIDList ?? [];

  ValueNotifier<({bool cameraIsEnable, bool micIsEnable, String nickname, String userID})> valueNotifier =
      ValueNotifier((cameraIsEnable: false, micIsEnable: false, nickname: '', userID: ''));

  bool get _isHost => _meetingInfo?.hostUserID == widget.localUerID;

  @override
  void initState() {
    _pSub = widget.participantsSubject.listen(_onChangedParticipants);
    _iSub = widget.meetingInfoChangedSubject.listen(_onChangedMeetingInfo);
    super.initState();
  }

  @override
  void dispose() {
    _pSub.cancel();
    _iSub.cancel();
    valueNotifier.dispose();
    super.dispose();
  }

  void _onChangedParticipants(List<ParticipantTrack> list) {
    if (!mounted) return;
    setState(() {
      _participantTracks.clear();
      _participantTracks.addAll(list);
    });
  }

  void _onChangedMeetingInfo(meetingInfo) {
    if (!mounted) return;
    setState(() {
      _meetingInfo = meetingInfo;
    });
  }

  void _muteAll() {
    widget.onOperation?.call(type: OperationParticipantType.muteAll, to: true);
  }

  void _unmuteAll() {
    widget.onOperation?.call(type: OperationParticipantType.muteAll, to: false);
  }

  void _pinThisMember(String userID, bool pined) async {
    await widget.onOperation?.call(type: OperationParticipantType.pined, userID: userID, to: pined);
  }

  void _allSeeHim(String userID, bool seeHim) async {
    await widget.onOperation?.call(type: OperationParticipantType.focus, userID: userID, to: seeHim);
  }

  void _onTapCamera(String userID, bool value) async {
    await widget.onOperation?.call(type: OperationParticipantType.camera, userID: userID, to: value);
  }

  void _onTapMic(String userID, bool value) async {
    await widget.onOperation?.call(type: OperationParticipantType.microphone, userID: userID, to: value);
  }

  void _onTapMore(BuildContext ctx, String userID, String nickname) {
    final itemIsHost = userID == _meetingInfo?.hostUserID;

    MeetingAlertDialog.showMemberSetting(context, valueNotifier: valueNotifier, onEnableCamera: () {
      _onTapCamera(userID, !valueNotifier.value.cameraIsEnable);
    }, onEnableMic: () {
      _onTapMic(userID, !valueNotifier.value.micIsEnable);
    }, onChangeNickname: () {
      MeetingAlertDialog.showInputText(context, title: StrRes.changeNickname, nickname: nickname, onConfirm: (value) {
        Logger.print('change nickname: $value');
        widget.onOperation?.call(type: OperationParticipantType.nickname, userID: userID, to: value);
      });
    },
        onSetHost: itemIsHost
            ? null
            : () {
                widget.onOperation?.call(type: OperationParticipantType.setHost, userID: userID);
              },
        onKickoff: itemIsHost
            ? null
            : () {
                widget.onOperation?.call(type: OperationParticipantType.kickoff, userID: userID);
              });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          constraints: BoxConstraints(maxHeight: 500.h),
          decoration: BoxDecoration(
            color: Styles.c_FFFFFF,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.r),
              topRight: Radius.circular(14.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 2,
                  ),
                  Container(
                    height: 52.h,
                    alignment: Alignment.center,
                    child: StrRes.members.toText..style = Styles.ts_0C1C33_17sp_medium,
                  ),
                  Spacer(),
                  CupertinoButton(
                      child: Icon(Icons.close),
                      onPressed: () {
                        widget.controller?.reverse();
                      })
                ],
              ),
              Flexible(
                  child: ListView.builder(
                padding: EdgeInsets.only(top: 7.h),
                itemCount: _participantTracks.length,
                itemBuilder: (_, index) => _buildItemView(context, _participantTracks.elementAt(index).participant),
              )),
              if (_isHost) _buildButton(),
              12.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemView(BuildContext ctx, Participant participant) {
    String? nickname;
    String? faceURL;
    String userID = participant.identity;

    final isMicrophoneEnabled = participant.isMicrophoneEnabled();
    final isCameraEnabled = participant.isCameraEnabled();

    Logger.print('====participant.identity:$userID, participant.isCameraEnabled: ${participant.isCameraEnabled()}, participant.isMicrophoneEnabled:'
        ' ${participant.isMicrophoneEnabled()}');
    try {
      var data = json.decode(participant.metadata!);
      final userInfo = UserInfo()..mergeFromProto3Json(data['userInfo']);
      userID = userInfo.userID;
      nickname = userInfo.nickname;
      // faceURL = userInfo.faceURL;
      if (valueNotifier.value.userID == userID) {
        Future.delayed(const Duration(milliseconds: 100), () {
          valueNotifier.value = (userID: userID, nickname: nickname ?? '', cameraIsEnable: isCameraEnabled, micIsEnable: isMicrophoneEnabled);
        });
      }
    } catch (e, s) {
      Logger.print('error: $e   stack$s');
    }

    var isHost = _meetingInfo?.hostUserID == userID;

    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          AvatarView(url: faceURL, text: nickname),
          10.horizontalSpace,
          Expanded(
            child: Container(
              height: 60.h,
              decoration: BoxDecoration(
                border: BorderDirectional(
                  bottom: BorderSide(color: Styles.c_E8EAEF, width: 1),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: (nickname ?? '').toText
                          ..style = Styles.ts_0C1C33_17sp
                          ..maxLines = 1
                          ..overflow = TextOverflow.ellipsis,
                      ),
                      if (_isHost)
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: (isMicrophoneEnabled ? ImageRes.meetingMicOnGray : ImageRes.meetingMicOffGray).toImage
                            ..width = 30.w
                            ..height = 30.h
                            ..onTap = () => _onTapMic(userID, !isMicrophoneEnabled),
                        ),
                      if (_isHost)
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: (isCameraEnabled ? ImageRes.meetingCameraOnGray : ImageRes.meetingCameraOffGray).toImage
                            ..width = 30.w
                            ..height = 30.h
                            ..onTap = () => _onTapCamera(userID, !isCameraEnabled),
                        ),
                      if (_isHost)
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: ImageRes.meetingMore.toImage
                            ..width = 30.w
                            ..height = 30.h
                            ..onTap = () {
                              valueNotifier.value =
                                  (userID: userID, nickname: nickname ?? '', cameraIsEnable: isCameraEnabled, micIsEnable: isMicrophoneEnabled);
                              _onTapMore(ctx, userID, nickname ?? '');
                            },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPopButton({
    required String userID,
    required bool isPined,
    required bool isSeeHim,
  }) {
    Widget popItemView({
      required String text,
      Function()? onTap,
      bool underline = false,
    }) =>
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Container(
            height: 48.h,
            width: 117.w,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: underline
                ? BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(color: Styles.c_E8EAEF, width: 1),
                    ),
                  )
                : null,
            child: text.toText
              ..style = Styles.ts_0C1C33_17sp
              ..maxLines = 1
              ..overflow = TextOverflow.ellipsis,
          ),
        );
    final completer = Completer<bool>();

    return OverlayPopupMenuButton(
      closePopMenuCompleter: completer,
      builder: (controller) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Styles.c_FFFFFF,
          boxShadow: [
            BoxShadow(
              color: Styles.c_000000_opacity15,
              offset: Offset(0, 4.h),
              blurRadius: 4.r,
              spreadRadius: 1.r,
            ),
          ],
        ),
        child: Column(
          children: [
            popItemView(
              text: isPined ? StrRes.unpinThisMember : StrRes.pinThisMember,
              underline: true,
              // onTap: () => controller?.reverse().then((value) {}),
              onTap: () {
                completer.complete(true);
                _pinThisMember(userID, !isPined);
              },
            ),
            popItemView(
              text: isSeeHim ? StrRes.cancelAllSeeHim : StrRes.allSeeHim,
              underline: true,
              // onTap: () => controller?.reverse().then((value) {}),
              onTap: () {
                completer.complete(true);
                _allSeeHim(userID, !isSeeHim);
              },
            ),
          ],
        ),
      ),
      child: Container(
        width: 30.w,
        height: 30.h,
        margin: EdgeInsets.only(left: 16.w),
        alignment: Alignment.center,
        child: ImageRes.meetingMore.toImage
          ..width = 22.w
          ..height = 22.h,
      ),
    );
  }

  Widget _buildButton() => Container(
        height: 66.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: _isHost
            ? Row(
                children: [
                  // _buildTextButton(text: StrRes.invite, onTap: _invite),
                  // 10.horizontalSpace,
                  _buildTextButton(text: StrRes.muteAll, onTap: _muteAll),
                  10.horizontalSpace,
                  _buildTextButton(text: StrRes.unmuteAll, onTap: _unmuteAll),
                ],
              )
            : Container() /*_buildTextButton(text: StrRes.invite, onTap: _invite, expanded: false)*/,
      );

  Widget _buildTextButton({
    required String text,
    Function()? onTap,
    bool expanded = true,
  }) {
    final button = GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 36.h,
        decoration: BoxDecoration(
          border: Border.all(color: Styles.c_E8EAEF, width: 1),
          borderRadius: BorderRadius.circular(6.r),
        ),
        alignment: Alignment.center,
        child: text.toText..style = Styles.ts_0089FF_14sp_medium,
      ),
    );
    return expanded ? Expanded(child: button) : button;
  }
}
