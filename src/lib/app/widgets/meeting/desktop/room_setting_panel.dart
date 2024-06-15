import 'package:flutter/material.dart';
import 'package:openim_common/openim_common.dart';

import '../../../data/models/define.dart';

class RoomSettingPanel extends StatefulWidget {
  const RoomSettingPanel(
      {super.key,
      this.onOperation,
      required this.allowParticipantUnMute,
      required this.allowParticipantVideo,
      required this.onlyHostCanShareScreen,
      required this.defaultMuted});

  final bool allowParticipantUnMute;
  final bool allowParticipantVideo;
  final bool onlyHostCanShareScreen;
  final bool defaultMuted;

  final Future<bool?> Function(RoomSetting setting, bool to)? onOperation;

  @override
  State<RoomSettingPanel> createState() => _RoomSettingPanelState();
}

class _RoomSettingPanelState extends State<RoomSettingPanel> {
  late List<Item> items;

  @override
  void initState() {
    super.initState();
    items = [
      Item(setting: RoomSetting.defaultMuted, title: StrRes.defaultMuteMembers, checked: widget.defaultMuted),
      Item(setting: RoomSetting.allowParticipantUnMute, title: StrRes.allowMembersOpenMic, checked: widget.allowParticipantUnMute),
      Item(setting: RoomSetting.allowParticipantVideo, title: StrRes.allowMembersOpenVideo, checked: widget.allowParticipantVideo),
      Item(setting: RoomSetting.onlyHostCanShareScreen, title: StrRes.onlyHostShareScreen, checked: widget.onlyHostCanShareScreen),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return _buildItem(index);
          },
          separatorBuilder: (context, index) => const Divider(
                color: Colors.white,
              ),
          itemCount: items.length),
    );
  }

  Widget _buildItem(int index) {
    final item = items[index];
    return Row(
      children: [
        Checkbox(
          value: item.checked,
          onChanged: (value) => onChanged(item.setting, value ?? false),
        ),
        Flexible(
          child: Text(
            items[index].title,
            style: Styles.ts_0C1C33_14sp,
          ),
        ),
      ],
    );
  }

  void onChanged(RoomSetting setting, bool value) {
    widget.onOperation?.call(setting, value).then((result) {
      if (result == true) {
        setState(() {
          items.firstWhere((element) => element.setting == setting).checked = value;
        });
      }
    });
  }
}

class Item {
  final RoomSetting setting;
  final String title;
  bool checked;

  Item({required this.setting, required this.title, required this.checked});
}
