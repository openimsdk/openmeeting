import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';

import '../../../widgets/meeting/desktop/meeting_alert_dialog.dart';
import 'join_meeting_controller.dart';

class JoinMeetingPage extends GetView<JoinMeetingController> {
  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: TitleBar.back(title: StrRes.joinMeeting),
        backgroundColor: Styles.c_F8F9FA,
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                12.verticalSpace,
                _buildInputItemView(
                  label: StrRes.meetingNo,
                  hintText: StrRes.plsInputMeetingNo,
                  controller: controller.meetingNumberCtrl,
                ),
                // _buildInputItemView(
                //   label: StrRes.password,
                //   hintText: StrRes.enterMeetingPasswordHint,
                //   controller: controller.enterPswCtrl,
                // ),
                10.verticalSpace,
                _buildItemView(
                  label: StrRes.enableMicrophone,
                  switchOn: controller.isEnableMicrophone.value,
                  onChanged: (_) => controller.toggleMicrophoneStatus(),
                  showSwitchButton: true,
                ),
                _buildItemView(
                  label: StrRes.enableSpeaker,
                  switchOn: controller.isEnableSpeaker.value,
                  onChanged: (_) => controller.toggleSpeakerStatus(),
                  showSwitchButton: true,
                ),
                _buildItemView(
                  label: StrRes.enableVideo,
                  switchOn: controller.isEnableVideo.value,
                  onChanged: (_) => controller.toggleVideoStatus(),
                  showSwitchButton: true,
                ),
                Button(
                  text: StrRes.enterMeeting,
                  onTap: () async {
                    showCheckPasswordDialog();
                  },
                  enabled: controller.enabled.value,
                  margin: EdgeInsets.symmetric(
                    horizontal: 72.w,
                    vertical: 90.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemView({
    required String label,
    TextStyle? textStyle,
    String? value,
    bool switchOn = false,
    bool isTopRadius = false,
    bool isBottomRadius = false,
    bool showRightArrow = false,
    bool showSwitchButton = false,
    ValueChanged<bool>? onChanged,
    Function()? onTap,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: Ink(
          decoration: BoxDecoration(
            color: Styles.c_FFFFFF,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(isTopRadius ? 6.r : 0),
              topLeft: Radius.circular(isTopRadius ? 6.r : 0),
              bottomLeft: Radius.circular(isBottomRadius ? 6.r : 0),
              bottomRight: Radius.circular(isBottomRadius ? 6.r : 0),
            ),
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 58.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  label.toText..style = textStyle ?? Styles.ts_0C1C33_17sp,
                  const Spacer(),
                  // if (null != value)
                  //   value.toText..style = Styles.ts_8E9AB0_17sp,
                  if (showSwitchButton)
                    CupertinoSwitch(
                      value: switchOn,
                      activeColor: Styles.c_0089FF,
                      onChanged: onChanged,
                    ),
                  if (showRightArrow)
                    ImageRes.rightArrow.toImage
                      ..width = 24.w
                      ..height = 24.h,
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildInputItemView({
    required String label,
    TextEditingController? controller,
    String? hintText,
    Function()? onTap,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
          height: 58.h,
          color: Styles.c_FFFFFF,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 80.w),
                child: label.toText..style = Styles.ts_0C1C33_17sp_medium,
              ),
              10.horizontalSpace,
              Expanded(
                child: TextField(
                  style: Styles.ts_0C1C33_17sp,
                  controller: controller,
                  decoration: InputDecoration(
                    hintStyle: Styles.ts_8E9AB0_17sp,
                    hintText: hintText,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> showCheckPasswordDialog() async {
    final info = await controller.getMeetingInfo();

    if (info == null) {
      IMViews.showToast(StrRes.wrongMeetingNo);
      return;
    }

    if (!info.shouldCheckPassword || info.creatorUserID == controller.userInfo.userId) {
      controller.joinMeeting(null);
      return;
    }
    MeetingAlertDialog.showEnterMeetingWithPasswordDialog(Get.context!, info.creatorNickname, onConfirm: (password) async {
      final result = await controller.joinMeeting(password);

      if (!result) {
        IMViews.showToast(StrRes.wrongMeetingPassword);
      }
    });
  }
}
