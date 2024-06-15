import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';

import '../../../../data/models/define.dart';

class ModelItem {
  final RepeatType type;
  final int value;

  ModelItem({required this.type, required this.value});
}

class RepeatModelController extends GetxController {
  final int? rawType;

  RepeatModelController({this.rawType});

  final modelList = <ModelItem>[].obs;
  // final customModel = ModelItem(title: StrRes.custom, value: -1).obs;
  RepeatType type = RepeatType.none;
  final weekday = DateUtil.getWeekday(DateTime.now(), languageCode: Get.locale!.languageCode);

  @override
  void onInit() {
    super.onInit();
    type = rawType?.repeatType ?? RepeatType.none;

    modelList.addAll([
      ModelItem(type: RepeatType.none, value: 0),
      ModelItem(type: RepeatType.daily, value: 1),
      ModelItem(type: RepeatType.weekday, value: 2),
      ModelItem(type: RepeatType.weekly, value: 3),
      ModelItem(type: RepeatType.biweekly, value: 4),
      ModelItem(type: RepeatType.monthly, value: 5),
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
