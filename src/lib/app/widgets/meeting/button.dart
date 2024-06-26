import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';
import 'package:sprintf/sprintf.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    required this.icon,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    this.onTap,
    this.label,
    this.textStyle,
    this.expanded = false,
    this.enabled = true,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
  });
  final String icon;
  final double? iconWidth;
  final double? iconHeight;
  final double? width;
  final double? height;
  final Function()? onTap;
  final String? label;
  final TextStyle? textStyle;
  final bool expanded;
  final bool enabled;
  final Color? color;
  final Widget? rightIcon;
  final ValueChanged<BuildContext?>? onPressedRightIcon;

  const ImageButton.minimize({
    super.key,
    this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
  })  : label = null,
        textStyle = null,
        icon = ImageRes.liveClose,
        enabled = true,
        expanded = false;

  const ImageButton.trumpet({
    super.key,
    this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
    bool on = true,
  })  : label = null,
        textStyle = null,
        icon = on ? ImageRes.meetingTrumpet : ImageRes.meetingEar,
        expanded = false,
        enabled = true;

  const ImageButton.expandArrow({
    super.key,
    this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
  })  : label = null,
        textStyle = null,
        icon = ImageRes.meetingExpandArrow,
        expanded = false,
        enabled = true;

  ImageButton.microphone({
    super.key,
    this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    bool on = true,
    this.enabled = true,
    this.textStyle,
    this.expanded = true,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
  })  : label = on ? StrRes.meetingMute : StrRes.meetingUnmute,
        icon = on ? ImageRes.meetingMicOnWhite : ImageRes.meetingMicOffWhite;

  ImageButton.camera({
    super.key,
    this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    bool on = true,
    this.enabled = true,
    this.textStyle,
    this.expanded = true,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
  })  : label = on ? StrRes.meetingCloseVideo : StrRes.meetingOpenVideo,
        icon = on ? ImageRes.meetingCameraOnWhite : ImageRes.meetingCameraOffWhite;

  ImageButton.screenShare({
    super.key,
    this.onTap,
    bool on = true,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    this.enabled = true,
    this.textStyle,
    this.expanded = true,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
  })  : label = on ? StrRes.meetingEndSharing : StrRes.meetingShareScreen,
        icon = on ? ImageRes.meetingScreenShareOn : ImageRes.meetingScreenShareOff;

  ImageButton.members({
    super.key,
    int count = 0,
    this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    this.textStyle,
    this.expanded = true,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
  })  : label = sprintf(StrRes.meetingMembers, [count]),
        icon = ImageRes.meetingMembers,
        enabled = true;

  ImageButton.settings({
    super.key,
    this.onTap,
    this.iconWidth,
    this.iconHeight,
    this.width,
    this.height,
    this.textStyle,
    this.expanded = true,
    this.color,
    this.rightIcon,
    this.onPressedRightIcon,
  })  : label = StrRes.settings,
        icon = ImageRes.meetingSetting,
        enabled = true;

  @override
  Widget build(BuildContext context) {
    return expanded
        ? Expanded(child: rightIcon != null ? _desktopChild : _child)
        : rightIcon != null
            ? _desktopChild
            : _child;
  }

  Widget get _child => Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: enabled ? 1 : .5,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon.toImage
                  ..width = (iconWidth ?? 30.w)
                  ..height = (iconHeight ?? 30.h)
                  ..color = color,
                if (null != label) label!.toText..style = textStyle ?? Styles.ts_FFFFFF_10sp,
              ],
            ),
          ),
        ),
      ));

  Widget get _desktopChild => Material(
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Opacity(
            opacity: enabled ? 1 : .5,
            child: InkWell(
              onTap: enabled ? onTap : null,
              child: SizedBox(
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon.toImage
                      ..width = (iconWidth ?? 30.w)
                      ..height = (iconHeight ?? 30.h)
                      ..color = color,
                    if (null != label) label!.toText..style = textStyle ?? Styles.ts_FFFFFF_10sp,
                  ],
                ),
              ),
            ),
          ),
          if (rightIcon != null)
            Builder(builder: (ctx) {
              return IconButton(
                onPressed: !enabled
                    ? null
                    : () {
                        onPressedRightIcon?.call(ctx);
                      },
                icon: rightIcon!,
              );
            }),
        ],
      ));
}
