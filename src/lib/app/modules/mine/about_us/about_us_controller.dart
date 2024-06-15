import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/app_controller.dart';

class AboutUsController extends GetxController {
  final version = "".obs;
  final buildNumber = "".obs;
  final appName = "App".obs;
  final appLogic = Get.find<AppController>();
  final uploadLogsProgress = (0.0).obs;

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    appName.value = packageInfo.appName;
    buildNumber.value = packageInfo.buildNumber;
  }

  void checkUpdate() {
    // appLogic.checkUpdate();
  }

  void uploadLogs() async {
    uploadLogsProgress.value = 0.01;
  }

  @override
  void onReady() {
    getPackageInfo();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
