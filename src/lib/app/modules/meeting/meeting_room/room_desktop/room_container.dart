import 'dart:async';
import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';
import 'package:openmeeting/main.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../core/multi_window_manager.dart';
import '../../../../data/models/define.dart';
import '../../../../widgets/meeting/desktop/participants_view.dart';
import '../../../../widgets/meeting/participant_info.dart';
import '../meeting_client.dart';
import 'room_desktop.dart';

class MeetingRoomContainer extends StatefulWidget {
  const MeetingRoomContainer(
      {super.key,
      required this.url,
      required this.token,
      required this.roomID,
      required this.listener,
      required this.room,
      this.onOperation,
      this.onParticipantOperation});

  final String url;
  final String token;
  final String roomID;
  final EventsListener<RoomEvent> listener;
  final Room room;
  final void Function<T>(BuildContext? context, OperationType type, {T? value})? onOperation;
  final Future<bool> Function<T>({OperationParticipantType type, String userID, T to})? onParticipantOperation;

  @override
  State<MeetingRoomContainer> createState() => _MeetingRoomContainerState();
}

class _MeetingRoomContainerState extends State<MeetingRoomContainer> {
  bool showParticipants = false;
  BehaviorSubject<MeetingInfoSetting>? meetingInfoChangedSubject;
  BehaviorSubject<List<ParticipantTrack>>? participantsSubject;
  String loginUserID = MeetingClient().userInfo.userID;

  @override
  void initState() {
    super.initState();

    meetingInfoChangedSubject?.stream.listen((event) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: MeetingDesktopRoom(
            widget.room,
            widget.listener,
            roomID: widget.roomID,
            onOperation: _operateRoom,
            onSubjectInit: (meetingInfoChangedSubject, participantsSubject) {
              this.meetingInfoChangedSubject = meetingInfoChangedSubject;
              this.participantsSubject = participantsSubject;
            },
          ),
        ),
        if (showParticipants)
          VerticalDivider(
            color: Colors.grey.shade200,
            width: 2,
          ),
        if (showParticipants)
          Container(
            constraints: BoxConstraints(maxWidth: 350),
            child: ParticipantsDesktopView(
              participantsSubject: participantsSubject!,
              meetingInfoChangedSubject: meetingInfoChangedSubject!,
              loginUserID: loginUserID,
              onRollup: () {
                _showParticipants();
              },
              onOperation: MeetingClient().operateParticipants,
              onRoomOperation: MeetingClient().operateRoom,
            ),
          ),
      ],
    );
  }

  Future<void> _showParticipants() async {
    var bounds = await WindowController.fromWindowId(kWindowId!).getFrame();
    if (!showParticipants) {
      bounds = Offset(bounds.left, bounds.top) & Size(bounds.width + 320, bounds.height);
    } else {
      bounds = Offset(bounds.left, bounds.top) & Size(bounds.width - 320, bounds.height);
    }

    WindowController.fromWindowId(kWindowId!).setFrame(bounds);

    setState(() {
      showParticipants = !showParticipants;
    });
  }

  void _operateRoom<T>(BuildContext? context, OperationType type, {T? value}) async {
    if (type == OperationType.participants) {
      _showParticipants();
    } else {
      return MeetingClient().operateRoom(context, type, value: value);
    }
  }

  void _showSettings() {
    if (PlatformExt.isDesktop) {
      windowsManager.newSetting(MeetingClient().userInfo);
    }
  }
}
