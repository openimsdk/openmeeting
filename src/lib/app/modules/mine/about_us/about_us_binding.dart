import 'package:get/get.dart';

import 'about_us_controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}
