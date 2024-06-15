import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'meeting_setup_controller.dart';

class MeetingSetupPage extends GetView<MeetingSetupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformExt.isDesktop
          ? null
          : TitleBar.back(
              title: StrRes.meetingSettings,
            ),
      backgroundColor: Styles.c_F8F9FA,
      body: Obx(() => SingleChildScrollView(
            child: Column(
              children: [
                10.verticalSpace,
                _buildItemView(
                  label: StrRes.enableMicrophone,
                  switchOn: controller.isEnableMicrophone.value,
                  onChanged: (_) => controller.toggleMicrophoneStatus(),
                  showSwitchButton: true,
                  isTopRadius: true,
                ),
                _buildItemView(
                  label: StrRes.enableSpeaker,
                  switchOn: controller.isEnableSpeaker.value,
                  onChanged: (_) => controller.toggleSpeakerStatus(),
                  showSwitchButton: true,
                  isBottomRadius: true,
                ),
                10.verticalSpace,
                _buildItemView(
                  label: StrRes.enableVideo,
                  switchOn: controller.isEnableVideo.value,
                  onChanged: (_) => controller.toggleVideoStatus(),
                  showSwitchButton: true,
                  isTopRadius: true,
                ),
                _buildItemView(
                  label: StrRes.videoMirror,
                  switchOn: controller.videoIsMirroring.value,
                  onChanged: (_) => controller.toggleVideoMirroring(),
                  showSwitchButton: true,
                  isBottomRadius: true,
                )
              ],
            ),
          )),
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
              height: 46.h,
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
}
