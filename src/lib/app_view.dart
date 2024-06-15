import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'config.dart';
import 'core/app_controller.dart';

class AppView extends StatelessWidget {
  const AppView({super.key, required this.builder, this.appController});

  final Widget Function(Locale? locale, TransitionBuilder builder) builder;
  final AppController? appController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      init: appController ?? AppController(),
      builder: (ctrl) => FocusDetector(
        onForegroundGained: () => ctrl.runningBackground(false),
        onForegroundLost: () => ctrl.runningBackground(true),
        child: SizedBox(
          width: Config.uiW,
          height: Config.uiH,
          child: ScreenUtilInit(
            designSize: const Size(Config.uiW, Config.uiH),
            minTextAdapt: true,
            splitScreenMode: true,
            fontSizeResolver: (fontSize, _) => fontSize.toDouble(),
            builder: (_, child) => builder(ctrl.getLocale(), _builder()),
          ),
        ),
      ),
    );
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
