import 'package:easy_sticky_header/easy_sticky_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:openmeeting/app/modules/meeting/meeting_room/meeting_client.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../core/data_sp.dart';
import '../../../../routes/app_navigator.dart';
import '../../../../routes/m_navigator.dart';
import '../../../widgets/meeting/desktop/meeting_alert_dialog.dart';
import '../../../widgets/meeting/desktop/meeting_pop_menu.dart';
import 'meeting_controller.dart';

class MeetingPage extends GetView<MeetingController> {
  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onVisibilityGained: controller.queryUnfinishedMeeting,
      child: Scaffold(
        backgroundColor: Styles.c_FFFFFF,
        body: PopScope(
          canPop: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ImageView(
                  name: ImageRes.meetingHomeHeaderBg,
                  width: 216.h,
                ),
              ),
              Column(
                children: [
                  TitleBar.conversation(
                      showPopButton: false,
                      backgroundColor: Colors.transparent,
                      left: Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            PopButton(
                              popCtrl: controller.customPopupMenuController,
                              menus: [
                                PopMenuInfo(
                                  text: StrRes.meetingSettings,
                                  iconWidget: const Icon(Icons.settings),
                                  onTap: () {
                                    AppNavigator.startMeetingSetup();
                                  },
                                ),
                                PopMenuInfo(
                                  text: StrRes.logout,
                                  iconWidget: const Icon(Icons.logout, color: Colors.red),
                                  onTap: () async {
                                    MeetingClient().close();
                                    await DataSp.removeLoginCertificate();
                                    AppNavigator.startBackLogin();
                                  },
                                ),
                              ],
                              child: AvatarView(
                                width: 42.w,
                                height: 42.h,
                                text: controller.userInfo.nickname,
                                url: controller.userInfo.faceURL,
                              ),
                            ),
                            10.horizontalSpace,
                            Flexible(
                              child: controller.userInfo.nickname.toText
                                ..style = Styles.ts_0C1C33_17sp
                                ..maxLines = 1
                                ..overflow = TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildButtonIcon(
                          text: StrRes.joinMeeting,
                          icon: ImageRes.meetingJoin,
                          onTap: controller.joinMeeting,
                        ),
                        _buildQuicklyEnterButton(),
                        _buildButtonIcon(
                          text: StrRes.bookAMeeting,
                          icon: ImageRes.meetingBook,
                          onTap: () {
                            MNavigator.startBookMeeting();
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    color: Styles.c_F8F9FA,
                  ),
                  Obx(
                    () => controller.meetingInfoList.isNotEmpty
                        ? Flexible(
                            child: StickyHeader(
                              child: CustomScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                slivers: [
                                  CupertinoSliverRefreshControl(
                                    onRefresh: controller.onRefresh,
                                  ),
                                  _buildList()
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Column(
                              children: [
                                124.verticalSpace,
                                ImageView(
                                  name: ImageRes.meetingListEmpty,
                                  width: 263.w,
                                ),
                                Text(
                                  StrRes.emptyMeeting,
                                  style: Styles.ts_8E9AB0_14sp,
                                )
                              ],
                            ),
                          ),
                  ),
                ],
              ),
              Positioned(
                top: PlatformExt.isMobile ? 229.h : 160,
                right: 16.w,
                child: SizedBox(
                  width: 78.w,
                  height: 25.h,
                  child: ElevatedButton(
                    onPressed: () {
                      MNavigator.startHistory();
                    },
                    child: Text(
                      StrRes.meetingHistory,
                      style: Styles.ts_0C1C33_12sp,
                    ),
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Styles.c_E8EAEF),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                        textStyle: WidgetStateProperty.all(Styles.ts_0C1C33_12sp),
                        foregroundColor: WidgetStateProperty.all(Styles.c_0C1C33),
                        padding: WidgetStateProperty.all(EdgeInsets.zero)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final model = controller.meetingInfoList[index];

          if (model.isHeader) {
            return _buildHeader(index);
          }
          return _buildMeetingInfoItemView(index);
        },
        childCount: controller.meetingInfoList.length,
      ),
    );
  }

  Widget _buildHeader(int index) {
    final model = controller.meetingInfoList[index];
    return StickyContainerBuilder(
      index: index,
      builder: (context, stickyAmount) => Container(
        color: Styles.c_FFFFFF,
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
      onTap: () => controller.meetingDetail(meetingInfo),
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
                Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200.w),
                      child: meetingInfo.meetingName.toText
                        ..style = Styles.ts_0C1C33_17sp_medium
                        ..maxLines = 1
                        ..overflow = TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8.w),
                      decoration: BoxDecoration(
                        color: controller.isStartedMeeting(meetingInfo)
                            ? Styles.c_0089FF.withOpacity(0.1)
                            : Colors.orangeAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 1.h,
                        horizontal: 5.w,
                      ),
                      child: controller.isStartedMeeting(meetingInfo)
                          ? (StrRes.started.toText..style = Styles.ts_0089FF_12sp)
                          : (StrRes.didNotStart.toText..style = TextStyle(fontSize: 12.sp, color: Colors.orange)),
                    ),
                  ],
                ),
                4.verticalSpace,
                controller.getMeetingDuration(meetingInfo).toText
                  ..style = Styles.ts_8E9AB0_13sp
                  ..maxLines = 1
                  ..overflow = TextOverflow.ellipsis,
                if (meetingInfo.creatorNickname.isNotEmpty)
                  sprintf(StrRes.meetingOrganizerIs, [meetingInfo.creatorNickname]).toText
                    ..style = Styles.ts_8E9AB0_13sp
                    ..maxLines = 1
                    ..overflow = TextOverflow.ellipsis,
              ],
            ),
            ElevatedButton(
              onPressed: () {
                showCheckPasswordDialog(meetingInfo);
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Styles.c_0089FF),
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all(
                    Size(64.w, 32.h),
                  ),
                  maximumSize: WidgetStateProperty.all(Size(64.w, 32.h)),
                  textStyle: WidgetStateProperty.all(Styles.ts_FFFFFF_17sp)),
              child: Text(
                StrRes.enter,
                style: Styles.ts_FFFFFF_17sp,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuicklyEnterButton() {
    return _buildButtonIcon(
      text: StrRes.quickMeeting,
      icon: ImageRes.meetingQuickStart,
      textTrailing: PlatformExt.isMobile
          ? null
          : Builder(
              builder: (ctx) => GestureDetector(
                onTap: () {
                  controller.showPopEnableCamera.value = !controller.showPopEnableCamera.value;
                  if (controller.showPopEnableCamera.value) {
                    MeetingPopMenu.showEnableCameraSetting(ctx, enableCamera: controller.isEnableVideo,
                        onOperation: (value) {
                      controller.isEnableVideo = value;
                    }, onPop: () {
                      controller.showPopEnableCamera.value = false;
                    });
                  }
                },
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: controller.showPopEnableCamera.value ? Styles.c_E8EAEF : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.expand_less,
                      size: 16.h,
                      color: controller.showPopEnableCamera.value ? Styles.c_8E9AB0 : Styles.c_0C1C33,
                    ),
                  ),
                ),
              ),
            ),
      onTap: controller.quickMeeting,
    );
  }

  Widget _buildButtonIcon({
    required String icon,
    required String text,
    Widget? textTrailing,
    Function()? onTap,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Column(
          children: [
            icon.toImage
              ..width = 50.w
              ..height = 50.h,
            6.verticalSpace,
            Row(
              children: [
                text.toText..style = Styles.ts_0C1C33_12sp,
                textTrailing ?? Container(),
              ],
            ),
          ],
        ),
      );

  void showCheckPasswordDialog(MeetingInfoSetting info) async {
    if (info.creatorUserID == controller.userInfo.userId) {
      controller.quickEnterMeeting(info.meetingID);

      return;
    }

    final basePassword = await controller.getMeetingPassword(info.meetingID, info.creatorUserID);

    if (basePassword?.isEmpty == true) {
      controller.quickEnterMeeting(info.meetingID);

      return;
    }

    MeetingAlertDialog.showEnterMeetingWithPasswordDialog(Get.context!, info.creatorNickname,
        onConfirm: (password) async {
      final result = basePassword == password;

      if (!result) {
        IMViews.showToast(StrRes.wrongMeetingPassword);
      } else {
        controller.quickEnterMeeting(info.meetingID);
      }
    });
  }
}
