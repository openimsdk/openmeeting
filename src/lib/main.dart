import 'dart:convert';
import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:openim_common/openim_common.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';
import 'app/data/models/define.dart';
import 'config.dart';
import 'core/multi_window_manager.dart';

int? kWindowId;
WindowType? kWindowType;

void main(List<String> args) => Config.init(() async {
      if (!PlatformExt.isDesktop) {
        return runApp(const MeetingApp());
      }

      if (args.firstOrNull == 'multi_window' && PlatformExt.isDesktop) {
        kWindowId = int.parse(args[1]);
        final argument = args[2].isEmpty ? <String, dynamic>{} : jsonDecode(args[2]) as Map<String, dynamic>;
        argument['windowId'] = kWindowId;
        int type = argument['type'] ?? -1;
        kWindowType = type.windowType;
        
        WindowController.fromWindowId(kWindowId!).setPreventClose(true);

        runApp(MeetingSubWindow(args: argument));

        WindowController.fromWindowId(kWindowId!).setTitle('Open Meeting');
        WindowController.fromWindowId(kWindowId!).show();
        return;
      } else {
        await windowManager.ensureInitialized();
        windowManager.setPreventClose(true);
        runApp(const MeetingApp());

        const size = Size(375, 667);
        const options = WindowOptions(
          size: size,
          minimumSize: size,
          maximumSize: size,
          center: true,
          backgroundColor: Colors.transparent,
          skipTaskbar: false,
          fullScreen: false,
          titleBarStyle: TitleBarStyle.normal,
          title: "Open Meeting",
          zoomButtonVisibility: false,
        );

        windowManager.waitUntilReadyToShow(options, () async {
          await windowManager.show();
          await windowManager.focus();
          windowsManager.registerActiveWindow(kMainWindowId);
        });

        windowManager.setOpacity(1);
      }

      return;
    });
