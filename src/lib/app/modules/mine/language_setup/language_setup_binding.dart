import 'package:get/get.dart';

import 'language_setup_controller.dart';

class LanguageSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageSetupController());
  }
}
