import 'dart:convert';
import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openim_common/openim_common.dart';
import 'package:window_manager/window_manager.dart';

import '../app/data/models/define.dart';
import '../app/data/models/meeting.pb.dart';
import '../app/data/models/meeting_screen_info.dart';

class MultiWindowCallResult {
  int windowId;
  dynamic result;

  MultiWindowCallResult(this.windowId, this.result);
}

/// Window Manager
/// mainly use it in `Main Window`
/// use it in sub window is not recommended
class RustDeskMultiWindowManager {
  RustDeskMultiWindowManager._();

  static final instance = RustDeskMultiWindowManager._();

  final Set<int> _inactiveWindows = {};
  final Set<int> _activeWindows = {};
  final List<AsyncCallback> _windowActiveCallbacks = [];
  final List<int> _roomWindows = [];
  final List<int> _settingWindows = [];

  moveTabToNewWindow(int windowId, String peerId, String sessionId) async {
    var params = {
      'type': WindowType.room.rawValue,
      'id': peerId,
      'tab_window_id': windowId,
      'session_id': sessionId,
    };
    await _newSession(
      WindowType.room,
      WindowEvent.newRoom.rawValue,
      peerId,
      _roomWindows,
      jsonEncode(params),
    );
  }

  // This function must be called in the main window thread.
  // Because the _remoteDesktopWindows is managed in that thread.
  openMonitorSession(int windowId, String peerId, int display, int displayCount, Rect? screenRect) async {
    if (_roomWindows.length > 1) {
      for (final windowId in _roomWindows) {
        if (await DesktopMultiWindow.invokeMethod(
            windowId,
            WindowEvent.activeDisplaySession.rawValue,
            jsonEncode({
              'id': peerId,
              'display': display,
            }))) {
          return;
        }
      }
    }

    final displays = display == kAllDisplayValue ? List.generate(displayCount, (index) => index) : [display];
    var params = {
      'type': WindowType.room.rawValue,
      'id': peerId,
      'tab_window_id': windowId,
      'display': display,
      'displays': displays,
    };
    if (screenRect != null) {
      params['screen_rect'] = {
        'l': screenRect.left,
        't': screenRect.top,
        'r': screenRect.right,
        'b': screenRect.bottom,
      };
    }
    await _newSession(
      WindowType.room,
      WindowEvent.newRoom.rawValue,
      peerId,
      _roomWindows,
      jsonEncode(params),
      screenRect: screenRect,
    );
  }

  Future<void> windowOnTop(int? id) async {
    if (!PlatformExt.isDesktop) {
      return;
    }
    Logger.print("Bring window '$id' on top");
    if (id == null) {
      // main window
      // if (stateGlobal.isMinimized) {
      //   await windowManager.restore();
      // }
      await windowManager.show();
      await windowManager.focus();
      await windowsManager.registerActiveWindow(kMainWindowId);
    } else {
      WindowController.fromWindowId(id)
        ..focus()
        ..show();
      windowsManager.call(WindowType.main, WindowEvent.show.rawValue, {"id": id});
    }
  }

  Future<int> newSessionWindow(
    WindowType type,
    String remoteId,
    String msg,
    List<int> windows,
    bool withScreenRect,
  ) async {
    final windowController = await DesktopMultiWindow.createWindow(msg);
    final windowId = windowController.windowId;
    if (!withScreenRect) {
      var frame = const Offset(0, 0) & Size(1280 + windowId * 20, 720 + windowId * 20);

      if (type == WindowType.setting) {
        frame = const Offset(0, 0) & const Size(730, 878);
      }

      windowController
        ..setFrame(frame)
        ..center();
    } else {
      windowController.setTitle(type.title);
    }
    if (Platform.isMacOS) {
      Future.microtask(() => windowController.show());
    }
    registerActiveWindow(windowId);
    windows.add(windowId);

    return windowId;
  }

  Future<MultiWindowCallResult> _newSession(
    WindowType type,
    String methodName,
    String remoteId,
    List<int> windows,
    String msg, {
    Rect? screenRect,
  }) async {
    if (_inactiveWindows.isNotEmpty) {
      for (final windowId in windows) {
        if (_inactiveWindows.contains(windowId)) {
          // if (screenRect == null) {
          //   await restoreWindowPosition(type,
          //       windowId: windowId, peerId: remoteId);
          // }
          await DesktopMultiWindow.invokeMethod(windowId, methodName, msg);
          WindowController.fromWindowId(windowId).show();
          registerActiveWindow(windowId);
          return MultiWindowCallResult(windowId, null);
        }
      }
    }
    final windowId = await newSessionWindow(type, remoteId, msg, windows, screenRect != null);
    return MultiWindowCallResult(windowId, null);
  }

  Future<MultiWindowCallResult> newSession(WindowType type, String methodName, UserInfo userFullInfo, List<int> windows,
      {LiveKit? certificate, String? roomID}) async {
    final params = MeetingScreenInfo(
      type: type,
      userInfo: userFullInfo,
      certificate: certificate,
      roomID: roomID,
    );

    final msg = jsonEncode(params.toMap());

    if (windows.isNotEmpty) {
      for (final windowId in windows) {
        if (await DesktopMultiWindow.invokeMethod(windowId, WindowEvent.activeSession.rawValue, msg)) {
          return MultiWindowCallResult(windowId, null);
        }
      }
    }

    return _newSession(type, methodName, type.rawValue.toString(), windows, msg);
  }

  Future<MultiWindowCallResult> newRoom(UserInfo userFullInfo, LiveKit certificate, String roomID) async {
    return await newSession(
      WindowType.room,
      WindowEvent.newRoom.rawValue,
      userFullInfo,
      _roomWindows,
      certificate: certificate,
      roomID: roomID,
    );
  }

  Future<MultiWindowCallResult> newSetting(UserInfo userFullInfo) async {
    return await newSession(
      WindowType.setting,
      WindowEvent.newSetting.rawValue,
      userFullInfo,
      _settingWindows,
    );
  }

  Future<MultiWindowCallResult> call(WindowType type, String methodName, dynamic args) async {
    final wnds = _findWindowsByType(type);
    if (wnds.isEmpty) {
      return MultiWindowCallResult(kInvalidWindowId, null);
    }
    for (final windowId in wnds) {
      if (_activeWindows.contains(windowId)) {
        final res = await DesktopMultiWindow.invokeMethod(windowId, methodName, args);
        return MultiWindowCallResult(windowId, res);
      }
    }
    final res = await DesktopMultiWindow.invokeMethod(wnds[0], methodName, args);
    return MultiWindowCallResult(wnds[0], res);
  }

  List<int> _findWindowsByType(WindowType type) {
    switch (type) {
      case WindowType.main:
        return [kMainWindowId];
      case WindowType.room:
        return _roomWindows;
      case WindowType.setting:
        return _settingWindows;
      case WindowType.unknown:
        break;
    }
    return [];
  }

  void clearWindowType(WindowType type) {
    switch (type) {
      case WindowType.main:
        return;
      case WindowType.room:
        _roomWindows.clear();
        Logger.print('_remoteDesktopWindows: ${_roomWindows.length}');
        break;
      case WindowType.setting:
        _settingWindows.clear();
        break;
      case WindowType.unknown:
        break;
    }
  }

  void setMethodHandler(Future<dynamic> Function(MethodCall call, int fromWindowId)? handler) {
    DesktopMultiWindow.setMethodHandler(handler);
  }

  Future<void> closeAllSubWindows() async {
    await Future.wait(WindowType.values.map((e) => closeWindows(e)));
  }

  Future<void> closeWindows(WindowType type) async {
    if (type == WindowType.main) {
      // skip main window, use window manager instead
      return;
    }

    List<int> windows = [];
    try {
      windows = await DesktopMultiWindow.getAllSubWindowIds();
    } catch (e) {
      debugPrint('Failed to getAllSubWindowIds of $type, $e');
      return;
    }

    if (windows.isEmpty) {
      return;
    }
    for (final wId in windows) {
      debugPrint("closing multi window, id: $wId, type: ${type.toString()}");
      // await saveWindowPosition(type, windowId: wId);
      try {
        await WindowController.fromWindowId(wId).setPreventClose(false);
        await WindowController.fromWindowId(wId).close();
        _activeWindows.remove(wId);
        _inactiveWindows.remove(wId);
      } catch (e) {
        debugPrint("$e");
        return;
      }
    }
    await _notifyActiveWindow();
    clearWindowType(type);
  }

  Future<List<int>> getAllSubWindowIds() async {
    try {
      final windows = await DesktopMultiWindow.getAllSubWindowIds();
      return windows;
    } catch (err) {
      if (err is AssertionError) {
        return [];
      } else {
        rethrow;
      }
    }
  }

  Set<int> getActiveWindows() {
    return _activeWindows;
  }

  Future<void> _notifyActiveWindow() async {
    for (final callback in _windowActiveCallbacks) {
      await callback.call();
    }
  }

  Future<void> registerActiveWindow(int windowId) async {
    _activeWindows.add(windowId);
    _inactiveWindows.remove(windowId);
    await _notifyActiveWindow();
  }

  Future<void> destroyWindow(int windowId) async {
    await WindowController.fromWindowId(windowId).setPreventClose(false);
    await WindowController.fromWindowId(windowId).close();
    _roomWindows.remove(windowId);
    _settingWindows.remove(windowId);
  }

  /// Remove active window which has [`windowId`]
  ///
  /// [Availability]
  /// This function should only be called from main window.
  /// For other windows, please post a unregister(hide) event to main window handler:
  /// `rustDeskWinManager.call(WindowType.Main, kWindowEventHide, {"id": windowId!});`
  Future<void> unregisterActiveWindow(int windowId) async {
    _activeWindows.remove(windowId);
    if (windowId != kMainWindowId) {
      _inactiveWindows.add(windowId);
    }
    await _notifyActiveWindow();
  }

  void registerActiveWindowListener(AsyncCallback callback) {
    _windowActiveCallbacks.add(callback);
  }

  void unregisterActiveWindowListener(AsyncCallback callback) {
    _windowActiveCallbacks.remove(callback);
  }
}

final windowsManager = RustDeskMultiWindowManager.instance;
