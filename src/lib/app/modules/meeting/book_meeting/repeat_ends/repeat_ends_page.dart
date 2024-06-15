import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/routes/m_navigator.dart';
import 'package:sprintf/sprintf.dart';

import 'repeat_ends_controller.dart';

class RepeatEndsPage extends GetView<RepeatEndsController> {
  const RepeatEndsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(StrRes.confirm),
            onPressed: () {
              controller.limitCount.value = controller.inputController.text.isEmpty ? 0 : int.parse(controller.inputController.text);
              Get.back(result: {'endsIn': controller.endsIn.value, 'limitCount': controller.limitCount.value});
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 10),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Text(
                    '结束于某天',
                    style: Styles.ts_0C1C33_17sp,
                  ),
                  title: Text(
                    '(${DateUtil.formatDateMs(controller.endsIn.value, format: 'yyyy-MM-dd')})',
                  ),
                  trailing: controller.checkedIndex.value == 0 ? Icon(Icons.check) : null,
                  onTap: () {
                    controller.checkedIndex.value = 0;
                    DatePicker.showDatePicker(context,
                        showTitleActions: true, minTime: DateTime.now(), maxTime: DateTime.now().add(Duration(days: 365)), onConfirm: (date) {
                      controller.endsIn.value = date.millisecondsSinceEpoch;
                    }, currentTime: DateTime.fromMillisecondsSinceEpoch(controller.endsIn.value), locale: LocaleType.zh);
                  },
                ),
                ListTile(
                  leading: Text(
                    '限定会议次数',
                    style: Styles.ts_0C1C33_17sp,
                  ),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 40,
                        child: CupertinoTextField(
                          controller: controller.inputController,
                          focusNode: controller.focusNode,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        sprintf(StrRes.times, ['']),
                        style: Styles.ts_0C1C33_17sp,
                      )
                    ],
                  ),
                  trailing: controller.checkedIndex.value == 1 ? Icon(Icons.check) : null,
                  onTap: () {
                    controller.focusNode.requestFocus();
                    controller.checkedIndex.value = 1;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
