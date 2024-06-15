import 'dart:async';
import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:openim_common/openim_common.dart';
import 'package:window_manager/window_manager.dart';

import '../../../../../main.dart';
import '../../../../core/multi_window_manager.dart';
import '../../../data/models/define.dart';

enum DesktopTabType {
  main,
  cm,
  remoteScreen,
  fileTransfer,
  portForward,
  install,
}

class WindowActionPanel extends StatefulWidget {
  final bool isMainWindow;

  // final DesktopTabType tabType;

  final bool showMinimize;
  final bool showMaximize;
  final bool showClose;
  final Widget? tail;
  final Future<bool> Function()? onClose;
  final Future<bool> Function(BuildContext context)? onCloseWindow;

  const WindowActionPanel(
      {super.key,
      required this.isMainWindow,
      // required this.tabType,
      this.tail,
      this.showMinimize = true,
      this.showMaximize = true,
      this.showClose = true,
      this.onClose,
      this.onCloseWindow});

  @override
  State<StatefulWidget> createState() {
    return WindowActionPanelState();
  }
}

class WindowActionPanelState extends State<WindowActionPanel> with MultiWindowListener, WindowListener {
  final _saveFrameDebounce = Debouncer(delay: Duration(seconds: 1));
  Timer? _macOSCheckRestoreTimer;
  int _macOSCheckRestoreCounter = 0;

  @override
  void initState() {
    super.initState();
    DesktopMultiWindow.addListener(this);
    windowManager.addListener(this);

    // Future.delayed(Duration(milliseconds: 500), () {
    //   if (widgets.isMainWindow) {
    //     windowManager.isMaximized().then((maximized) {
    //       if (stateGlobal.isMaximized.value != maximized) {
    //         WidgetsBinding.instance.addPostFrameCallback(
    //                 (_) => setState(() => stateGlobal.setMaximized(maximized)));
    //       }
    //     });
    //   } else {
    //     final wc = WindowController.fromWindowId(kWindowId!);
    //     wc.isMaximized().then((maximized) {
    //       debugPrint("isMaximized $maximized");
    //       if (stateGlobal.isMaximized.value != maximized) {
    //         WidgetsBinding.instance.addPostFrameCallback(
    //                 (_) => setState(() => stateGlobal.setMaximized(maximized)));
    //       }
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    DesktopMultiWindow.removeListener(this);
    windowManager.removeListener(this);
    _macOSCheckRestoreTimer?.cancel();
    super.dispose();
  }

  void _setMaximized(bool maximize) {
    Logger.print('Window action panel: ==== onWindowResized');

    // stateGlobal.setMaximized(maximize);
    _saveFrameDebounce.call(_saveFrame);
    setState(() {});
  }

  @override
  void onWindowMinimize() {
    Logger.print('Window action panel: ==== onWindowResized');

    // stateGlobal.setMinimized(true);
    // stateGlobal.setMaximized(false);
    super.onWindowMinimize();
  }

  @override
  void onWindowMaximize() {
    Logger.print('Window action panel: ==== onWindowResized');

    // stateGlobal.setMinimized(false);
    _setMaximized(true);
    super.onWindowMaximize();
  }

  @override
  void onWindowUnmaximize() {
    Logger.print('Window action panel: ==== onWindowResized');

    // stateGlobal.setMinimized(false);
    _setMaximized(false);
    super.onWindowUnmaximize();
  }

  _saveFrame() async {
    // if (widgets.tabType == DesktopTabType.main) {
    //   await saveWindowPosition(WindowType.Main);
    // } else if (kWindowType != null && kWindowId != null) {
    //   await saveWindowPosition(kWindowType!, windowId: kWindowId);
    // }
  }

  @override
  void onWindowMoved() {
    Logger.print('Window action panel: ==== onWindowResized');

    _saveFrameDebounce.call(_saveFrame);
    super.onWindowMoved();
  }

  @override
  void onWindowResized() {
    Logger.print('Window action panel: ==== onWindowResized');

    _saveFrameDebounce.call(_saveFrame);
    super.onWindowMoved();
  }

  @override
  void onWindowClose() async {
    Logger.print('Window action panel: ==== onWindowClose');

    final result = await widget.onCloseWindow?.call(context);
    if (result == true) {
      _closeWindow();
    }
  }

  void _closeWindow() async {
    Future mainWindowClose() async => await windowManager.hide();
    Future notMainWindowClose(WindowController controller) async {
      // if (widgets.tabController.length != 0) {
      //   debugPrint("close not empty multiwindow from taskbar");
      //   if (Platform.isWindows) {
      //     await controller.show();
      //     await controller.focus();
      //     final res = await widgets.onClose?.call() ?? true;
      //     if (!res) return;
      //   }
      //   widgets.tabController.clear();
      // }
      await controller.hide();
      await windowsManager.call(WindowType.main, WindowEvent.hide.rawValue, {"id": kWindowId!});
    }

    Future macOSWindowClose(
      Future<bool> Function() checkFullscreen,
      Future<void> Function() closeFunc,
    ) async {
      _macOSCheckRestoreCounter = 0;
      _macOSCheckRestoreTimer = Timer.periodic(Duration(milliseconds: 30), (timer) async {
        _macOSCheckRestoreCounter++;
        if (!await checkFullscreen() || _macOSCheckRestoreCounter >= 30) {
          _macOSCheckRestoreTimer?.cancel();
          _macOSCheckRestoreTimer = null;
          Timer(Duration(milliseconds: 700), () async => await closeFunc());
        }
      });
    }

    // hide window on close
    if (widget.isMainWindow) {
      if (windowsManager.getActiveWindows().contains(kMainWindowId)) {
        await windowsManager.unregisterActiveWindow(kMainWindowId);
      }
      // macOS specific workaround, the window is not hiding when in fullscreen.
      if (Platform.isMacOS && await windowManager.isFullScreen()) {
        // stateGlobal.closeOnFullscreen ??= true;
        await windowManager.setFullScreen(false);
        await macOSWindowClose(
          () async => await windowManager.isFullScreen(),
          mainWindowClose,
        );
      } else {
        // stateGlobal.closeOnFullscreen ??= false;
        await mainWindowClose();
      }
    } else {
      // it's safe to hide the subwindow
      final controller = WindowController.fromWindowId(kWindowId!);
      if (Platform.isMacOS) {
        // onWindowClose() maybe called multiple times because of loopCloseWindow() in remote_tab_page.dart.
        // use ??=  to make sure the value is set on first call.

        if (await widget.onClose?.call() ?? true) {
          if (await controller.isFullScreen()) {
            // stateGlobal.closeOnFullscreen ??= true;
            await controller.setFullscreen(false);
            // stateGlobal.setFullscreen(false, procWnd: false);
            await macOSWindowClose(
              () async => await controller.isFullScreen(),
              () async => await notMainWindowClose(controller),
            );
          } else {
            // stateGlobal.closeOnFullscreen ??= false;
            await notMainWindowClose(controller);
          }
        }
      } else {
        await notMainWindowClose(controller);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Offstage(offstage: widget.tail == null, child: widget.tail),
        Offstage(
          offstage: useCompatibleUiMode || Platform.isMacOS,
          child: Row(
            children: [
              Offstage(
                  offstage: !widget.showMinimize || Platform.isMacOS,
                  child: ActionIcon(
                    message: 'Minimize',
                    icon: IconFont.min,
                    onTap: () {
                      if (widget.isMainWindow) {
                        windowManager.minimize();
                      } else {
                        WindowController.fromWindowId(kWindowId!).minimize();
                      }
                    },
                    isClose: false,
                  )),
              // Offstage(
              //     offstage: !widget.showMaximize || Platform.isMacOS,
              //     child: Obx(() => ActionIcon(
              //       message: stateGlobal.isMaximized.isTrue
              //           ? 'Restore'
              //           : 'Maximize',
              //       icon: stateGlobal.isMaximized.isTrue
              //           ? IconFont.restore
              //           : IconFont.max,
              //       onTap: bind.isIncomingOnly() && isInHomePage()
              //           ? null
              //           : _toggleMaximize,
              //       isClose: false,
              //     ))),
              Offstage(
                  offstage: !widget.showClose || Platform.isMacOS,
                  child: ActionIcon(
                    message: 'Close',
                    icon: IconFont.close,
                    onTap: () async {
                      final res = await widget.onClose?.call() ?? true;
                      if (res) {
                        // hide for all window
                        // note: the main window can be restored by tray icon
                        Future.delayed(Duration.zero, () async {
                          if (widget.isMainWindow) {
                            await windowManager.close();
                          } else {
                            await WindowController.fromWindowId(kWindowId!).close();
                          }
                        });
                      }
                    },
                    isClose: true,
                  ))
            ],
          ),
        ),
      ],
    );
  }

  void _toggleMaximize() {
    toggleMaximize(widget.isMainWindow).then((maximize) {
      // update state for sub window, wc.unmaximize/maximize() will not invoke onWindowMaximize/Unmaximize
      // stateGlobal.setMaximized(maximize);
    });
  }

  /// return true -> window will be maximize
  /// return false -> window will be unmaximize
  Future<bool> toggleMaximize(bool isMainWindow) async {
    if (isMainWindow) {
      if (await windowManager.isMaximized()) {
        windowManager.unmaximize();
        return false;
      } else {
        windowManager.maximize();
        return true;
      }
    } else {
      final wc = WindowController.fromWindowId(kWindowId!);
      if (await wc.isMaximized()) {
        wc.unmaximize();
        return false;
      } else {
        wc.maximize();
        return true;
      }
    }
  }
}

const double kDesktopRemoteTabBarHeight = 28.0;
const double kTabBarHeight = kDesktopRemoteTabBarHeight;
const double _kIconSize = 18;
const double _kDividerIndent = 10;
const double kActionIconSize = 12;

class ActionIcon extends StatefulWidget {
  final String? message;
  final IconData icon;
  final GestureTapCallback? onTap;
  final bool isClose;
  final double iconSize;
  final double boxSize;

  const ActionIcon(
      {Key? key,
      this.message,
      required this.icon,
      this.onTap,
      this.isClose = false,
      this.iconSize = kActionIconSize,
      this.boxSize = kTabBarHeight - 1})
      : super(key: key);

  @override
  State<ActionIcon> createState() => _ActionIconState();
}

class _ActionIconState extends State<ActionIcon> {
  var hover = false.obs;

  @override
  void initState() {
    super.initState();
    hover.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.message != null ? widget.message! : "",
      waitDuration: const Duration(seconds: 1),
      child: InkWell(
        hoverColor: widget.isClose ? const Color.fromARGB(255, 196, 43, 28) : Theme.of(context).tabBarTheme.labelColor,
        onHover: (value) => hover.value = value,
        onTap: widget.onTap,
        child: SizedBox(
          height: widget.boxSize,
          width: widget.boxSize,
          child: widget.onTap == null
              ? Icon(
                  widget.icon,
                  color: Colors.grey,
                  size: widget.iconSize,
                )
              : Obx(
                  () => Icon(
                    widget.icon,
                    color: hover.value && widget.isClose ? Colors.white : Theme.of(context).tabBarTheme.unselectedLabelColor,
                    size: widget.iconSize,
                  ),
                ),
        ),
      ),
    );
  }
}

class IconFont {
  static const _family1 = 'Tabbar';
  static const _family2 = 'PeerSearchbar';

  IconFont._();

  static const IconData max = IconData(0xe606, fontFamily: _family1);
  static const IconData restore = IconData(0xe607, fontFamily: _family1);
  static const IconData close = IconData(0xe668, fontFamily: _family1);
  static const IconData min = IconData(0xe609, fontFamily: _family1);
  static const IconData add = IconData(0xe664, fontFamily: _family1);
  static const IconData menu = IconData(0xe628, fontFamily: _family1);
  static const IconData search = IconData(0xe6a4, fontFamily: _family2);
  static const IconData roundClose = IconData(0xe6ed, fontFamily: _family2);
  static const IconData addressBook = IconData(0xe602, fontFamily: "AddressBook");
}
