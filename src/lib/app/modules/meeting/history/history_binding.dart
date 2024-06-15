import 'package:get/get.dart';

import '../../../data/services/repository/repository.dart';
import '../../../data/services/repository/repository_adapter.dart';
import 'history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMeetingRepository>(() => MeetingRepository());
    Get.lazyPut<HistoryController>(
      () => HistoryController(repository: Get.find<IMeetingRepository>()),
    );
  }
}
