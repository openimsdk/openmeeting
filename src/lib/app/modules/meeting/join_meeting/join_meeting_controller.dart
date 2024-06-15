import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';

import '../../../../core/app_controller.dart';
import '../../../../core/data_sp.dart';
import '../../../../core/multi_window_manager.dart';
import '../../../data/models/meeting_option.dart';
import '../../../data/services/repository/repository_adapter.dart';
import '../meeting_room/meeting_client.dart';

class JoinMeetingController extends GetxController {
  final meetingNumberCtrl = TextEditingController();
  final enterPswCtrl = TextEditingController();
  final userInfo = Get.find<AppController>().userInfo!;
  final enabled = false.obs;

  final isEnableMicrophone = false.obs;
  final isEnableSpeaker = false.obs;
  final isEnableVideo = false.obs;
  final videoIsMirroring = false.obs;

  final IMeetingRepository repository;

  JoinMeetingController({required this.repository});

  @override
  void onInit() {
    meetingNumberCtrl.addListener(() {
      enabled.value = meetingNumberCtrl.text.trim().isNotEmpty;
    });
    super.onInit();

    isEnableMicrophone.value = DataSp.getMeetingEnableMicrophone();
    isEnableSpeaker.value = DataSp.getMeetingEnableSpeaker();
    isEnableVideo.value = DataSp.getMeetingEnableVideo();
    videoIsMirroring.value = DataSp.getMeetingEnableVideoMirroring();
  }

  @override
  void onClose() {
    meetingNumberCtrl.dispose();
    enterPswCtrl.dispose();
    super.onClose();
  }

  void toggleMicrophoneStatus() async {
    isEnableMicrophone.value = !isEnableMicrophone.value;
  }

  void toggleVideoMirroring() async {
    videoIsMirroring.value = !videoIsMirroring.value;
  }

  void toggleVideoStatus() async {
    isEnableVideo.value = !isEnableVideo.value;
  }

  void toggleSpeakerStatus() async {
    isEnableSpeaker.value = !isEnableSpeaker.value;
  }

  Future<MeetingInfoSetting?> getMeetingInfo() async {
    return repository.getMeetingInfo(meetingNumberCtrl.text.trim(), userInfo.userId);
  }

  Future<bool> joinMeeting(String? password) async {
    final meetingID = meetingNumberCtrl.text.trim();
    final certificate = await repository.joinMeeting(meetingID, userInfo.userId, password: password);

    if (certificate == null) {
      return false;
    } else {
      if (PlatformExt.isDesktop) {
        windowsManager.newRoom(userInfo.toPBUser(), certificate, meetingID);
      } else {
        MeetingClient().connect(Get.context!,
            url: certificate.url,
            token: certificate.token,
            roomID: meetingID,
            options: MeetingOptions(
              enableMicrophone: isEnableMicrophone.value,
              enableSpeaker: isEnableSpeaker.value,
              enableVideo: isEnableVideo.value,
              videoIsMirroring: videoIsMirroring.value,
            ));
      }
      return true;
    }
  }
}
