import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_controller.dart';
import '../../../core/data_sp.dart';
import '../../../core/push_controller.dart';
import '../../../routes/app_navigator.dart';
import 'package:openim_common/openim_common.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/apis.dart';

class LoginController extends GetxController {
  final pushLogic = Get.find<PushController>();
  final accountCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final obscureText = true.obs;
  final enabled = false.obs;
  final versionInfo = ''.obs;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    accountCtrl.addListener(_onChanged);
    pwdCtrl.addListener(_onChanged);
    _initData();

    if (DataSp.userID?.isNotEmpty == true && DataSp.token?.isNotEmpty == true) {
      login();
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getPackageInfo();
  }

  _initData() {
    var map = DataSp.getLoginAccount();
    if (map is Map) {
      String? account = map["account"];
      if (account != null && account.isNotEmpty) {
        accountCtrl.text = account;
      }
      String? pwd = map["password"];
      if (pwd != null && pwd.isNotEmpty) {
        pwdCtrl.text = pwd;
      }
    }
  }

  _onChanged() {
    enabled.value = accountCtrl.text.trim().isNotEmpty && pwdCtrl.text.trim().isNotEmpty;
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
      final userInfo = await Apis.login(
        account: accountCtrl.text.trim(),
        password: pwdCtrl.text.trim(),
      );

      if (userInfo == null) {
        return false;
      }

      final account = {"account": accountCtrl.text.trim(), 'userInfo': userInfo.toJson(), 'password': pwdCtrl.text.trim()};
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
