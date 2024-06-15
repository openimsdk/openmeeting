import 'package:get/get.dart';

import '../../../../core/data_sp.dart';

class MeetingSetupController extends GetxController {
  final isEnableMicrophone = false.obs;
  final isEnableSpeaker = false.obs;
  final isEnableVideo = false.obs;
  final videoIsMirroring = false.obs;

  @override
  void onInit() {
    super.onInit();
    isEnableMicrophone.value = DataSp.getMeetingEnableMicrophone();
    isEnableSpeaker.value = DataSp.getMeetingEnableSpeaker();
    isEnableVideo.value = DataSp.getMeetingEnableVideo();
    videoIsMirroring.value = DataSp.getMeetingEnableVideoMirroring();
  }

  void toggleMicrophoneStatus() async {
    isEnableMicrophone.value = !isEnableMicrophone.value;
    DataSp.putMeetingEnableMicrophone(isEnableMicrophone.value);
  }

  void toggleVideoMirroring() async {
    videoIsMirroring.value = !videoIsMirroring.value;
    DataSp.putMeetingEnableVideoMirroring(videoIsMirroring.value);
  }

  void toggleVideoStatus() async {
    isEnableVideo.value = !isEnableVideo.value;
    DataSp.putMeetingEnableVideo(isEnableVideo.value);
  }

  void toggleSpeakerStatus() async {
    isEnableSpeaker.value = !isEnableSpeaker.value;
    DataSp.putMeetingEnableSpeaker(isEnableSpeaker.value);
  }
}
