import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Styles.c_0089FF_opacity10, Styles.c_FFFFFF_opacity0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 130.h,
              child: ImageRes.splashLogo.toImage
                ..width = 55.61.w
                ..height = 78.91.h,
            ),
            Obx(() => controller.versionInfo.value.toText..style = Styles.ts_0C1C33_14sp),
          ],
        ),
      ),
    );
  }
}
