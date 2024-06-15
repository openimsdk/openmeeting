import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openmeeting/core/api_service.dart';

import 'core/data_sp.dart';

class Config {
  static Future init(Function() runApp) async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await DataSp.init();
      ApiService().setBaseUrl(_baseUrl);

      if (DataSp.userID?.isNotEmpty == true && DataSp.token?.isNotEmpty == true) {
        ApiService().setToken(DataSp.token!);
      }
    } catch (_) {}

    runApp();

    if (Platform.isIOS || Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: brightness,
        statusBarIconBrightness: brightness,
      ));
    }
  }

  static const uiW = 375.0;
  static const uiH = 812.0;

  static const double textScaleFactor = 1.0;

  static const _host = '150.109.93.151';

  static const _ipRegex = '((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)';

  static bool get _isIP => RegExp(_ipRegex).hasMatch(_host);

  static String get _baseUrl {
    return _isIP ? 'http://$_host:10002' : 'https://$_host/';
  }
}
