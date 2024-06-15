import 'package:get/get.dart';
import '../../../data/services/repository/repository.dart';
import '../../../data/services/repository/repository_adapter.dart';

import 'meeting_detail_controller.dart';

class MeetingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMeetingRepository>(() => MeetingRepository());
    Get.lazyPut(() => MeetingDetailController(repository: Get.find()));
  }
}
