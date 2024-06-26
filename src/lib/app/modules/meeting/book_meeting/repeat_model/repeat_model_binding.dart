import 'package:get/get.dart';

import 'repeat_model_controller.dart';

class RepeatModelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepeatModelController>(
      () => RepeatModelController(config: Get.arguments['config']),
    );
  }
}
