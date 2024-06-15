import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
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
            MNavigator.startBookMeeting(offAndToNamed: true, result: {'text': '1'});
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
                      '${controller.values[controller.selectedUnit.value][controller.selectedValue.value]}${controller.units[controller.selectedUnit.value]}'
                    ]),
                    style: Styles.ts_0C1C33_17sp,
                  ),
                ),
              );
            }),
            _buildPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildPicker() {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Styles.c_E8EAEF, width: 1),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: CupertinoPicker.builder(
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
              itemExtent: 38.h,
              onSelectedItemChanged: (index) {
                print('index: $index');
                controller.selectedUnit.value = index;
              },
              itemBuilder: (context, index) {
                return Container(alignment: Alignment.center, child: Text(controller.units[index]));
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
    );
  }
}
