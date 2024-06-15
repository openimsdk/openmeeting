import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/widgets/meeting/overlay_widget.dart';
import 'package:openmeeting/app/widgets/meeting/participant_info.dart';
import 'package:sprintf/sprintf.dart';

class MeetingAlertDialog {
  static void show(BuildContext context, String? title, String content,
      {bool forMobile = false, String? confirmText, VoidCallback? onConfirm, String? cancelText, VoidCallback? onCancel}) {
    Widget buildContent(BuildContext ctx) {
      Logger.print('title:$title, content: $content');
      return CustomDialog(
        leftText: cancelText,
        rightText: confirmText,
        onTapLeft: () {
          if (forMobile) {
            OverlayWidget().hideDialog();
          } else {
            Navigator.of(context).pop();
          }
          onCancel?.call();
        },
        onTapRight: () {
          if (forMobile) {
            OverlayWidget().hideDialog();
          } else {
            Navigator.of(context).pop();
          }
          onConfirm?.call();
        },
        title: title,
        content: content,
      );
    }

    if (forMobile) {
      OverlayWidget().showDialog(context: context, child: buildContent(context));
    } else {
      showDialog(context: context, builder: (_) => buildContent(context));
    }
  }

  static void showEnterMeetingWithPasswordDialog(BuildContext context, String host, {ValueChanged<String>? onConfirm, VoidCallback? onCancel}) {
    final hostController = TextEditingController(text: sprintf(StrRes.meetingHostIs, [host]));
    final passwordController = TextEditingController();

    Widget buildContent(BuildContext ctx) {
      final textFiledDecoration = BoxDecoration(
        color: const CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.black,
        ),
        border: Border.all(color: Styles.c_E8EAEF),
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      );

      return Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 206,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StrRes.enterMeeting,
                style: Styles.ts_0C1C33_17sp,
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: hostController,
                enabled: false,
                decoration: textFiledDecoration,
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoTextField(
                controller: passwordController,
                decoration: textFiledDecoration,
              ),
              const SizedBox(
                height: 26,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        borderRadius: BorderRadius.circular(4),
                        color: Styles.c_F4F5F7,
                        child: Text(
                          StrRes.cancel,
                          style: Styles.ts_0C1C33_14sp,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onCancel?.call();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        borderRadius: BorderRadius.circular(4),
                        color: Styles.c_0089FF,
                        child: Text(
                          StrRes.confirm,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm?.call(passwordController.text.trim());
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    showDialog(context: context, builder: (ctx) => buildContent(ctx));
  }

  MeetingAlertDialog.showMemberSetting(
    BuildContext context, {
    required ValueNotifier<({bool cameraIsEnable, bool micIsEnable, String nickname, String userID})> valueNotifier,
    required VoidCallback onEnableCamera,
    required VoidCallback onEnableMic,
    required VoidCallback onChangeNickname,
    required VoidCallback onSetHost,
    required VoidCallback onKickoff,
  }) {
    Widget buildContent(BuildContext ctx) {
      Widget buildItem(Widget icon, String title, VoidCallback onTap, {bool showDivider = true}) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListTile(
                dense: true,
                leading: icon,
                title: Text(title, style: Styles.ts_0C1C33_17sp),
                onTap: onTap,
              ),
            ),
            if (showDivider) Divider(height: 1, color: Styles.c_E8EAEF),
          ],
        );
      }

      return Container(
        width: 300.w,
        padding: EdgeInsets.only(bottom: 8),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, child) {
            Logger.print('dialog build');
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 52.h,
                  color: Color(0xFFF4F9FF),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(valueNotifier.value.nickname, style: Styles.ts_0C1C33_17sp),
                      CloseButton(
                        onPressed: () {
                          OverlayWidget().hideDialog();
                        },
                      ),
                    ],
                  ),
                ),
                buildItem(
                    Icon(valueNotifier.value.cameraIsEnable ? Icons.video_camera_back_rounded : Icons.videocam_off_rounded, color: Styles.c_0089FF),
                    valueNotifier.value.cameraIsEnable ? StrRes.meetingCloseVideo : StrRes.requestEnableVideo,
                    onEnableCamera),
                buildItem(Icon(valueNotifier.value.micIsEnable ? Icons.mic : Icons.mic_off, color: Styles.c_0089FF),
                    valueNotifier.value.micIsEnable ? StrRes.meetingMute : StrRes.requestEnableAudio, onEnableMic,
                    showDivider: false),
                // buildItem(Icon(Icons.edit_note_sharp, color: Styles.c_0089FF), StrRes.changeNickname, onChangeNickname),
                // buildItem(Icon(Icons.person_add_alt_1_rounded, color: Styles.c_0089FF), StrRes.setHost, onSetHost),
                // buildItem(Icon(Icons.person_remove_rounded, color: Colors.red), StrRes.kickoffFromMeeting, onKickoff, showDivider: false),
              ],
            );
          },
        ),
      );
    }

    OverlayWidget().showDialog(context: context, child: buildContent(context));
  }
}
