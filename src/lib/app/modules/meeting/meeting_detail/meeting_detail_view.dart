import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:sprintf/sprintf.dart';

import '../../../widgets/meeting/desktop/meeting_alert_dialog.dart';
import 'meeting_detail_controller.dart';

class MeetingDetailPage extends GetView<MeetingDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(
        title: StrRes.meetingDetail,
        right: Row(
          children: [
            if (controller.isMine)
              ImageRes.moreBlack.toImage
                ..width = 24.w
                ..height = 24.h
                ..onTap = controller.editMeeting,
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            10.verticalSpace,
            Container(
              color: Styles.c_FFFFFF,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
                bottom: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (controller.meetingInfo.meetingName).toText..style = Styles.ts_0C1C33_17sp_medium,
                  14.verticalSpace,
                  Row(
                    children: [
                      22.horizontalSpace,
                      controller.meetingStartTime.toText..style = Styles.ts_0C1C33_20sp_medium,
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: controller.isStartedMeeting() ? Styles.c_FFB300 : Styles.c_0089FF,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 2.h,
                        ),
                        child: Text(
                          controller.isStartedMeeting() ? StrRes.started : StrRes.didNotStart,
                          style: Styles.ts_FFFFFF_12sp,
                        ),
                      ),
                      const Spacer(),
                      controller.meetingEndTime.toText..style = Styles.ts_0C1C33_20sp_medium,
                      22.horizontalSpace,
                    ],
                  ),
                  Row(
                    children: [
                      controller.meetingStartDate.toText..style = Styles.ts_8E9AB0_14sp,
                      const Spacer(),
                      Container(
                        height: 1.h,
                        width: 28.w,
                        margin: EdgeInsets.only(right: 5.w),
                        color: Styles.c_E8EAEF,
                      ),
                      controller.meetingDuration.toText..style = Styles.ts_8E9AB0_14sp,
                      Container(
                        height: 1.h,
                        width: 28.w,
                        margin: EdgeInsets.only(left: 5.w),
                        color: Styles.c_E8EAEF,
                      ),
                      const Spacer(),
                      controller.meetingEndDate.toText..style = Styles.ts_8E9AB0_14sp,
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Styles.c_FFFFFF,
              margin: EdgeInsets.only(top: 12.h),
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: Column(
                children: [
                  _buildItemView(
                    value: sprintf(StrRes.meetingNoIs, [controller.meetingNo]),
                    showCopy: true,
                    onTap: controller.copy,
                  ),
                  _buildItemView(
                    value: sprintf(StrRes.meetingOrganizerIs, [controller.meetingCreator]),
                  ),
                ],
              ),
            ),
            Button(
              text: StrRes.enterMeeting,
              onTap: () {
                showCheckPasswordDialog();
              },
              margin: EdgeInsets.symmetric(
                horizontal: 72.w,
                vertical: 90.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemView({
    String? value,
    bool showCopy = false,
    Function()? onTap,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
          height: 44.h,
          color: Styles.c_FFFFFF,
          child: Row(
            children: [
              (value ?? '').toText..style = Styles.ts_0C1C33_17sp,
              6.horizontalSpace,
              if (showCopy)
                ImageRes.mineCopy.toImage
                  ..width = 16.w
                  ..height = 16.h,
            ],
          ),
        ),
      );

void showCheckPasswordDialog() async {
    final info = controller.meetingInfo;

    if (info.creatorUserID == controller.userInfo.userId) {
      controller.enterMeeting();

      return;
    }

    final basePassword = await controller.getMeetingPassword(info.meetingID, info.creatorUserID);

    MeetingAlertDialog.showEnterMeetingWithPasswordDialog(Get.context!, info.creatorNickname,
        onConfirm: (password) async {
      final result = basePassword == password;

      if (!result) {
        IMViews.showToast(StrRes.wrongMeetingPassword);
      } else {
        controller.enterMeeting();
      }
    });
  }
}
