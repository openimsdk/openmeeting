import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'app/data/models/define.dart';
import 'app/data/models/meeting_screen_info.dart';
import 'app/modules/meeting/meeting_room/room_desktop/room_connect.dart';
import 'app/modules/mine/meeting_setup/desktop/setup_desktop.dart';
import 'app_view.dart';
import 'app/widgets/refresh_wrapper.dart';
import 'config.dart';
import 'core/push_controller.dart';
import 'routes/app_pages.dart';

class MeetingApp extends StatelessWidget {
  const MeetingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppView(
      builder: (locale, builder) => GetMaterialApp(
        debugShowCheckedModeBanner: true,
        enableLog: true,
        builder: builder,
        logWriterCallback: Logger.print,
        translations: TranslationService(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        fallbackLocale: TranslationService.fallbackLocale,
        locale: locale,
        localeResolutionCallback: (locale, list) {
          Get.locale ??= locale;
          return locale;
        },
        supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
        getPages: AppPages.mainPages,
        initialBinding: InitBinding(),
        initialRoute: AppRoutes.splash,
        theme: _themeData,
      ),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PushController>(PushController());
  }
}

class MeetingSubWindow extends StatelessWidget {
  const MeetingSubWindow({
    super.key,
    required this.args,
  });

  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    // final page = initialPage();
    return ScreenUtilInit(
        designSize: const Size(Config.uiW, Config.uiH),
        minTextAdapt: true,
        splitScreenMode: true,
        fontSizeResolver: (fontSize, _) => fontSize.toDouble(),
        builder: (context, child) {
          return RefreshWrapper(
            builder: (context) => GetMaterialApp(
              debugShowCheckedModeBanner: true,
              enableLog: true,
              builder: EasyLoading.init(builder: (context, child) {
                return _keepScaleBuilder(context, child);
              }),
              logWriterCallback: Logger.print,
              translations: TranslationService(),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              fallbackLocale: TranslationService.fallbackLocale,
              localeResolutionCallback: (locale, list) {
                Get.locale ??= locale;
                return locale;
              },
              supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
              home: homePage(),
              theme: _themeData,
            ),
          );
        });
  }

  Widget _keepScaleBuilder(BuildContext context, Widget? child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(1.0),
      ),
      child: child ?? Container(),
    );
  }

  ({GetPage<dynamic> page, String route}) initialPage() {
    final info = MeetingScreenInfo.fromMap(args);
    switch (info.type) {
      case WindowType.setting:
        return (page: AppPages.settingPage, route: AppRoutes.meetingSetup);
      default:
        return (page: AppPages.settingPage, route: AppRoutes.home);
    }
  }

  Widget homePage() {
    final info = MeetingScreenInfo.fromMap(args);
    switch (info.type) {
      case WindowType.room:
        return RoomConnectDesktopView(
          info.windowId,
          info.userInfo,
          info.certificate!,
          info.roomID!,
          options: info.options,
        );
      case WindowType.setting:
        return MeetingSetupDesktop(info.windowId);
      default:
        return Container();
    }
  }

  static TransitionBuilder _builder() => EasyLoading.init(
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: Config.textScaleFactor,
            ),
            child: widget!,
          );
        },
      );
}

ThemeData get _themeData => ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.grey.shade50,
      canvasColor: Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.white),
      textSelectionTheme: const TextSelectionThemeData().copyWith(cursorColor: Colors.blue),
      checkboxTheme: const CheckboxThemeData().copyWith(
        checkColor: WidgetStateProperty.all(Colors.white),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          if (states.contains(WidgetState.selected)) {
            return Colors.blue;
          }
          return Colors.white;
        }),
        side: BorderSide(color: Colors.grey.shade500, width: 1),
      ),
      dialogTheme: const DialogTheme().copyWith(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
        barBackgroundColor: Colors.white,
        applyThemeToAll: true,
        textTheme: const CupertinoTextThemeData().copyWith(
          navActionTextStyle: TextStyle(color: CupertinoColors.label, fontSize: 17.sp),
          actionTextStyle: TextStyle(color: CupertinoColors.systemBlue, fontSize: 17.sp),
          textStyle: TextStyle(color: CupertinoColors.label, fontSize: 17.sp),
          navLargeTitleTextStyle: TextStyle(color: CupertinoColors.label, fontSize: 20.sp),
          navTitleTextStyle: TextStyle(color: CupertinoColors.label, fontSize: 17.sp),
          pickerTextStyle: TextStyle(color: CupertinoColors.label, fontSize: 17.sp),
          tabLabelTextStyle: TextStyle(color: CupertinoColors.label, fontSize: 17.sp),
          dateTimePickerTextStyle: TextStyle(color: CupertinoColors.label, fontSize: 17.sp),
        ),
      ),
    );
