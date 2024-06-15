import 'package:get/get.dart';

import 'repeat_ends_controller.dart';

class RepeatEndsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepeatEndsController>(
      () => RepeatEndsController(
          endsInDays: Get.parameters['endsInDays'] != null ? int.tryParse(Get.parameters['endsInDays']!) : null,
          maxLimit: Get.parameters['maxLimit'] != null ? int.tryParse(Get.parameters['maxLimit']!) : null),
    );
  }
}
