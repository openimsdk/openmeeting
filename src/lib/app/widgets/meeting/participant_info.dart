import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';

class ParticipantTrack {
  ParticipantTrack({
    required this.participant,
    required this.videoTrack,
    required this.screenShareTrack,
    this.isHost = false,
  });

  VideoTrack? videoTrack;
  VideoTrack? screenShareTrack;
  Participant participant;

  bool isHost;

  bool get isScreenShare => screenShareTrack != null;

  String get nickname {
    if (participant.metadata == null) {
      return '';
    }
    final jsonObj = jsonDecode(participant.metadata!) as Map<String, dynamic>;

    return jsonObj['userInfo']['nickname'] ?? '';
  }
}

abstract class ParticipantInfoWidget extends StatelessWidget {
  //
  final String? title;
  final bool audioAvailable;
  final ConnectionQuality connectionQuality;
  final bool isScreenShare;
  final bool isHost;

  const ParticipantInfoWidget({
    this.title,
    this.audioAvailable = true,
    this.connectionQuality = ConnectionQuality.unknown,
    this.isScreenShare = false,
    this.isHost = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context);
}

class ParticipantInfoNoAvatarWidgetDesktop extends ParticipantInfoWidget {
  const ParticipantInfoNoAvatarWidgetDesktop(
      {super.key, required super.title, required super.audioAvailable, required super.connectionQuality, required super.isHost, super.isScreenShare});

  @override
  Widget buildBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: isHost,
          child: SizedBox(
            width: 16.h,
            child: ImageRes.meetingPerson.toImage
              ..width = 13.h
              ..height = 13.h,
          ),
        ),
        if (title != null) Text(title ?? '', style: Styles.ts_0C1C33_12sp, maxLines: 1, overflow: TextOverflow.ellipsis),
        Container(
            width: 13.h,
            height: 13.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: (audioAvailable ? ImageRes.meetingMicOnWhite : ImageRes.meetingMicOffWhite).toImage
              ..width = 13.h
              ..height = 13.h),
      ],
    );
  }
}

class ParticipantInfoWidgetDesktop extends ParticipantInfoWidget {
  const ParticipantInfoWidgetDesktop(
      {super.key, required super.title, required super.audioAvailable, required super.connectionQuality, required super.isHost, super.isScreenShare});

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.35), borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: isHost,
            child: SizedBox(
              width: 16.h,
              child: ImageRes.meetingPerson.toImage
                ..width = 13.h
                ..height = 13.h,
            ),
          ),
          if (title != null) Text(title ?? '', style: TextStyle(color: Colors.white, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
          SizedBox(
              width: 16.h,
              child: (audioAvailable ? ImageRes.meetingMicOnWhite : ImageRes.meetingMicOffWhite).toImage
                ..width = 13.h
                ..height = 13.h),
        ],
      ),
    );
  }
}

class ParticipantInfoWidgetMobile extends ParticipantInfoWidget {
  const ParticipantInfoWidgetMobile(
      {super.key, required super.title, required super.audioAvailable, required super.connectionQuality, required super.isHost, super.isScreenShare});

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isHost)
            ImageRes.meetingPerson.toImage
              ..width = 17.w
              ..height = 17.h,
          Container(
            decoration: BoxDecoration(
              color: Styles.c_0C1C33_opacity30,
              borderRadius: BorderRadius.circular(10.r),
            ),
            margin: EdgeInsets.only(left: 2.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            child: Row(
              children: [
                (audioAvailable ? ImageRes.meetingMicOnWhite : ImageRes.meetingMicOffWhite).toImage
                  ..width = 13.w
                  ..height = 13.h,
                if (title != null) title!.toText..style = Styles.ts_FFFFFF_12sp,
                if (connectionQuality != ConnectionQuality.unknown)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                      connectionQuality == ConnectionQuality.poor ? EvaIcons.wifiOffOutline : EvaIcons.wifi,
                      color: {
                        ConnectionQuality.excellent: Colors.green,
                        ConnectionQuality.good: Colors.orange,
                        ConnectionQuality.poor: Colors.red,
                      }[connectionQuality],
                      size: 16,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
