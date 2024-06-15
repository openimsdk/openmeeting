import 'package:easy_sticky_header/easy_sticky_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:sprintf/sprintf.dart';

import 'history_controller.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(StrRes.meetingHistory),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: CupertinoSearchTextField(
              controller: controller.searchController,
            ),
          ),
          Flexible(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Obx(
      () => StickyHeader(
        child: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: EdgeInsets.zero,
          itemCount: controller.meetingInfoList.length,
          itemBuilder: (context, index) {
            final model = controller.meetingInfoList[index];

            if (model.isHeader) {
              return _buildHeader(index);
            }
            return _buildMeetingInfoItemView(index);
          },
        ),
      ),
    );
  }

  Widget _buildHeader(int index) {
    final model = controller.meetingInfoList[index];
    return StickyContainerBuilder(
      index: index,
      builder: (context, stickyAmount) => Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 40.h,
        child: Text(
          model.dateStr ?? '',
          style: Styles.ts_0C1C33_17sp,
        ),
      ),
    );
  }

  Widget _buildMeetingInfoItemView(int index) {
    final meetingInfo = controller.meetingInfoList[index].meetingInfo!;

    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.h),
        margin: EdgeInsets.only(bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                meetingInfo.meetingName.toText
                  ..style = Styles.ts_0C1C33_17sp_medium
                  ..maxLines = 1
                  ..overflow = TextOverflow.ellipsis,
                4.verticalSpace,
                controller.getMeetingDuration(meetingInfo).toText
                  ..style = Styles.ts_8E9AB0_13sp
                  ..maxLines = 1
                  ..overflow = TextOverflow.ellipsis,
                4.verticalSpace,
                if (meetingInfo.creatorNickname.isNotEmpty)
                  sprintf(StrRes.meetingOrganizerIs, [meetingInfo.creatorNickname]).toText
                    ..style = Styles.ts_8E9AB0_13sp
                    ..maxLines = 1
                    ..overflow = TextOverflow.ellipsis,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
