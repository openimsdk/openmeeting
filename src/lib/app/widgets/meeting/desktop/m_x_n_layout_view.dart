import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';

import '../../../data/models/meeting_option.dart';
import '../participant.dart';
import '../participant_info.dart';

class MxNLayoutView extends StatefulWidget {
  const MxNLayoutView({super.key, required this.participantTracks, this.onDoubleTap, this.options});

  final List<ParticipantTrack> participantTracks;
  final ValueChanged<ParticipantTrack>? onDoubleTap;
  final MeetingOptions? options;

  @override
  State<MxNLayoutView> createState() => _MxNLayoutViewState();
}

class _MxNLayoutViewState extends State<MxNLayoutView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widget.participantTracks.map((e) => SizedBox(width: 73, height: 105, child: _participantWidgetFor(e))).toList(),
      ),
    );
  }

  Widget _participantWidgetFor(ParticipantTrack track) {
    Logger.print('_participantWidgetFor: ${track.participant.metadata}'
        'videoTrack:${track.videoTrack != null} '
        'screenShareTrack:${track.screenShareTrack != null} '
        'muted:${track.videoTrack?.muted} '
        'muted:${track.screenShareTrack?.muted}');
    return GestureDetector(
        onDoubleTap: () {
          widget.onDoubleTap?.call(track);
        },
        child: ParticipantWidget.widgetFor(track,
            useScreenShareTrack: track.screenShareTrack != null && !track.screenShareTrack!.muted,
            options: track.participant is LocalParticipant ? widget.options : null,
            backgroundColor: Colors.white));
  }
}
