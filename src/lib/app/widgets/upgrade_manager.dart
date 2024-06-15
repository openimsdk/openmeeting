import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/core/api_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/data_sp.dart';
import '../data/apis.dart';
import 'upgrade_view.dart';

mixin UpgradeManger {
  PackageInfo? packageInfo;
  UpgradeInfoV2? upgradeInfoV2;
  var isShowUpgradeDialog = false;
  var isNowIgnoreUpdate = false;
  final subject = PublishSubject<double>();

  void closeSubject() {
    subject.close();
  }

  void ignoreUpdate() {
    DataSp.putIgnoreVersion(upgradeInfoV2!.buildVersion! + upgradeInfoV2!.buildVersionNo!);
    Get.back();
  }

  void laterUpdate() {
    isNowIgnoreUpdate = true;
    Get.back();
  }

  getAppInfo() async {
    packageInfo ??= await PackageInfo.fromPlatform();
  }

  void nowUpdate() async {
    if (Platform.isAndroid) {
      final result = await Permissions.notification();
      if (!result) {
        await IMViews.showToast(StrRes.upgradePermissionTips, duration: 2.seconds);
        openAppSettings();
        return;
      }
      Permissions.storage(() async {
        var fileName = '${packageInfo!.appName}-${packageInfo!.version}-${packageInfo!.buildNumber}.apk';
        var path = await IMUtils.createTempDir(dir: "apk");
        path = "$path/$fileName";
        if (await File(path).exists()) {
          AppInstaller.installApk(path);
          return;
        }
        await IMUtils.createTempFile(
          dir: 'apk',
          name: fileName,
        );
        NotificationService notificationService = NotificationService();
        ApiService().download(
          upgradeInfoV2!.downloadURL!,
          cachePath: path,
          onProgress: (int count, int total) {
            subject.add(count / total);
            notificationService.createNotification(100, ((count / total) * 100).toInt(), 0, '下载中');
            if (count == total) {
              AppInstaller.installApk(path);
            }
          },
        ).catchError((s, t) {
          notificationService.createNotification(100, 0, 0, '下载失败');
        });
      });
    } else {
      // if (await canLaunch(upgradeInfo!.url!)) {
      //   launch(upgradeInfo!.url!);
      // }
    }
  }

  void checkUpdate() async {
    if (!Platform.isAndroid) return;
    LoadingView.singleton.wrap(asyncFunction: () async {
      await getAppInfo();
      return Apis.checkUpgradeV2();
    }).then((value) {
      upgradeInfoV2 = value;
      if (!canUpdate) {
        IMViews.showToast('已是最新版本');
        return;
      }
      Get.dialog(
        UpgradeViewV2(
          upgradeInfo: upgradeInfoV2!,
          packageInfo: packageInfo!,
          onNow: nowUpdate,
          subject: subject,
        ),
        routeSettings: const RouteSettings(name: 'upgrade_dialog'),
      );
    });
  }

  /// 自动检测更新
  autoCheckVersionUpgrade() async {
    if (!Platform.isAndroid) return;
    if (isShowUpgradeDialog || isNowIgnoreUpdate) return;
    await getAppInfo();
    upgradeInfoV2 = await Apis.checkUpgradeV2();
    String? ignore = DataSp.getIgnoreVersion();
    if (ignore == upgradeInfoV2!.buildVersion! + upgradeInfoV2!.buildVersionNo!) {
      isNowIgnoreUpdate = true;
      return;
    }
    if (!canUpdate) return;
    isShowUpgradeDialog = true;
    Get.dialog(
      UpgradeViewV2(
        upgradeInfo: upgradeInfoV2!,
        packageInfo: packageInfo!,
        onLater: laterUpdate,
        onIgnore: ignoreUpdate,
        onNow: nowUpdate,
        subject: subject,
      ),
      routeSettings: const RouteSettings(name: 'upgrade_dialog'),
    ).whenComplete(() => isShowUpgradeDialog = false);
  }

  bool get canUpdate => packageInfo!.version + packageInfo!.buildNumber != upgradeInfoV2!.buildVersion! + upgradeInfoV2!.buildVersionNo!;
}

class NotificationService {
  // Handle displaying of notifications.
  static final NotificationService _notificationService = NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }

  void init() async {
    final InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void createNotification(int count, int i, int id, String status) {
    //show the notifications.
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('progress channel', 'progress channel',
        channelDescription: 'progress channel description',
        channelShowBadge: false,
        importance: Importance.max,
        priority: Priority.high,
        onlyAlertOnce: true,
        showProgress: true,
        maxProgress: count,
        progress: i);
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(id, status, '$i%', platformChannelSpecifics, payload: 'item x');
  }
}
