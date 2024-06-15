import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'selected_timezone_controller.dart';

class SelectedTimezonePage extends GetView<SelectedTimezoneController> {
  const SelectedTimezonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SelectedTimezonePage'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: _buildTimeZoneList(),
      ),
    );
  }

  Widget _buildTimeZoneList() {
    return Column(
      children: [
        CupertinoSearchTextField(
          controller: controller.searchController,
        ),
        Obx(
          () => Flexible(
            child: Scrollbar(
              child: ListView.builder(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemBuilder: (_, index) {
                  final timezone = controller.timeZones[index];

                  return ListTile(
                    title: Text(timezone),
                    onTap: () {
                      Get.back(result: controller.allTimezones[index]);
                    },
                  );
                },
                itemCount: controller.timeZones.length,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
