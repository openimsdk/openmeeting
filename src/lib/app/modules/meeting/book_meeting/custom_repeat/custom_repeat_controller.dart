import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

class CustomRepeatController extends GetxController {
  final units = [StrRes.day, StrRes.week, StrRes.month];
  final values = [
    List.generate(100, (index) => index + 1),
    List.generate(12, (index) => index + 1),
    List.generate(12, (index) => index + 1),
  ];

  final selectedUnit = 0.obs;
  final selectedValue = 0.obs;

  @override
  void onInit() {
    super.onInit();
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
