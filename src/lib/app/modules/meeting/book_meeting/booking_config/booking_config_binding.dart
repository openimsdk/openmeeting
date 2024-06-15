import 'package:get/get.dart';

import '../../../../data/services/repository/repository.dart';
import 'booking_config_controller.dart';

class BookingConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingRepository>(() => MeetingRepository());
    Get.lazyPut<BookingConfigController>(
      () => BookingConfigController(repository: Get.find()),
    );
  }
}
