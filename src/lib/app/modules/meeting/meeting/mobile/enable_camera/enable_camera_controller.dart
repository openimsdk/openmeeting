import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../../../core/app_controller.dart';
import '../../../../../../core/data_sp.dart';
import '../../../../../data/models/meeting_option.dart';
import '../../../../../data/services/repository/repository_adapter.dart';
import '../../../meeting_room/meeting_client.dart';

class EnableCameraController extends GetxController {
  final isEnableVideo = false.obs;

  final IMeetingRepository repository;

  EnableCameraController({required this.repository});

  @override
  void onInit() {
    super.onInit();

    isEnableVideo.value = DataSp.getMeetingEnableVideo();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toggleVideoStatus() async {
    isEnableVideo.value = !isEnableVideo.value;
  }

  String get _meetingName => sprintf(StrRes.meetingInitiatorIs, [Get.find<AppController>().userInfo!.nickname]);
}
