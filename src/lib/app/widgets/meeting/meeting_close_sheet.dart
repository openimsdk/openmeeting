import 'package:flutter/material.dart';
import 'package:openim_common/openim_common.dart';

import 'overlay_widget.dart';

class MeetingCloseSheetView extends StatelessWidget {
  const MeetingCloseSheetView({
    Key? key,
    this.isHost = false,
    this.controller,
    this.onEnd,
    this.onLeave,
  }) : super(key: key);
  final AnimationController? controller;
  final Function()? onLeave;
  final Function()? onEnd;
  final bool isHost;

  @override
  Widget build(BuildContext context) => BottomSheetView(
        isOverlaySheet: true,
        onCancel: () => controller?.reverse(),
        items: [
          SheetItem(
            label: StrRes.leaveMeeting,
            onTap: () => controller?.reverse().then((value) {
              OverlayWidget().showDialog(
                context: context,
                child: CustomDialog(
                  onTapLeft: OverlayWidget().dismiss,
                  onTapRight: () {
                    OverlayWidget().dismiss();
                    onLeave?.call();
                  },
                  title: StrRes.leaveMeetingConfirmHint,
                ),
              );
            }),
          ),
          if (isHost)
            SheetItem(
              label: StrRes.endMeeting,
              textStyle: Styles.ts_FF381F_17sp,
              onTap: () => controller?.reverse().then((value) {
                OverlayWidget().showDialog(
                  context: context,
                  child: CustomDialog(
                    onTapLeft: OverlayWidget().dismiss,
                    onTapRight: () {
                      OverlayWidget().dismiss();
                      onEnd?.call();
                    },
                    title: StrRes.endMeetingConfirmHit,
                  ),
                );
              }),
            ),
        ],
      );
}
