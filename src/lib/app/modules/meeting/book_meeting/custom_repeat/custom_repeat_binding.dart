import 'package:get/get.dart';

import 'custom_repeat_controller.dart';

class CustomRepeatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomRepeatController>(
      () => CustomRepeatController(
        config: Get.arguments['config'],
      ),
    );
  }
}
