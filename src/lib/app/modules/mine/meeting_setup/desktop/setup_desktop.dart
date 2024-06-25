import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:openim_common/openim_common.dart';

import '../../../../../core/multi_window_manager.dart';
import '../../../../../main.dart';
import '../../../../data/models/define.dart';

class MeetingSetupDesktop extends StatefulWidget {
  const MeetingSetupDesktop(this.windowId, {super.key});

  final int windowId;

  @override
  State<MeetingSetupDesktop> createState() => _MeetingSetupDesktopState();
}

class _MeetingSetupDesktopState extends State<MeetingSetupDesktop>
    with AutomaticKeepAliveClientMixin, MultiWindowListener {
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    DesktopMultiWindow.addListener(this);

    windowsManager.setMethodHandler((call, fromWindowId) async {
      if (call.method == WindowEvent.hide.rawValue) {
        await windowsManager.unregisterActiveWindow(call.arguments['id']);
      } else if (call.method == WindowEvent.show.rawValue) {
        await windowsManager.registerActiveWindow(call.arguments["id"]);
      } else if (call.method == WindowEvent.activeSession.rawValue) {
        await windowsManager.windowOnTop(widget.windowId);

        return true;
      }
      Logger.print("[Room Setup] call ${call.method} with args ${call.arguments} from window $fromWindowId");
    });
  }

  @override
  void dispose() {
    super.dispose();

    DesktopMultiWindow.removeListener(this);
  }

  @override
  void onWindowClose() {
    super.onWindowClose();
    Logger.print('[Meeting Setup] ==== onWindowClose');
    Future.delayed(Duration.zero, () async {
      final controller = WindowController.fromWindowId(kWindowId!);

      await controller.hide();
      await windowsManager.call(WindowType.main, WindowEvent.hide, {"id": widget.windowId});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: [
        _buildVerticalTabBar(),
        VerticalDivider(
          width: 2,
          color: Colors.grey.shade100,
        ),
      ],
    );
  }

  Widget _buildVerticalTabBar() {
    final tabs = [StrRes.settings];
    return ListView.separated(
        itemBuilder: (context, index) {
          return TextButton(
              onPressed: () {
                _onTabChanged(index);
              },
              child: Text(tabs[index]));
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tabs.length);
  }

  void _onTabChanged(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
