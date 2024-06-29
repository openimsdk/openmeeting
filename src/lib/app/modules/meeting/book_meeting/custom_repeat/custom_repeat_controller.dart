import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openmeeting/app/data/models/booking_config.dart';
import 'package:openmeeting/app/data/models/define.dart';
import 'package:intl/intl.dart';

class CustomRepeatModelItem {
  final String title;
  final dynamic value;

  const CustomRepeatModelItem({required this.title, required this.value});
}

class CustomRepeatController extends GetxController {
  final BookingConfig? config;

  CustomRepeatController({this.config});

  final units = [
    UnitType.day,
    UnitType.week, /*UnitType.month*/
  ];
  final values = [
    List.generate(100, (index) => index + 1),
    List.generate(12, (index) => index + 1),
    List.generate(12, (index) => index + 1),
  ];

  final selectedUnit = 0.obs;
  final selectedValue = 0.obs;

  late FixedExtentScrollController unitScrollerViewController;
  late FixedExtentScrollController valueScrollerViewController;

  final selectedWeekdays = <CustomRepeatModelItem>[].obs;
  late List<CustomRepeatModelItem> weekdayValues;
  late CustomRepeatModelItem nowWeekday;

  @override
  void onInit() {
    super.onInit();

    weekdayValues = _getWeekdays();
    final DateFormat formatter = DateFormat('EEE');
    final now = formatter.format(DateTime.now());
    nowWeekday = CustomRepeatModelItem(title: now, value: DateTime.now().weekday);

    var value = [nowWeekday];
    if (config?.weekdays != null) {
      value = config!.weekdays!.map((e) => weekdayValues[e]).toList();
    }
    selectedWeekdays.value = value;

    if (config?.unit != null) {
      selectedUnit.value = units.indexWhere((element) => element == config!.unit);
    }

    if (config?.interval != null && config!.interval > 0) {
      selectedValue.value = values[selectedUnit.value].indexWhere((element) => element == config!.interval);
    }

    unitScrollerViewController = FixedExtentScrollController(initialItem: selectedUnit.value);
    valueScrollerViewController = FixedExtentScrollController(initialItem: selectedValue.value);
  }

  List<CustomRepeatModelItem> _getWeekdays() {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('EEE');

    // Find the first day of the current week (assuming Monday as the first day)
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    // Generate the list of weekdays from Monday to Friday
    return List.generate(7, (index) {
      final weekday = startOfWeek.add(Duration(days: index));
      final title = formatter.format(weekday);

      return CustomRepeatModelItem(title: title, value: weekday.weekday);
    });
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
