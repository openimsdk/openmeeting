import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

import 'button.dart';

abstract class ToolsBar extends StatelessWidget {
  const ToolsBar({
    super.key,
    this.enabledMicrophone = true,
    this.enabledCamera = true,
    this.enabledScreenShare = true,
    this.openedScreenShare = false,
    this.openedMicrophone = true,
    this.openedCamera = true,
    this.onTapSettings,
    this.onTapMemberList,
    this.onTapCamera,
    this.onTapMicrophone,
    this.onTapScreenShare,
    this.membersCount = 0,
    this.isHost = false,
  });

  final Function()? onTapSettings;
  final Function()? onTapMemberList;
  final Function()? onTapMicrophone;
  final Function()? onTapCamera;
  final Function()? onTapScreenShare;
  final bool enabledMicrophone;
  final bool enabledCamera;
  final bool enabledScreenShare;
  final bool openedScreenShare;
  final bool openedMicrophone;
  final bool openedCamera;
  final int membersCount;
  final bool isHost;

  @override
  Widget build(BuildContext context) => buildBody(context);

  Widget buildBody(BuildContext context);
}

class ToolsBarMobile extends ToolsBar {
  const ToolsBarMobile({
    super.key,
    super.enabledMicrophone = true,
    super.enabledCamera = true,
    super.enabledScreenShare = true,
    super.openedScreenShare = false,
    super.openedMicrophone = true,
    super.openedCamera = true,
    super.onTapSettings,
    super.onTapMemberList,
    super.onTapCamera,
    super.onTapMicrophone,
    super.onTapScreenShare,
    super.membersCount = 0,
    super.isHost = false,
  });

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      height: 66.h,
      alignment: Alignment.center,
      child: Row(
        children: [
          ImageButton.microphone(
            on: openedMicrophone,
            enabled: enabledMicrophone,
            onTap: onTapMicrophone,
          ),
          ImageButton.camera(
            on: openedCamera,
            enabled: enabledCamera,
            onTap: onTapCamera,
          ),
          ImageButton.screenShare(
            on: openedScreenShare,
            enabled: enabledScreenShare,
            onTap: onTapScreenShare,
          ),
          ImageButton.members(
            onTap: onTapMemberList,
            count: membersCount,
          ),
          if (isHost) ImageButton.settings(onTap: onTapSettings),
        ],
      ),
    );
  }
}

class ToolsBarDesktop extends ToolsBar {
  const ToolsBarDesktop(
      {super.key,
      super.enabledMicrophone = true,
      super.enabledCamera = true,
      super.enabledScreenShare = true,
      super.openedScreenShare = false,
      super.openedMicrophone = true,
      super.openedCamera = true,
      super.onTapSettings,
      super.onTapMemberList,
      super.onTapCamera,
      super.onTapMicrophone,
      super.onTapScreenShare,
      super.membersCount = 0,
      super.isHost = false,
      this.onEndMeeting});

  final ValueChanged<BuildContext>? onEndMeeting;

  @override
  Widget buildBody(BuildContext context) {
    final color = Styles.c_8E9AB0;
    final textStyle = TextStyle().ts_0c1c33_6size;
    return Container(
      height: 62.h,
      color: CupertinoColors.white,
      child: Row(
        children: [
          ImageButton.microphone(
            on: openedMicrophone,
            enabled: enabledMicrophone,
            onTap: onTapMicrophone,
            expanded: false,
            color: color,
            textStyle: textStyle,
          ),
          ImageButton.camera(
            on: openedCamera,
            enabled: enabledCamera,
            onTap: onTapCamera,
            expanded: false,
            color: color,
            textStyle: textStyle,
          ),
          ImageButton.screenShare(
            on: openedScreenShare,
            enabled: enabledScreenShare,
            onTap: onTapScreenShare,
            expanded: false,
            color: color,
            textStyle: textStyle,
          ),
          ImageButton.members(
            onTap: onTapMemberList,
            count: membersCount,
            expanded: false,
            color: color,
            textStyle: textStyle,
          ),
          // if (isHost)
          //   ImageButton.settings(
          //     onTap: onTapSettings,
          //     expanded: false,
          //     color: color,
          //     textStyle: textStyle,
          //   ),
          const Spacer(),
          Builder(builder: (context) {
            return CupertinoButton.filled(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                child: Text(isHost ? StrRes.endMeeting : StrRes.leaveMeeting),
                onPressed: () {
                  onEndMeeting?.call(context);
                });
          }),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
