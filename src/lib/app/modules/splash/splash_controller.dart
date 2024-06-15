import 'package:get/get.dart';
import '../../../core/app_controller.dart';
import '../../../core/data_sp.dart';
import '../../../core/push_controller.dart';
import '../../../routes/app_navigator.dart';
import 'package:openim_common/openim_common.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/apis.dart';

class SplashController extends GetxController {
  final pushLogic = Get.find<PushController>();
  final versionInfo = ''.obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getPackageInfo();

    if (DataSp.userID?.isNotEmpty == true && DataSp.token?.isNotEmpty == true) {
      login();
    } else {
      AppNavigator.startLogin();
    }
    super.onReady();
  }

  login() {
    LoadingView.singleton.wrap(asyncFunction: () async {
      var suc = await _login();
      if (suc) {
        AppNavigator.startMain();
      }
    });
  }

  Future<bool> _login() async {
    try {
      final map = DataSp.getLoginAccount();
      var accountText = '';
      var passwordText = '';
      if (map is Map) {
        String? account = map["account"];
        if (account != null && account.isNotEmpty) {
          accountText = account;
        }
        String? pwd = map["password"];
        if (pwd != null && pwd.isNotEmpty) {
          passwordText = pwd;
        }
      }

      final userInfo = await Apis.login(
        account: accountText,
        password: passwordText,
      );

      if (userInfo == null) {
        return false;
      }

      final account = {"account": accountText, 'userInfo': userInfo.toJson(), 'password': passwordText};
      await DataSp.putLoginAccount(account);
      Logger.print('login : ${userInfo.userId}, token: ${userInfo.token}');

      Get.find<AppController>().userInfo = userInfo;

      return true;
    } catch (e, s) {
      Logger.print('login e: $e $s');
    } finally {}
    return false;
  }

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final appName = packageInfo.appName;
    final buildNumber = packageInfo.buildNumber;

    versionInfo.value = '$appName $version+$buildNumber';
  }
}
