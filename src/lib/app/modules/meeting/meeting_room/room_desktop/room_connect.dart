import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import '../../../../../core/multi_window_manager.dart';
import '../../../../data/models/define.dart';
import '../../../../data/models/meeting_option.dart';
import '../../../../widgets/meeting/desktop/meeting_alert_dialog.dart';
import '../../../../widgets/meeting/desktop/meeting_pop_menu.dart';
import '../../../../widgets/meeting/desktop/window_action_panel.dart';
import '../meeting_client.dart';
import 'room_container.dart';

enum _LoadingStatus {
  loading,
  success,
  error,
}

class RoomConnectDesktopView extends StatefulWidget {
  const RoomConnectDesktopView(this.windowId, this.userFullInfo, this.certificate, this.roomID, {super.key, this.options});

  final UserInfo userFullInfo;
  final LiveKit certificate;
  final String roomID;
  final MeetingOptions? options;
  final int windowId;

  @override
  State<RoomConnectDesktopView> createState() => _RoomConnectDesktopViewState();
}

class _RoomConnectDesktopViewState extends State<RoomConnectDesktopView> with AutomaticKeepAliveClientMixin, MultiWindowListener {
  final loading = _LoadingStatus.loading.obs;
  Room? _room;
  late String _roomID;
  late LiveKit _certificate;

  @override
  void initState() {
    super.initState();
    _roomID = widget.roomID;
    _certificate = widget.certificate;

    DesktopMultiWindow.addListener(this);

    windowsManager.setMethodHandler((call, fromWindowId) async {
      Logger.print("[Room Connect] call ${call.method} with args ${call.arguments} from window $fromWindowId");
      if (call.method == WindowEvent.hide.rawValue) {
        await windowsManager.unregisterActiveWindow(call.arguments['id']);
      } else if (call.method == WindowEvent.show.rawValue) {
        await windowsManager.registerActiveWindow(call.arguments["id"]);
      } else if (call.method == WindowEvent.activeSession.rawValue) {
        if (call.arguments != null) {
          final msg = jsonDecode(call.arguments) as Map<String, dynamic>;
          _certificate = LiveKit()..mergeFromProto3Json(msg['certificate']);
          _roomID = msg['roomID'];
        }
        _connectRoom();
        windowsManager.windowOnTop(widget.windowId);

        return true;
      }
    });

    _connectRoom();
  }

  @override
  void dispose() {
    super.dispose();
    DesktopMultiWindow.removeListener(this);
    Logger.print('========dispose');
  }

  void _connectRoom() {
    Future.delayed(const Duration(seconds: 0), () async {
      loading.value = _LoadingStatus.loading;
      final result = await MeetingClient().connect(
        Get.context!,
        url: _certificate.url,
        token: _certificate.token,
        roomID: _roomID,
        options: widget.options ?? const MeetingOptions(),
      );
      loading.value = result == null ? _LoadingStatus.error : _LoadingStatus.success;

      MeetingClient().userInfo = widget.userFullInfo;

      if (result == null) return;

      _room = result.room;

      await Navigator.of(Get.context!).push<void>(
        PageRouteBuilder(
            pageBuilder: (_, animation, secondaryAnimation) {
              return MeetingRoomContainer(
                room: result.room,
                listener: result.listener,
                url: _certificate.url,
                token: _certificate.token,
                roomID: _roomID,
                onOperation: MeetingClient().operateRoom,
                onParticipantOperation: MeetingClient().operateParticipants,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            }),
      );
    });
  }

  @override
  void onWindowFocus() {
    Logger.print('======== [Room Connect] window focus');
    setState(() {});
  }

  @override
  void onWindowClose() {
    Logger.print('========[Room Connect] window close');
    if (Platform.isMacOS) {
      if (_room == null) {
        Navigator.of(Get.context!).pop();
        MeetingClient().closeWindow();
      } else {
        _showEndPopup(null, immediatelyClose: true);
      }
    }
  }

  Future<bool> _showEndPopup(BuildContext? ctx, {bool immediatelyClose = false}) async {
    final completer = Completer<bool>();

    final loginUserID = widget.userFullInfo.userID;
    final roomMetadata = (MeetingMetadata()..mergeFromProto3Json(jsonDecode(_room!.metadata!))).detail;
    MeetingPopMenu.showMeetingWidget(ctx ?? context, contentDyOffset: ctx == null ? kTabBarHeight - MediaQuery.of(context).size.height : 0,
        onTap2: () {
      MeetingAlertDialog.show(context, StrRes.leaveMeetingConfirmHint, '', onConfirm: () {
        if (immediatelyClose) {
          Navigator.of(Get.context!).pop();
          MeetingClient().closeWindow();
        }
        MeetingClient().operateRoom(context, OperationType.leave);
        completer.complete(true);
      });
    },
        onTap3: loginUserID != roomMetadata.creatorUserID
            ? null
            : () {
                MeetingAlertDialog.show(context, StrRes.endMeetingConfirmHit, '', onConfirm: () {
                  if (immediatelyClose) {
                    Navigator.of(Get.context!).pop();
                    MeetingClient().closeWindow(realClose: true);
                  }
                  MeetingClient().operateRoom(context, OperationType.end);
                  completer.complete(true);
                });
              });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          if (!Platform.isMacOS) _buildAppbar(context),
          const Spacer(),
          _buildLoadingIndicator(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildAppbar(BuildContext context) {
    return Offstage(
        offstage: useCompatibleUiMode,
        child: SizedBox(
          height: kTabBarHeight,
          child: Column(
            children: [
              SizedBox(
                height: kTabBarHeight - 1,
                child: WindowActionPanel(
                  isMainWindow: false,
                  onClose: (ctx) {
                    return _showEndPopup(ctx);
                  },
                ),
              ),
              const Divider(
                height: 1,
              ),
            ],
          ),
        ));
  }

  Widget _buildLoadingIndicator() {
    return Obx(() => Offstage(
          offstage: loading.value == _LoadingStatus.success,
          child: Center(
            child: loading.value == _LoadingStatus.loading
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      _connectRoom();
                    },
                    child: Text('Retry')),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
