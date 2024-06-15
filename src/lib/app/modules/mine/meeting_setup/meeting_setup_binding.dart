import 'package:get/get.dart';

import 'meeting_setup_controller.dart';

class MeetingSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MeetingSetupController());
  }
}
