import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'about_us_controller.dart';

class AboutUsPage extends GetView<AboutUsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.back(title: StrRes.aboutUs),
      backgroundColor: Styles.c_F8F9FA,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Styles.c_FFFFFF,
              borderRadius: BorderRadius.circular(6.r),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                23.verticalSpace,
                ImageRes.splashLogo.toImage
                  ..width = 55.w
                  ..height = 78.h,
                10.verticalSpace,
                Obx(() => '${controller.appName} ${controller.version.value}+${controller.buildNumber.value}'.toText..style = Styles.ts_0C1C33_14sp),
                16.verticalSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  color: Styles.c_E8EAEF,
                  height: .5,
                ),
                if (Platform.isAndroid)
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: controller.checkUpdate,
                    child: Container(
                      height: 57.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          StrRes.checkNewVersion.toText..style = Styles.ts_0C1C33_17sp,
                          const Spacer(),
                          ImageRes.rightArrow.toImage
                            ..width = 24.w
                            ..height = 24.h,
                        ],
                      ),
                    ),
                  ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: controller.uploadLogs,
                  child: Container(
                    height: 57.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        StrRes.uploadErrorLog.toText..style = Styles.ts_0C1C33_17sp,
                        const Spacer(),
                        ImageRes.rightArrow.toImage
                          ..width = 24.w
                          ..height = 24.h,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
