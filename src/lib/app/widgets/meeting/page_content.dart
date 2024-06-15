import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';

import '../../data/models/meeting_option.dart';
import 'participant.dart';
import 'participant_info.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
    required this.participantTrack,
    this.options,
  }) : super(key: key);
  final ParticipantTrack participantTrack;
  final MeetingOptions? options;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ParticipantWidget.widgetFor(participantTrack,
            useScreenShareTrack: true,
            isZoom: true,
            options: participantTrack.participant is LocalParticipant ? options : null,
            onTapSwitchCamera: participantTrack.participant is LocalParticipant
                ? () {
                    participantTrack.toggleCamera();
                  }
                : null),
      ],
    );
  }
}

class OtherPage extends StatelessWidget {
  const OtherPage({
    Key? key,
    required this.participantTracks,
    required this.pages,
    this.pageSize = 4,
    this.options,
    this.onDoubleTap,
  }) : super(key: key);
  final List<ParticipantTrack> participantTracks;
  final int pages;
  final int pageSize;
  final ValueChanged<ParticipantTrack>? onDoubleTap;
  final MeetingOptions? options;
  List<ParticipantTrack> get list => participantTracks.sublist(pages * pageSize, min((pages + 1) * pageSize, participantTracks.length));

  Widget _participantWidgetFor(ParticipantTrack track) {
    Logger.print('_participantWidgetFor: ${track.participant.metadata}'
        'videoTrack:${track.videoTrack != null} '
        'screenShareTrack:${track.screenShareTrack != null} '
        'muted:${track.videoTrack?.muted} '
        'muted:${track.screenShareTrack?.muted}');
    return GestureDetector(
        onDoubleTap: () {
          onDoubleTap?.call(track);
        },
        child: ParticipantWidget.widgetFor(track,
            useScreenShareTrack: track.screenShareTrack != null && !track.screenShareTrack!.muted,
            options: track.participant is LocalParticipant ? options : null,
            onTapSwitchCamera: track.participant is LocalParticipant
                ? () {
                    track.toggleCamera();
                  }
                : null));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: list.isNotEmpty ? _participantWidgetFor(list[0]) : const SizedBox(),
              ),
              1.horizontalSpace,
              Expanded(
                child: list.length > 1 ? _participantWidgetFor(list[1]) : const SizedBox(),
              ),
            ],
          ),
        ),
        1.verticalSpace,
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: list.length > 2 ? _participantWidgetFor(list[2]) : const SizedBox(),
              ),
              Expanded(
                child: list.length > 3 ? _participantWidgetFor(list[3]) : const SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
    // return GridView.count(
    //   crossAxisCount: 2,
    //   mainAxisSpacing: 1.h,
    //   crossAxisSpacing: 1.w,
    //   // childAspectRatio: 187 / 309.5,
    //   children: list.map((e) => ParticipantWidget.widgetFor(e)).toList(),
    // );
  }
}
