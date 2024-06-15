import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TouchCloseSoftKeyboard(
        isGradientBg: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              100.verticalSpace,
              ImageRes.meetingLoginLogo.toImage..width = 307.w,
              56.verticalSpace,
              InputBox(
                label: StrRes.account,
                hintText: StrRes.plsEnterAccount,
                controller: controller.accountCtrl,
                margin: EdgeInsets.symmetric(horizontal: 32.w),
              ),
              16.verticalSpace,
              InputBox.password(
                label: StrRes.password,
                hintText: StrRes.plsEnterPassword,
                controller: controller.pwdCtrl,
                margin: EdgeInsets.symmetric(horizontal: 32.w),
              ),
              73.verticalSpace,
              Obx(() => Button(
                    text: StrRes.login,
                    enabled: controller.enabled.value,
                    onTap: controller.login,
                    margin: EdgeInsets.symmetric(horizontal: 32.w),
                  )),
              32.verticalSpace,
              Obx(() => '${controller.versionInfo.value}'.toText..style = Styles.ts_0C1C33_14sp),
            ],
          ),
        ),
      ),
    );
  }
}
