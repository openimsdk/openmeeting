import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';
import 'package:popover/popover.dart';
import 'package:flutter/material.dart';

import '../../../data/models/define.dart';
import 'room_setting_panel.dart';

class MeetingPopMenu {
  static void showMeetingWidget(BuildContext context,
      {double contentDyOffset = 0,
      String? title1,
      VoidCallback? onTap1,
      String? title2,
      VoidCallback? onTap2,
      String? title3,
      VoidCallback? onTap3}) {
    // internal
    Widget buildContent() {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: [
          // OutlinedButton(
          //   onPressed: () {
          //     Navigator.of(context)..pop();
          //     onTap1?.call();
          //   },
          //   style: ButtonStyle(
          //     side: MaterialStateProperty.all(BorderSide(color: Colors.blue)),
          //     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
          //     backgroundColor: MaterialStateProperty.all(Colors.blue),
          //     fixedSize: MaterialStateProperty.all(const Size.fromHeight(36)),
          //   ),
          //   child: Text(
          //     title1 ?? 'Leave room and transfer host',
          //     style: TextStyle(color: Colors.white, fontSize: 14),
          //   ),
          // ),
          // SizedBox(
          //   height: 6,
          // ),
          if (onTap2 != null)
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onTap2.call();
              },
              style: ButtonStyle(
                side: WidgetStateProperty.all(BorderSide(color: Colors.blue)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                fixedSize: WidgetStateProperty.all(const Size.fromHeight(36)),
              ),
              child: Text(
                title2 ?? 'Leave room',
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          SizedBox(
            height: 6,
          ),
          if (onTap3 != null)
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onTap3.call();
              },
              style: ButtonStyle(
                side: WidgetStateProperty.all(BorderSide(color: Colors.red)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
                fixedSize: WidgetStateProperty.all(const Size.fromHeight(36)),
              ),
              child: Text(
                title3 ?? 'End room',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
        ],
      );
    }

    showPopover(
      context: context,
      bodyBuilder: (context) => buildContent(),
      onPop: () => Logger.print('Popover was popped!'),
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
      barrierLabel: '',
      transition: PopoverTransition.other,
      width: 200,
      contentDyOffset: contentDyOffset,
    );
  }

  static void showMeetingDetailWidget(
    BuildContext context, {
    required String title,
    required String meetingID,
    required String invitedInfo,
    required String host,
    required String myName,
    required Stream<String> joinDurationStream,
  }) {
    Widget buildContent() {
      Widget buildInfoRow() {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${StrRes.meetingNo}: ',
              style: Styles.ts_8E9AB0_12sp,
            ),
            Text(meetingID, style: Styles.ts_8E9AB0_12sp),
            const SizedBox(
              width: 4,
            ),
            GestureDetector(
              child: Icon(
                Icons.copy_outlined,
                color: Styles.c_0089FF,
                size: 10,
              ),
              onTap: () {
                Clipboard.setData(ClipboardData(text: meetingID));
                IMViews.showToast(StrRes.copySuccessfully);
              },
            ),
            SizedBox(
              width: 4,
            ),
            // Text('${StrRes.meetingInvitedUrl}: ', style: Styles.ts_0C1C33_12sp),
            // SizedBox(
            //   width: 2,
            // ),
            // GestureDetector(
            //   child: Icon(
            //     Icons.link_outlined,
            //     color: Styles.c_0089FF,
            //     size: 10,
            //   ),
            //   onTap: () {
            //     Clipboard.setData(ClipboardData(text: invitedInfo));
            //     IMViews.showToast(StrRes.copySuccessfully);
            //   },
            // ),
          ],
        );
      }

      Widget buildSimpleRow(String title, String value) {
        return Row(
          children: [
            Text(
              '$title: ',
              style: Styles.ts_8E9AB0_12sp,
            ),
            Text(value, style: Styles.ts_0C1C33_12sp),
          ],
        );
      }

      final items = [
        Text(title, style: TextStyle(fontSize: 14, color: Styles.c_0C1C33)),
        buildInfoRow(),
        buildSimpleRow(StrRes.meetingHost, host),
        // buildSimpleRow(StrRes.yourMeetingName, myName),
        StreamBuilder<String>(
            stream: joinDurationStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildSimpleRow(StrRes.meetingJoinDuration, snapshot.data!);
              } else {
                return buildSimpleRow(StrRes.meetingJoinDuration, '-');
              }
            })
      ];

      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.16), offset: Offset(0, 3), blurRadius: 12, spreadRadius: 1),
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return items[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 12,
            );
          },
          itemCount: items.length,
        ),
      );
    }

    showPopover(
      context: context,
      bodyBuilder: (context) => buildContent(),
      onPop: () => Logger.print('Popover was popped!'),
      backgroundColor: Colors.white,
      transition: PopoverTransition.other,
      width: 300,
    );
  }

  static void showSimple(BuildContext context,
      {double contentDyOffset = 0,
      required String title1,
      required VoidCallback onTap1,
      String? title2,
      VoidCallback? onTap2}) {
    // internal
    Widget buildContent() {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: [
          TextButton(
              onPressed: onTap1,
              child: Text(
                title1,
                style: Styles.ts_0C1C33_14sp,
              )),
          const SizedBox(
            height: 6,
          ),
          if (title2 != null)
            TextButton(
                onPressed: onTap2,
                child: Text(
                  title2,
                  style: Styles.ts_0C1C33_14sp,
                )),
        ],
      );
    }

    showPopover(
      context: context,
      bodyBuilder: (context) => buildContent(),
      onPop: () => Logger.print('Popover was popped!'),
      backgroundColor: Colors.white,
      transition: PopoverTransition.other,
      width: 100,
      contentDyOffset: contentDyOffset,
    );
  }

  static void showRoomSetting(BuildContext context,
      {bool allowParticipantUnMute = false,
      bool allowParticipantVideo = false,
      bool onlyHostCanShareScreen = false,
      bool defaultMuted = false,
      Future<bool?> Function(RoomSetting setting, bool to)? onOperation,
      VoidCallback? onPop}) {
    // internal
    Widget buildContent() {
      return RoomSettingPanel(
        allowParticipantUnMute: allowParticipantUnMute,
        allowParticipantVideo: allowParticipantVideo,
        onlyHostCanShareScreen: onlyHostCanShareScreen,
        defaultMuted: defaultMuted,
        onOperation: onOperation,
      );
    }

    showPopover(
      context: context,
      bodyBuilder: (context) => buildContent(),
      onPop: onPop,
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
      transition: PopoverTransition.other,
      width: 214.h,
    );
  }

  static void showEnableCameraSetting(BuildContext context,
      {bool enableCamera = false, ValueChanged<bool>? onOperation, VoidCallback? onPop}) {
    bool selected = enableCamera;
    // internal
    Widget buildContent() {
      return Padding(
        padding: EdgeInsets.only(right: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(builder: (context, setState) {
              return Checkbox(
                  value: selected,
                  onChanged: (value) {
                    final temp = !selected;
                    onOperation?.call(temp);

                    setState(() {
                      selected = temp;
                    });
                  });
            }),
            Text(
              StrRes.meetingEnableVideo,
              style: Styles.ts_0C1C33_14sp,
            )
          ],
        ),
      );
    }

    showPopover(
      context: context,
      bodyBuilder: (context) => buildContent(),
      onPop: () {
        onPop?.call();
        Logger.print('Popover was popped!');
      },
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
      transition: PopoverTransition.other,
    );
  }

  static void showSimpleWidget(BuildContext context, Widget widget,
      {PopoverDirection direction = PopoverDirection.bottom, double arrowDxOffset = 0}) {
    showPopover(
        context: context,
        bodyBuilder: (context) => widget,
        onPop: () => Logger.print('Popover was popped!'),
        transition: PopoverTransition.other,
        direction: direction,
        arrowDxOffset: arrowDxOffset,
        arrowHeight: 0);
  }
}
