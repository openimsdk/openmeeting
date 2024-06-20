import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uri_to_file/uri_to_file.dart';

/// 间隔时间完成某事
class IntervalDo {
  DateTime? last;
  Timer? lastTimer;

  //call---milliseconds---call
  void run({required Function() fuc, int milliseconds = 0}) {
    DateTime now = DateTime.now();
    if (null == last || now.difference(last ?? now).inMilliseconds > milliseconds) {
      last = now;
      fuc();
    }
  }

  //---milliseconds----milliseconds....---call  在milliseconds时连续的调用会被丢弃并重置milliseconds的时间，milliseconds后才会call
  void drop({required Function() fun, int milliseconds = 0}) {
    lastTimer?.cancel();
    lastTimer = null;
    lastTimer = Timer(Duration(milliseconds: milliseconds), () {
      lastTimer!.cancel();
      lastTimer = null;
      fun.call();
    });
  }
}

class MediaSource {
  final String url;
  final String thumbnail;

  MediaSource(this.url, this.thumbnail);
}

extension PlatformExt on Platform {
  static bool get isMobile => Platform.isIOS || Platform.isAndroid;

  static bool get isDesktop => Platform.isLinux || Platform.isMacOS || Platform.isWindows;

  static bool get isWeb => kIsWeb;
}

class IMUtils {
  IMUtils._();

  static String getSuffix(String url) {
    if (!url.contains(".")) return "";
    return url.substring(url.lastIndexOf('.'), url.length);
  }

  static bool isGif(String url) {
    return IMUtils.getSuffix(url).contains("gif");
  }

  static void copy({required String text}) {
    Clipboard.setData(ClipboardData(text: text));
    IMViews.showToast(StrRes.copySuccessfully);
  }

  static String? emptyStrToNull(String? str) => (null != str && str.trim().isEmpty) ? null : str;

  static bool isNotNullEmptyStr(String? str) => null != str && "" != str.trim();

  static bool isChinaMobile(String mobile) {
    RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(mobile);
  }

  static bool isMobile(String areaCode, String mobile) => (areaCode == '+86' || areaCode == '86') ? isChinaMobile(mobile) : true;

  static Future<String> createTempFile({
    required String dir,
    required String name,
  }) async {
    final storage = await createTempDir(dir: dir);
    File file = File('$storage/$name');
    if (!(await file.exists())) {
      file.create();
    }
    return file.path;
  }

  static Future<String> createTempDir({
    required String dir,
  }) async {
    final storage = (Platform.isIOS ? await getApplicationCacheDirectory() : await getExternalStorageDirectory());
    Directory directory = Directory('${storage!.path}/$dir');
    if (!(await directory.exists())) {
      directory.create(recursive: true);
    }
    return directory.path;
  }

  static int compareVersion(String val1, String val2) {
    var arr1 = val1.split(".");
    var arr2 = val2.split(".");
    int length = arr1.length >= arr2.length ? arr1.length : arr2.length;
    int diff = 0;
    int v1;
    int v2;
    for (int i = 0; i < length; i++) {
      v1 = i < arr1.length ? int.parse(arr1[i]) : 0;
      v2 = i < arr2.length ? int.parse(arr2[i]) : 0;
      diff = v1 - v2;
      if (diff == 0) {
        continue;
      } else {
        return diff > 0 ? 1 : -1;
      }
    }
    return diff;
  }

  static int getPlatform() {
    final context = Get.context!;
    if (Platform.isAndroid) {
      return context.isTablet ? 8 : 2;
    } else {
      return context.isTablet ? 9 : 1;
    }
  }

  // md5 加密
  static String? generateMD5(String? data) {
    if (null == data) return null;
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return digest.toString();
  }

  static Future<String> getCacheFileDir() async {
    return (await getTemporaryDirectory()).absolute.path;
  }

  static Future<String> getDownloadFileDir() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = (await getDownloadsDirectory())?.path;
      } catch (err, _) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS || Platform.isMacOS) {
      externalStorageDirPath = (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath!;
  }

  static Future<String> toFilePath(String path) async {
    var filePrefix = 'file://';
    var uriPrefix = 'content://';
    if (path.contains(filePrefix)) {
      path = path.substring(filePrefix.length);
    } else if (path.contains(uriPrefix)) {
      // Uri uri = Uri.parse(thumbnailPath); // Parsing uri string to uri
      File file = await toFile(path);
      path = file.path;
    }
    return path;
  }

  static String getChatTimeline(int ms, [String formatToday = 'HH:mm']) {
    final locTimeMs = DateTime.now().millisecondsSinceEpoch;
    final languageCode = Get.locale?.languageCode ?? 'zh';
    final isZH = languageCode == 'zh';

    if (DateUtil.isToday(ms, locMs: locTimeMs)) {
      return formatDateMs(ms, format: formatToday);
    }

    if (DateUtil.isYesterdayByMs(ms, locTimeMs)) {
      return '${isZH ? '昨天' : 'Yesterday'} ${formatDateMs(ms, format: 'HH:mm')}';
    }

    if (DateUtil.isWeek(ms, locMs: locTimeMs)) {
      return '${DateUtil.getWeekdayByMs(ms, languageCode: languageCode)} ${formatDateMs(ms, format: 'HH:mm')}';
    }

    if (DateUtil.yearIsEqualByMs(ms, locTimeMs)) {
      return formatDateMs(ms, format: isZH ? 'MM月dd HH:mm' : 'MM/dd HH:mm');
    }

    return formatDateMs(ms, format: isZH ? 'yyyy年MM月dd' : 'yyyy/MM/dd');
  }

  static String getMeetingIndexTimeline(int ms) {
    final locTimeMs = DateTime.now().millisecondsSinceEpoch;
    final languageCode = Get.locale?.languageCode ?? 'zh';
    final isZH = languageCode == 'zh';

    if (DateUtil.isToday(ms, locMs: locTimeMs)) {
      return '${isZH ? '今天' : 'Today'}  ${formatDateMs(ms, format: isZH ? 'MM月dd' : 'MM/dd')}';
    }

    if (DateUtil.isYesterdayByMs(ms, locTimeMs)) {
      return '${isZH ? '昨天' : 'Yesterday'}  ${formatDateMs(ms, format: isZH ? 'MM月dd' : 'MM/dd')}';
    }

    if (DateUtil.isWeek(ms, locMs: locTimeMs)) {
      return '${DateUtil.getWeekdayByMs(ms, languageCode: languageCode)}  ${formatDateMs(ms, format: isZH ? 'MM月dd' : 'MM/dd')}';
    }

    if (DateUtil.yearIsEqualByMs(ms, locTimeMs)) {
      return formatDateMs(ms, format: isZH ? 'MM月dd' : 'MM/dd');
    }

    return formatDateMs(ms, format: isZH ? 'yyyy年MM月dd' : 'yyyy/MM/dd');
  }

  static String getCallTimeline(int milliseconds) {
    if (DateUtil.yearIsEqualByMs(milliseconds, DateUtil.getNowDateMs())) {
      return formatDateMs(milliseconds, format: 'MM/dd');
    } else {
      return formatDateMs(milliseconds, format: 'yyyy/MM/dd');
    }
  }

  static DateTime getDateTimeByMs(int ms, {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: isUtc);
  }

  static String formatDateMs(int ms, {bool isUtc = false, String? format}) {
    return DateUtil.formatDateMs(ms, format: format, isUtc: isUtc);
  }

  static String seconds2HMS(int seconds) {
    int h = 0;
    int m = 0;
    int s = 0;
    int temp = seconds % 3600;
    if (seconds > 3600) {
      h = seconds ~/ 3600;
      if (temp != 0) {
        if (temp > 60) {
          m = temp ~/ 60;
          if (temp % 60 != 0) {
            s = temp % 60;
          }
        } else {
          s = temp;
        }
      }
    } else {
      m = seconds ~/ 60;
      if (seconds % 60 != 0) {
        s = seconds % 60;
      }
    }
    if (h == 0) {
      return '${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s}';
    }
    return "${h < 10 ? '0$h' : h}:${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s}";
  }

  static String mutedTime(int mss) {
    int days = mss ~/ (60 * 60 * 24);
    int hours = (mss % (60 * 60 * 24)) ~/ (60 * 60);
    int minutes = (mss % (60 * 60)) ~/ 60;
    int seconds = mss % 60;
    return "${_combTime(days, StrRes.day)}${_combTime(hours, StrRes.hours)}${_combTime(minutes, StrRes.minute)}${_combTime(seconds, StrRes.seconds)}";
  }

  static String _combTime(int value, String unit) => value > 0 ? '$value$unit' : '';

  /// 搜索聊天内容显示规则
  static String calContent({
    required String content,
    required String key,
    required TextStyle style,
    required double usedWidth,
  }) {
    var size = calculateTextSize(content, style);
    var lave = 1.sw - usedWidth;
    if (size.width < lave) {
      return content;
    }
    var index = content.indexOf(key);
    if (index == -1 || index > content.length - 1) return content;
    var start = content.substring(0, index);
    var end = content.substring(index);
    var startSize = calculateTextSize(start, style);
    var keySize = calculateTextSize(key, style);
    if (startSize.width + keySize.width > lave) {
      if (index - 4 > 0) {
        return "...${content.substring(index - 4)}";
      } else {
        return "...$end";
      }
    } else {
      return content;
    }
  }

  // Here it is!
  static Size calculateTextSize(
    String text,
    TextStyle style, {
    int maxLines = 1,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(text: TextSpan(text: text, style: style), maxLines: maxLines, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }

  static TextPainter getTextPainter(
    String text,
    TextStyle style, {
    int maxLines = 1,
    double maxWidth = double.infinity,
  }) =>
      TextPainter(text: TextSpan(text: text, style: style), maxLines: maxLines, textDirection: TextDirection.ltr)
        ..layout(minWidth: 0, maxWidth: maxWidth);

  static bool isUrlValid(String? url) {
    if (null == url || url.isEmpty) {
      return false;
    }
    return url.startsWith("http://") || url.startsWith("https://");
  }

  static bool isValidUrl(String? urlString) {
    if (null == urlString || urlString.isEmpty) {
      return false;
    }
    Uri? uri = Uri.tryParse(urlString);
    if (uri != null && uri.hasScheme && uri.hasAuthority) {
      return true;
    }
    return false;
  }

  static String getAtNickname(String atUserID, String atNickname) {
    // String nickname = atNickname;
    // if (atUserID == OpenIM.iMManager.uid) {
    //   nickname = StrRes.you;
    // } else if (atUserID == 'atAllTag') {
    //   nickname = StrRes.everyone;
    // }
    return atUserID == 'atAllTag' ? StrRes.everyone : atNickname;
  }

  static Future<bool> isExitFile(String? path) async {
    return isNotNullEmptyStr(path) ? await File(path!).exists() : false;
  }

  //fileExt 文件后缀名
  static String? getMediaType(final String filePath) {
    var fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
    var fileExt = fileName.substring(fileName.lastIndexOf("."));
    switch (fileExt.toLowerCase()) {
      case ".jpg":
      case ".jpeg":
      case ".jpe":
        return "image/jpeg";
      case ".png":
        return "image/png";
      case ".bmp":
        return "image/bmp";
      case ".gif":
        return "image/gif";
      case ".json":
        return "application/json";
      case ".svg":
      case ".svgz":
        return "image/svg+xml";
      case ".mp3":
        return "audio/mpeg";
      case ".mp4":
        return "video/mp4";
      case ".mov":
        return "video/mov";
      case ".htm":
      case ".html":
        return "text/html";
      case ".css":
        return "text/css";
      case ".csv":
        return "text/csv";
      case ".txt":
      case ".text":
      case ".conf":
      case ".def":
      case ".log":
      case ".in":
        return "text/plain";
    }
    return null;
  }

  /// 将字节数转化为MB
  static String formatBytes(int bytes) {
    int kb = 1024;
    int mb = kb * 1024;
    int gb = mb * 1024;
    if (bytes >= gb) {
      return sprintf("%.1f GB", [bytes / gb]);
    } else if (bytes >= mb) {
      double f = bytes / mb;
      return sprintf(f > 100 ? "%.0f MB" : "%.1f MB", [f]);
    } else if (bytes > kb) {
      double f = bytes / kb;
      return sprintf(f > 100 ? "%.0f KB" : "%.1f KB", [f]);
    } else {
      return sprintf("%d B", [bytes]);
    }
  }

  static String getWorkMomentsTimeline(int ms) {
    final locTimeMs = DateTime.now().millisecondsSinceEpoch;
    final languageCode = Get.locale?.languageCode ?? 'zh';
    final isZH = languageCode == 'zh';

    if (DateUtil.isToday(ms, locMs: locTimeMs)) {
      return isZH ? '今天' : 'Today';
    }

    if (DateUtil.isYesterdayByMs(ms, locTimeMs)) {
      return isZH ? '昨天' : 'Yesterday';
    }

    if (DateUtil.isWeek(ms, locMs: locTimeMs)) {
      return DateUtil.getWeekdayByMs(ms, languageCode: languageCode);
    }

    if (DateUtil.yearIsEqualByMs(ms, locTimeMs)) {
      return formatDateMs(ms, format: isZH ? 'MM月dd' : 'MM/dd');
    }

    return formatDateMs(ms, format: isZH ? 'yyyy年MM月dd' : 'yyyy/MM/dd');
  }

  static String getTimeFormat1() {
    bool isZh = Get.locale!.languageCode.toLowerCase().contains("zh");
    return isZh ? 'yyyy年MM月dd日' : 'yyyy/MM/dd';
  }

  static String getTimeFormat2() {
    bool isZh = Get.locale!.languageCode.toLowerCase().contains("zh");
    return isZh ? 'yyyy年MM月dd日 HH时mm分' : 'yyyy/MM/dd HH:mm';
  }

  static String getTimeFormat3() {
    bool isZh = Get.locale!.languageCode.toLowerCase().contains("zh");
    return isZh ? 'MM月dd日 HH时mm分' : 'MM/dd HH:mm';
  }

  static bool isValidPassword(String password) => RegExp(
        // r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!.])(?=.{6,20}$)',
        // r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{6,20}$',
        // r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,20}$',
        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\S]{6,20}$',
      ).hasMatch(password);

  static TextInputFormatter getPasswordFormatter() => FilteringTextInputFormatter.allow(
        // RegExp(r'[a-zA-Z0-9]'),
        RegExp(r'[a-zA-Z0-9\S]'),
      );
}
