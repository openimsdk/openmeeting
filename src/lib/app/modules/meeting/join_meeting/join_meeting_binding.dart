import 'package:get/get.dart';
import '../../../data/services/repository/repository_adapter.dart';
import '../../../data/services/repository/repository.dart';

import 'join_meeting_controller.dart';

class JoinMeetingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMeetingRepository>(() => MeetingRepository());
    Get.lazyPut(() => JoinMeetingController(repository: Get.find()));
  }
}
