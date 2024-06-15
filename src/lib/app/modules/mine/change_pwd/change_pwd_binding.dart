import 'package:get/get.dart';

import 'change_pwd_controller.dart';

class ChangePwdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePwdController());
  }
}
