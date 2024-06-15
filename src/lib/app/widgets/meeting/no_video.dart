import 'dart:math' as math;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:openim_common/openim_common.dart';

class NoVideoWidget extends StatelessWidget {
  //
  const NoVideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (ctx, constraints) => Icon(
            EvaIcons.videoOffOutline,
            color: Styles.c_0089FF,
            size: math.min(constraints.maxHeight, constraints.maxWidth) * 0.3,
          ),
        ),
      );
}

class NoVideoAvatarWidget extends StatelessWidget {
  //
  const NoVideoAvatarWidget({
    Key? key,
    this.nickname,
    this.faceURL,
    this.width,
    this.height,
  }) : super(key: key);
  final String? nickname;
  final String? faceURL;
  final double? width;
  final double? height;

  //

  @override
  Widget build(BuildContext context) => null != faceURL && IMUtils.isUrlValid(faceURL!) || null != nickname
      ? /*ImageUtil.networkImage(
              url: faceURL!,
              fit: BoxFit.cover,
              width: width,
              height: height,
              borderRadius: BorderRadius.circular(6.r),
            )*/
      Container(
          alignment: Alignment.center,
          child: AvatarView(
            url: faceURL,
            text: nickname,
          ),
        )
      : const NoVideoWidget();
}
