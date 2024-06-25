import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/define.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';
import 'package:openmeeting/app/data/services/repository/repository.dart';
import 'package:openmeeting/core/data_sp.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../core/multi_window_manager.dart';
import '../../../../main.dart';
import '../../../data/models/meeting_option.dart';
import 'room_mobile/room.dart';

class MeetingClient {
  MeetingClient._();

  static final MeetingClient _singleton = MeetingClient._();

  factory MeetingClient.singleton() {
    return _singleton;
  }

  factory MeetingClient() {
    return MeetingClient.singleton();
  }

  late UserInfo userInfo;

  OverlayEntry? _holder;

  set busy(bool value) {
    DataSp.putMeetingClientIsBusy(value);
  }

  bool get isBusy => DataSp.getMeetingClientIsBusy();

  String? roomID;

  VoidCallback? onClose;

  void close() async {
    if (PlatformExt.isDesktop) {
      return;
    }

    roomID = null;
    onClose?.call();

    if (_holder != null) {
      _holder?.remove();
      _holder = null;
    }

    busy = false;
    // The next line disables the wakelock again.
    if (await WakelockPlus.enabled) WakelockPlus.disable();
  }

  void closeWindow({bool realClose = false}) async {
    if (PlatformExt.isMobile) {
      return;
    }

    if (realClose) {
      await windowsManager.closeAllSubWindows();
    } else {
      final controller = WindowController.fromWindowId(kWindowId!);

      await controller.hide();
      await windowsManager.call(WindowType.room, WindowEvent.hide, {"id": kWindowId!});
    }

    busy = false;
  }

  Future<({EventsListener<RoomEvent> listener, Room room})?> connect(
    BuildContext ctx, {
    required String url,
    required String token,
    required String roomID,
    MeetingOptions options = const MeetingOptions(),
  }) async {
    Logger.print(
        '=======options: enableMicrophone: ${options.enableMicrophone}, enableSpeaker: ${options.enableSpeaker}, enableVideo: ${options.enableVideo}, videoIsMirroring: ${options.videoIsMirroring} \n token: $token url: $url roomID: $roomID =======');
    try {
      if (isBusy) return null;
      busy = true;

      FocusScope.of(ctx).requestFocus(FocusNode());
      //create new room
      final room = Room();
      // Create a Listener before connecting
      final listener = room.createListener();

      await LoadingView.singleton.wrap(asyncFunction: () async {
        // Try to connect to the room
        // This will throw an Exception if it fails for any reason.
        return room.connect(
          url,
          token,
          roomOptions: RoomOptions(
            dynacast: true,
            adaptiveStream: true,
            defaultCameraCaptureOptions: const CameraCaptureOptions(params: VideoParametersPresets.h720_169),
            defaultVideoPublishOptions: const VideoPublishOptions(
                simulcast: true,
                videoCodec: 'VP8',
                videoEncoding: VideoEncoding(
                  maxBitrate: 5 * 1000 * 1000,
                  maxFramerate: 15,
                )),
            defaultAudioOutputOptions: AudioOutputOptions(speakerOn: options.enableSpeaker),
            defaultScreenShareCaptureOptions:
                const ScreenShareCaptureOptions(useiOSBroadcastExtension: true, maxFrameRate: 15.0),
          ),
        );
      });
      // The following line will enable the Android and iOS wakelock.
      if (!await WakelockPlus.enabled) WakelockPlus.enable();

      this.roomID = roomID;

      if (PlatformExt.isDesktop) {
        return (room: room, listener: listener);
      } else {
        if (!ctx.mounted) {
          return null;
        }

        Overlay.of(ctx).insert(
          _holder = OverlayEntry(
            builder: (context) => MeetingRoom(
              room,
              listener,
              roomID: roomID,
              onOperation: operateRoom,
              onParticipantOperation: operateParticipants,
              // onClose: close,
              options: options,
            ),
          ),
        );

        return (room: room, listener: listener);
      }
    } catch (error, trace) {
      close();
      Logger.print("error:$error  stack:$trace");
      if (error.toString().contains('NotExist')) {
        IMViews.showToast(StrRes.meetingIsOver);
      } else {
        IMViews.showToast(StrRes.networkError);
      }
      return null;
    }
  }

  void operateRoom<T>(BuildContext? context, OperationType type, {T? value}) async {
    final loginUserID = userInfo.userID;

    switch (type) {
      case OperationType.participants:
        break;
      case OperationType.roomSettings:
        final setting = value as MeetingSetting;
        final params = setting.toProto3Json() as Map<String, dynamic>;
        params['meetingID'] = roomID!;
        params['updatingUserID'] = loginUserID;

        MeetingRepository().updateMeetingSetting(UpdateMeetingRequest()..mergeFromProto3Json(params));
        break;
      case OperationType.leave:
        await MeetingRepository().leaveMeeting(roomID!, loginUserID);
        close();
        closeWindow();
        break;
      case OperationType.end:
        await MeetingRepository().endMeeting(roomID!, loginUserID);
        close();
        closeWindow();
        break;
      case OperationType.setting:
        break;
      case OperationType.onlyClose:
        closeWindow();
        break;
    }
  }

  Future<bool> operateParticipants<T>({OperationParticipantType? type, String? userID, T? to}) async {
    final loginUserID = userInfo.userID;
    switch (type) {
      case OperationParticipantType.pined:
        return Future(() => true);
      case OperationParticipantType.focus:
        return Future(() => true);
      case OperationParticipantType.camera:
        final setting = PersonalMeetingSetting();
        setting.cameraOnEntry = to! as bool;

        return MeetingRepository().setPersonalSetting(roomID!, userID!, setting);
      case OperationParticipantType.microphone:
        final setting = PersonalMeetingSetting();
        setting.microphoneOnEntry = to! as bool;

        return MeetingRepository().setPersonalSetting(roomID!, userID!, setting);
      case OperationParticipantType.muteAll:
        final result =
            await MeetingRepository().operateAllStream(roomID!, loginUserID, microphoneOnEntry: !(to as bool));

        return result;
      case OperationParticipantType.nickname:
        final result = await MeetingRepository().modifyParticipantName(
          meetingID: roomID!,
          userID: loginUserID,
          participantUserID: userID!,
          nickname: to! as String,
        );

        return result;
      case OperationParticipantType.setHost:
        final result = await MeetingRepository().setMeetingHost(
          meetingID: roomID!,
          userID: loginUserID,
          hostUserID: userID!,
          coHostUserIDs: [],
        );

        return result;
      case OperationParticipantType.kickoff:
        final result = await MeetingRepository().kickParticipant(
          meetingID: roomID!,
          userID: loginUserID,
          participantUserIDs: [userID!],
        );

        return result;
      case null:
        return Future(() => false);
    }
  }
}
