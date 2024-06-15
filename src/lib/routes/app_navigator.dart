import 'package:get/get.dart';
import 'package:openmeeting/routes/m_pages.dart';

import 'app_pages.dart';
import 'm_navigator.dart';

class AppNavigator {
  AppNavigator._();

  static void startLogin() {
    Get.offAllNamed(AppRoutes.login);
  }

  static void startBackLogin() {
    Get.until((route) => Get.currentRoute == AppRoutes.login);
  }

  static void startMain({bool isAutoLogin = false}) {
    MNavigator.startMeeting();
  }

  static void startSplashToMain({bool isAutoLogin = false}) {
    MNavigator.startMeeting();
  }

  static startMeetingSetup() => Get.toNamed(AppRoutes.meetingSetup);

  static startChangePassword() => Get.toNamed(AppRoutes.changePassword);

  static startAboutUs() => Get.toNamed(AppRoutes.aboutUs);
}
