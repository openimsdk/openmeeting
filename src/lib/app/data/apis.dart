import 'dart:async';

import 'package:dio/dio.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/user_info.dart';
import 'package:openmeeting/core/api_service.dart';

import '../../core/data_sp.dart';
import 'urls.dart';

class Apis {
  static Options get options => Options(headers: {'token': DataSp.token});
  static String? get userID => DataSp.userID;

  static Future _showHud<T>(Future<T> Function() asyncFunction, {bool show = true}) {
    return show ? LoadingView.singleton.wrap(asyncFunction: asyncFunction) : asyncFunction();
  }

  static Future<UserInfo?> login({
    String? account,
    String? password,
  }) async {
    try {
      final data = await _showHud(
        () => ApiService().post(
          Urls.login,
          data: {
            'account': account,
            'password': password,
          },
        ),
      );

      final userInfo = UserInfo.fromMap(data!);
      await DataSp.putLoginCertificate(userInfo);
      ApiService().setToken(userInfo.token);

      return userInfo;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future<UpgradeInfoV2> checkUpgradeV2() {
    return ApiService().dio.post<Map<String, dynamic>>(
      'https://www.pgyer.com/apiv2/app/check',
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
      ),
      data: {
        '_api_key': '6f43600074306e8bc506ed0cd3275e9e',
        'appKey': '657cad6c9247f3f5c9520bcf0c2b6415',
      },
    ).then((resp) {
      Map<String, dynamic> map = resp.data!;
      if (map['code'] == 0) {
        return UpgradeInfoV2.fromJson(map['data']);
      }
      return Future.error(map);
    });
  }

  static Future getMeetings(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.getMeetings,
          data: params,
        ),
        show: false,
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future getMeeting(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.getMeeting,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future bookingMeeting(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(Urls.booking, data: params),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future quicklyMeeting(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(Urls.quickly, data: params),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future joinMeeting(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(Urls.join, data: params),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return null;
    }
  }

  static Future createMeeting(String path, Map<String, dynamic> params) async {
    return await _showHud(
      () => ApiService().post(path, data: params),
    );
  }

  static Future getLiveKitToken(String meetingID, String userID) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.getLiveToken,
          data: {'meetingID': meetingID, 'userID': userID},
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future leaveMeeting(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.leaveMeeting,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future endMeeting(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.endMeeting,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future setPersonalSetting(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.setPersonalSetting,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future updateMeetingSetting(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.updateSetting,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future operateAllStream(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.operateAllStream,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future<bool> modifyParticipantName(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.modifyParticipantName,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());

      return Future.error(e);
    }
  }

  static Future<bool> kickParticipant(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.kickParticipants,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());
      return Future.error(e);
    }
  }

  static Future<bool> setMeetingHost(Map<String, dynamic> params) async {
    try {
      final result = await _showHud(
        () => ApiService().post(
          Urls.setMeetingHost,
          data: params,
        ),
      );

      return result;
    } catch (e, s) {
      IMViews.showToast(e.toString());
      return Future.error(e);
    }
  }
}
