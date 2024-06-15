import 'package:get/get.dart';
import '../../../data/services/repository/repository.dart';
import '../../../data/services/repository/repository_adapter.dart';

import 'meeting_controller.dart';

class MeetingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMeetingRepository>(() => MeetingRepository());
    Get.lazyPut(() => MeetingController(repository: Get.find()));
  }
}
