import 'package:get/get.dart';
import '../../../../../data/services/repository/repository_adapter.dart';
import '../../../../../data/services/repository/repository.dart';

import 'enable_camera_controller.dart';

class EnableCameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMeetingRepository>(() => MeetingRepository());
    Get.lazyPut(() => EnableCameraController(repository: Get.find()));
  }
}
