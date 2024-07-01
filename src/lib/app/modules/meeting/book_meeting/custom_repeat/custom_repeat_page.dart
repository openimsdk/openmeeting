import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/define.dart';
import 'package:openmeeting/app/modules/meeting/book_meeting/booking_config/booking_config_controller.dart';
import 'package:openmeeting/routes/m_navigator.dart';
import 'package:sprintf/sprintf.dart';

import 'custom_repeat_controller.dart';

class CustomRepeatPage extends GetView<CustomRepeatController> {
  const CustomRepeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(StrRes.confirm),
          onPressed: () {
            final c = Get.find<BookingConfigController>();

            final unit = controller.units[controller.selectedUnit.value].rawValue;
            final interval = controller.values[controller.selectedUnit.value][controller.selectedValue.value];

            c.bookingConfig.update((val) {
              val?.repeatType = RepeatType.custom;
              val?.unit = UnitTypeExt.fromString(unit);
              val?.interval = interval;
              final ws = controller.selectedWeekdays.map((e) => e.value).toList();
              val?.repeatDaysOfWeek = List<int>.from(ws);
            });

            MNavigator.popToBookMeeting();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16),
                color: Colors.white,
                constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: 52.h, maxHeight: 52.h),
                child: Obx(
                  () => Text(
                    sprintf(StrRes.customRepeatModelHint, [
                      '${controller.values[controller.selectedUnit.value][controller.selectedValue.value]}${controller.units[controller.selectedUnit.value].title}'
                    ]),
                    style: Styles.ts_0C1C33_17sp,
                  ),
                ),
              );
            }),
            _buildPicker(),
            Obx(() {
              if (controller.units[controller.selectedUnit.value] == UnitType.week) return _buildSelectWeekdays();
              return Container();
            })
          ],
        ),
      ),
    );
  }

  Widget _buildPicker() {
    Logger.print('buildPicker: ${controller.selectedValue.value} ${controller.selectedUnit.value}');

    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Styles.c_E8EAEF, width: 1),
        ),
      ),
      child: Obx(
        () => Row(
          children: [
            Flexible(
              child: CupertinoPicker.builder(
                scrollController: controller.valueScrollerViewController,
                itemExtent: 38.h,
                onSelectedItemChanged: (index) {
                  print('index: $index');
                  controller.selectedValue.value = index;
                },
                itemBuilder: (context, index) {
                  return Container(alignment: Alignment.center, child: Text('${controller.values[controller.selectedUnit.value][index]}'));
                },
                childCount: controller.values[controller.selectedUnit.value].length,
                selectionOverlay: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(color: Styles.c_E8EAEF, width: 1),
                      top: BorderSide(color: Styles.c_E8EAEF, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: CupertinoPicker.builder(
                scrollController: controller.unitScrollerViewController,
                itemExtent: 38.h,
                onSelectedItemChanged: (index) {
                  print('index: $index');
                  controller.selectedUnit.value = index;
                },
                itemBuilder: (context, index) {
                  return Container(alignment: Alignment.center, child: Text(controller.units[index].title));
                },
                childCount: controller.units.length,
                selectionOverlay: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(color: Styles.c_E8EAEF, width: 1),
                      top: BorderSide(color: Styles.c_E8EAEF, width: 1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectWeekdays() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 10),
      child: Obx(
        () => Column(
          children: [
            ...controller.weekdayValues.map((element) => _buildItemView(element)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemView(CustomRepeatModelItem item) {
    return Container(
      color: Colors.white,
      height: 58.h,
      child: ListTile(
        title: Text(
          item.title,
          style: Styles.ts_0C1C33_17sp,
        ),
        splashColor: Colors.transparent,
        trailing: Icon(Icons.check,
            color: controller.selectedWeekdays.firstWhereOrNull((e) => e.title == item.title) != null ? Colors.blue : Colors.transparent),
        onTap: () {
          if (controller.nowWeekday.title == item.title) {
            IMViews.showToast(StrRes.currentScheduleDeselectedHint);
            return;
          }
          if (controller.selectedWeekdays.firstWhereOrNull((e) => e.title == item.title) != null) {
            controller.selectedWeekdays.value.removeWhere((element) => element.title == item.title);
          } else {
            controller.selectedWeekdays.value.add(item);
          }

          controller.selectedWeekdays.refresh();
        },
      ),
    );
  }
}
