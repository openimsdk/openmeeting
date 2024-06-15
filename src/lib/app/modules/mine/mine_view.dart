import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../../../routes/app_navigator.dart';
import 'mine_controller.dart';

class MinePage extends GetView<MineController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.c_F8F9FA,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 138.h,
                  width: 1.sw,
                  color: Styles.c_0089FF,
                  child: ImageRes.mineHeaderBg.toImage,
                ),
                Obx(() => _buildMyInfoView()),
              ],
            ),
            10.verticalSpace,
            _buildItemView(
              icon: ImageRes.meetingSettings,
              label: StrRes.meetingSettings,
              onTap: () {
                AppNavigator.startMeetingSetup();
              },
            ),
            _buildItemView(
              icon: ImageRes.aboutUs,
              label: StrRes.aboutUs,
              onTap: controller.aboutUs,
            ),
            _buildItemView(
              icon: ImageRes.logout,
              label: StrRes.logout,
              onTap: controller.logout,
              isBottomRadius: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyInfoView() => Container(
        height: 98.h,
        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 90.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Styles.c_FFFFFF,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            AvatarView(
              width: 48.w,
              height: 48.h,
              textStyle: Styles.ts_FFFFFF_14sp,
            ),
            10.horizontalSpace,
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: [
                  ImageRes.mineQr.toImage
                    ..width = 18.w
                    ..height = 18.h,
                  8.horizontalSpace,
                  ImageRes.rightArrow.toImage
                    ..width = 24.w
                    ..height = 24.h,
                ],
              ),
            )
          ],
        ),
      );

  Widget _buildItemView({
    required String icon,
    required String label,
    bool isTopRadius = false,
    bool isBottomRadius = false,
    Function()? onTap,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
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
              height: 56.h,
              padding: EdgeInsets.only(left: 12.w, right: 16.w),
              child: Row(
                children: [
                  icon.toImage
                    ..width = 24.w
                    ..height = 24.h,
                  11.horizontalSpace,
                  label.toText..style = Styles.ts_0C1C33_17sp,
                  const Spacer(),
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
