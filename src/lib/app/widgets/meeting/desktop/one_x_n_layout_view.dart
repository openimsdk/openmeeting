import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';

import '../../../data/models/meeting_option.dart';
import '../participant.dart';
import '../participant_info.dart';

class OxNLayoutView extends StatefulWidget {
  const OxNLayoutView({super.key, required this.focusParticipantTrack, required this.participantTracks, this.options, this.onTap});

  final ParticipantTrack? focusParticipantTrack;
  final List<ParticipantTrack> participantTracks;
  final MeetingOptions? options;
  final VoidCallback? onTap;

  @override
  State<OxNLayoutView> createState() => _OxNLayoutViewState();
}

class _OxNLayoutViewState extends State<OxNLayoutView> {
  ParticipantTrack? focusParticipantTrack;

  @override
  void initState() {
    super.initState();
    focusParticipantTrack = widget.participantTracks.firstWhereOrNull((element) => element.participant.hasVideo);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (focusParticipantTrack != null)
          Flexible(
            child: _participantWidgetFor(focusParticipantTrack!),
          ),
        const SizedBox(
          width: 8,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 186),
          child: ListView.separated(
            itemBuilder: (context, index) => SizedBox(width: 186, height: 105, child: _participantWidgetFor(widget.participantTracks[index])),
            itemCount: widget.participantTracks.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 8,
              );
            },
          ),
        )
      ],
    );
  }

  Widget _participantWidgetFor(ParticipantTrack track) {
    Logger.print('_participantWidgetFor: ${track.participant.metadata}'
        'videoTrack:${track.videoTrack != null} '
        'screenShareTrack:${track.screenShareTrack != null} '
        'muted:${track.videoTrack?.muted} '
        'muted:${track.screenShareTrack?.muted}');
    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
      },
      child: ParticipantWidget.widgetFor(track,
          useScreenShareTrack: track.screenShareTrack != null && !track.screenShareTrack!.muted,
          options: track.participant is LocalParticipant ? widget.options : null,
          focusModel: true),
    );
  }
}
