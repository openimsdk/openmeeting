import 'package:get/get.dart';

import 'selected_timezone_controller.dart';

class SelectedTimezoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedTimezoneController>(
      () => SelectedTimezoneController(),
    );
  }
}
