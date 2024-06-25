import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/user_info.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

import 'sp_util.dart';

class DataSp {
  static const _loginCertificate = 'loginCertificate';
  static const _loginAccount = 'loginAccount';
  static const _deviceID = 'deviceID';
  static const _ignoreUpdate = 'ignoreUpdate';
  static const _language = "language";

  static const _meetingEnableMicrophone = '%s_meetingEnableMicrophone';
  static const _meetingEnableSpeaker = '%s_meetingEnableSpeaker';
  static const _meetingEnableVideo = '%s_meetingEnableVideo';
  static const _meetingEnableVideoMirroring = '%s_meetingEnableVideoMirroring';
  static const _meetingClientIsBusy = '_meetingClientIsBusy';

  DataSp._();

  static init() async {
    await SpUtil().init();
  }

  static String getKey(String key, {String key2 = ""}) {
    return sprintf(key, [userID, key2]);
  }

  static String? get token => getLoginCertificate()?.token;

  static String? get userID => getLoginCertificate()?.userId;

  static Future<bool>? putLoginCertificate(UserInfo lc) {
    final result = lc.toMap();

    return SpUtil().putObject(_loginCertificate, result);
  }

  static Future<bool>? putLoginAccount(Map map) {
    return SpUtil().putObject(_loginAccount, map);
  }

  static UserInfo? getLoginCertificate() {
    return SpUtil().getObj(_loginCertificate, (v) => UserInfo.fromMap(v.cast()));
  }

  static Future<bool>? removeLoginCertificate() {
    return SpUtil().remove(_loginCertificate);
  }

  static Map? getLoginAccount() {
    return SpUtil().getObject(_loginAccount);
  }

  static String getDeviceID() {
    String id = SpUtil().getString(_deviceID) ?? '';
    if (id.isEmpty) {
      id = const Uuid().v4();
      SpUtil().putString(_deviceID, id);
    }
    return id;
  }

  static Future<bool>? putIgnoreVersion(String version) {
    return SpUtil().putString(_ignoreUpdate, version);
  }

  static String? getIgnoreVersion() {
    return SpUtil().getString(_ignoreUpdate);
  }

  static Future<bool>? putLanguage(int index) {
    return SpUtil().putInt(_language, index);
  }

  static int? getLanguage() {
    return SpUtil().getInt(_language);
  }

  static Future<bool>? putMeetingEnableMicrophone(bool enable) {
    return SpUtil().putBool(getKey(_meetingEnableMicrophone), enable);
  }

  static bool getMeetingEnableMicrophone() {
    return SpUtil().getBool(getKey(_meetingEnableMicrophone), defValue: true) ?? true;
  }

  static Future<bool>? putMeetingEnableSpeaker(bool enable) {
    return SpUtil().putBool(getKey(_meetingEnableSpeaker), enable);
  }

  static bool getMeetingEnableSpeaker() {
    return SpUtil().getBool(getKey(_meetingEnableSpeaker), defValue: true) ?? true;
  }

  static Future<bool>? putMeetingEnableVideo(bool enable) {
    return SpUtil().putBool(getKey(_meetingEnableVideo), enable);
  }

  static bool getMeetingEnableVideo() {
    return SpUtil().getBool(getKey(_meetingEnableVideo), defValue: false) ?? false;
  }

  static Future<bool>? putMeetingEnableVideoMirroring(bool enable) {
    return SpUtil().putBool(getKey(_meetingEnableVideoMirroring), enable);
  }

  static bool getMeetingEnableVideoMirroring() {
    return SpUtil().getBool(getKey(_meetingEnableVideoMirroring), defValue: false) ?? false;
  }

  static Future<bool>? putMeetingClientIsBusy(bool isBusy) {
    Logger.print("==== putMeetingClientIsBusy: $isBusy");
    return SpUtil().putBool(_meetingClientIsBusy, isBusy);
  }

  static bool getMeetingClientIsBusy() {
    Logger.print("==== getMeetingClientIsBusy: ${SpUtil().getBool(_meetingClientIsBusy, defValue: false)}");
    return SpUtil().getBool(_meetingClientIsBusy, defValue: false) ?? false;
  }
}
