import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';

import '../../../data/models/meeting_option.dart';
import '../participant.dart';
import '../participant_info.dart';

class OxNLayoutView extends StatefulWidget {
  const OxNLayoutView({super.key, required this.focusParticipantTrack, required this.participantTracks, this.options, this.onTap, this.onDoubleTap});

  final ParticipantTrack? focusParticipantTrack;
  final List<ParticipantTrack> participantTracks;
  final MeetingOptions? options;
  final VoidCallback? onTap;
  final ValueChanged<ParticipantTrack>? onDoubleTap;

  @override
  State<OxNLayoutView> createState() => _OxNLayoutViewState();
}

class _OxNLayoutViewState extends State<OxNLayoutView> {
  ParticipantTrack? _focusParticipantTrack;

  @override
  void initState() {
    super.initState();
    _focusParticipantTrack = widget.focusParticipantTrack;
  }

  @override
  void didUpdateWidget(covariant OxNLayoutView oldWidget) {
    _focusParticipantTrack = widget.focusParticipantTrack;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_focusParticipantTrack != null)
          Flexible(
            child: _participantWidgetFor(_focusParticipantTrack!),
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
      onTap: widget.onTap,
      onDoubleTap: () {
        widget.onDoubleTap?.call(track);
      },
      child: ParticipantWidget.widgetFor(track,
          useScreenShareTrack: track.screenShareTrack != null && !track.screenShareTrack!.muted,
          options: track.participant is LocalParticipant ? widget.options : null,
          focusModel: true),
    );
  }
}
