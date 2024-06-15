import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';

import '../app/data/models/user_info.dart';
import '../app/modules/meeting/meeting_room/meeting_client.dart';
import '../app/widgets/upgrade_manager.dart';
import 'data_sp.dart';
// import 'package:tray_manager/tray_manager.dart';

class AppController extends GetxController with UpgradeManger /*, TrayListener*/ {
  final _userInfo = Rx<UserInfo?>(null);

  UserInfo? get userInfo => _userInfo.value;

  set userInfo(UserInfo? value) {
    if (value != null) {
      MeetingClient().userInfo = value.toPBUser();
    }
    _userInfo.value = value;
  }

  String get userID => _userInfo.value?.userId ?? '';

  var isRunningBackground = false;
  var isAppBadgeSupported = false;

  late BaseDeviceInfo deviceInfo;

  Future<void> runningBackground(bool run) async {
    Logger.print('-----App running background : $run-------------');

    if (isRunningBackground && !run) {}
    isRunningBackground = run;

    if (!run) {}
  }

  @override
  void onInit() async {
    super.onInit();
    autoCheckVersionUpgrade();
    // trayManager.addListener(this);
  }

  @override
  void onReady() {
    super.onReady();
    _getDeviceInfo();
    // _setTrayIcon();
  }

  @override
  void onClose() {
    super.onClose();

    closeSubject();
    // trayManager.removeListener(this);
  }

  Locale? getLocale() {
    var local = Get.locale;
    var index = DataSp.getLanguage() ?? 0;
    switch (index) {
      case 1:
        local = const Locale('zh', 'CN');
        break;
      case 2:
        local = const Locale('en', 'US');
        break;
    }
    return local;
  }

  void _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    deviceInfo = await deviceInfoPlugin.deviceInfo;
  }
/*
  Future<void> _setTrayIcon() async {
    await trayManager.setIcon(
      Platform.isWindows
          ? 'launcher_icon/app-icon.ico'
          : 'launcher_icon/app-icon.png',
    );
    Menu menu = Menu(
      items: [
        MenuItem.separator(),
        MenuItem(
          key: 'exit_app',
          label: 'Quit',
        ),
        MenuItem.separator(),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    if (menuItem.key == 'exit_app') {
      exit(0);
    }
  }
 */
}
