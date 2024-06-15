import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';

class MeetingSettingsSheetView extends StatefulWidget {
  const MeetingSettingsSheetView({
    super.key,
    this.controller,
    this.allowParticipantUnmute = true,
    this.allowParticipantVideo = true,
    this.onlyHostCanInvite = false,
    this.onlyHostCanShareScreen = true,
    this.joinMeetingDefaultMute = true,
    this.onConfirm,
  });
  final AnimationController? controller;
  final bool allowParticipantUnmute;
  final bool allowParticipantVideo;
  final bool onlyHostCanShareScreen;
  final bool onlyHostCanInvite;
  final bool joinMeetingDefaultMute;
  final ValueChanged<MeetingSetting>? onConfirm;

  @override
  State<MeetingSettingsSheetView> createState() => _MeetingSettingsSheetViewState();
}

class _MeetingSettingsSheetViewState extends State<MeetingSettingsSheetView> {
  bool _allowParticipantUnmute = true;
  bool _allowParticipantVideo = true;
  bool _onlyHostCanShareScreen = true;
  bool _onlyHostCanInvite = false;
  bool _joinMeetingDefaultMute = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _allowParticipantUnmute = widget.allowParticipantUnmute;
    _allowParticipantVideo = widget.allowParticipantVideo;
    _onlyHostCanShareScreen = widget.onlyHostCanShareScreen;
    _onlyHostCanInvite = widget.onlyHostCanInvite;
    _joinMeetingDefaultMute = widget.joinMeetingDefaultMute;
    super.initState();
  }

  _onAllowParticipantUnmute(value) {
    setState(() {
      _allowParticipantUnmute = value;
    });
  }

  _onAllowParticipantVideo(value) {
    setState(() {
      _allowParticipantVideo = value;
    });
  }

  _onOnlyHostCanShareScreen(value) {
    setState(() {
      _onlyHostCanShareScreen = value;
    });
  }

  _onJoinMeetingDefaultMute(value) {
    setState(() {
      _joinMeetingDefaultMute = value;
    });
  }

  _onOnlyHostCanInvite(value) {
    setState(() {
      _onlyHostCanInvite = value;
    });
  }

  _confirm() => widget.controller?.reverse().then(
        (value) => widget.onConfirm?.call(
          MeetingSetting(
              canParticipantsUnmuteMicrophone: _allowParticipantUnmute,
              canParticipantsEnableCamera: _allowParticipantVideo,
              canParticipantsShareScreen: !_onlyHostCanShareScreen,
              disableMicrophoneOnJoin: _joinMeetingDefaultMute),
        ),
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Styles.c_FFFFFF,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.r),
              topRight: Radius.circular(14.r),
            ),
          ),
          child: Column(
            children: [
              14.verticalSpace,
              Stack(
                alignment: Alignment.center,
                children: [
                  StrRes.meetingSettings.toText..style = Styles.ts_0C1C33_17sp_medium,
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: _confirm,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 16.w,
                        ),
                        child: StrRes.determine.toText..style = Styles.ts_0089FF_17sp,
                      ),
                    ),
                  )
                ],
              ),
              11.verticalSpace,
              _buildItemView(
                label: StrRes.allowMembersOpenMic,
                value: _allowParticipantUnmute,
                onChanged: _onAllowParticipantUnmute,
              ),
              _buildItemView(
                label: StrRes.allowMembersOpenVideo,
                value: _allowParticipantVideo,
                onChanged: _onAllowParticipantVideo,
              ),
              _buildItemView(
                label: StrRes.onlyHostShareScreen,
                value: _onlyHostCanShareScreen,
                onChanged: _onOnlyHostCanShareScreen,
              ),
              /*
              _buildItemView(
                label: StrRes.onlyHostInviteMember,
                value: _onlyHostCanInvite,
                onChanged: _onOnlyHostCanInvite,
              ),
               */
              _buildItemView(
                label: StrRes.defaultMuteMembers,
                value: _joinMeetingDefaultMute,
                onChanged: _onJoinMeetingDefaultMute,
              ),
            ],
          ),
        ),
      );

  Widget _buildItemView({
    required String label,
    required bool value,
    ValueChanged<bool>? onChanged,
  }) =>
      Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Expanded(
              child: label.toText..style = Styles.ts_0C1C33_17sp,
            ),
            CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: Styles.c_0089FF,
            ),
          ],
        ),
      );
}
