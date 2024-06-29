import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/define.dart';
import 'package:openmeeting/routes/m_navigator.dart';

import 'repeat_model_controller.dart';

class RepeatModelPage extends GetView<RepeatModelController> {
  const RepeatModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              ...controller.modelList.map((element) => _buildItemView(element)),
              const SizedBox(
                height: 10,
              ),
              _buildCustomItemView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemView(ModelItem item) {
    return Container(
      color: Colors.white,
      height: 58.h,
      child: ListTile(
        title: Text(
          item.type.title,
          style: Styles.ts_0C1C33_17sp,
        ),
        splashColor: Colors.transparent,
        trailing: Icon(Icons.check, color: item.type == controller.type ? Colors.blue : Colors.transparent),
        onTap: () {
          Get.back(result: item.type.rawValue);
        },
      ),
    );
  }

  Widget _buildCustomItemView() {
    return Container(
      color: Colors.white,
      height: 58.h,
      child: ListTile(
        title: Text(
          StrRes.custom,
          style: Styles.ts_0C1C33_17sp,
        ),
        splashColor: Colors.transparent,
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey.shade500,
        ),
        onTap: () async {
          MNavigator.startCustomRepeat(config: controller.config);
        },
      ),
    );
  }
}
