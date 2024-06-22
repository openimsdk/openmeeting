import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openmeeting/routes/m_navigator.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../data/models/define.dart';
import 'booking_config_controller.dart';
import 'desktop_view.dart';

class BookingConfigPage extends GetView<BookingConfigController> {
  const BookingConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TouchCloseSoftKeyboard(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: CupertinoNavigationBar(),
        body: Column(
          children: [
            Flexible(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                child: PlatformExt.isMobile ? _buildMobileView() : _buildDesktopView(),
              ),
            ),
            _verSpace,
            LayoutBuilder(
              builder: (_, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 52.h, maxHeight: 52.h, minWidth: constraints.maxWidth - 32),
                  child: CupertinoButton.filled(
                    onPressed: controller.enterMeeting,
                    padding: EdgeInsets.zero,
                    child: Text(controller.isModify ? StrRes.save : StrRes.bookAMeeting),
                  ),
                );
              },
            ),
            _verSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return Obx(
      () => Column(
        children: [
          _buildMobileInputItemView(controller.inputNameController, onSubmitted: _inputMeetingName),
          _verSpace,
          _buildMobileItemView(
              label: StrRes.meetingStartTime,
              value: DateUtil.formatDate(DateTime.fromMillisecondsSinceEpoch(controller.bookingConfig.value.beginTime),
                  format: controller.format),
              onTap: _selectMeetingBeginTime),
          _buildMobileItemView(
              label: StrRes.meetingDuration,
              value: '${(controller.bookingConfig.value.duration / 3600).toStringAsFixed(1)} ${StrRes.hours}',
              showRightArrow: true,
              onTap: _selectMeetingDuration),
          // _buildMobileItemView(label: StrRes.timeZone, showRightArrow: true, onTap: _selectTimezone),
          _buildMobileItemView(
              label: StrRes.repeatFrequency,
              value: controller.bookingConfig.value.repeatType.title,
              showRightArrow: true,
              onTap: _selectRepeatFrequency),
          controller.bookingConfig.value.repeatType != RepeatType.none
              ? _buildMobileItemView(
                  label: StrRes.endsIn, value: _endsInDaysText, showRightArrow: true, onTap: _selectRepeatEnds)
              : Container(),
          _verSpace,
          _buildMobileItemView(
              label: StrRes.enterMeetingPassword,
              switchOn: controller.bookingConfig.value.enableMeetingPassword,
              onChanged: _enablePassword),
          if (controller.bookingConfig.value.enableMeetingPassword)
            _buildMobileInputItemView(controller.pswEditingController,
                focusNode: controller.inputPswFocusNode, onSubmitted: _inputPassword),
          /*_buildMobileItemView(
              label: StrRes.allowMembersEnterFirst,
              switchOn: controller.bookingConfig.value.enableEnterBeforeHost,
              onChanged: _enableEnterBeforeHost),
           */
          _verSpace,
          _buildMobileItemView(
              label: StrRes.enterMeetingEnableMicrophone,
              switchOn: controller.bookingConfig.value.enableMicrophone,
              onChanged: _enableMicrophone),
          _buildMobileItemView(
              label: StrRes.enterMeetingEnableVideo,
              switchOn: controller.bookingConfig.value.enableCamera,
              onChanged: _enableCamera),
        ],
      ),
    );
  }

  Widget _buildMobileInputItemView(TextEditingController textEditingController,
      {required ValueChanged<String> onSubmitted, FocusNode? focusNode}) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      height: 58.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: CupertinoTextField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: null,
        clearButtonMode: OverlayVisibilityMode.editing,
        onChanged: onSubmitted,
      ),
    );
  }

  Widget _buildMobileItemView({
    required String label,
    TextStyle? textStyle,
    String? value,
    bool switchOn = false,
    bool showRightArrow = false,
    ValueChanged<bool>? onChanged,
    Function()? onTap,
  }) =>
      Ink(
        decoration: BoxDecoration(
          color: Styles.c_FFFFFF,
        ),
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            onTap?.call();
          },
          child: Container(
            height: 46.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                label.toText..style = textStyle ?? Styles.ts_0C1C33_17sp,
                const Spacer(),
                if (null != value) value.toText..style = Styles.ts_8E9AB0_17sp,
                if (onChanged != null)
                  CupertinoSwitch(
                    value: switchOn,
                    activeColor: Styles.c_0089FF,
                    onChanged: onChanged,
                  ),
                if (showRightArrow)
                  ImageRes.rightArrow.toImage
                    ..width = 24.w
                    ..height = 24.h,
              ],
            ),
          ),
        ),
      );

  void _inputMeetingName(String value) {
    controller.bookingConfig.update((val) {
      val?.name = value;
    });
  }

  void _selectMeetingBeginTime() {
    DatePicker.showDateTimePicker(
      Get.context!,
      locale: controller.isZh ? LocaleType.zh : LocaleType.en,
      minTime: DateTime.now(),
      theme: DatePickerTheme(
        cancelStyle: Styles.ts_0C1C33_17sp,
        doneStyle: Styles.ts_0089FF_17sp,
        itemStyle: Styles.ts_0C1C33_17sp,
      ),
      onConfirm: (dateTime) {
        final time = dateTime.millisecondsSinceEpoch;
        controller.bookingConfig.update((val) {
          val?.beginTime = time;
        });
      },
    );
  }

  void _selectMeetingDuration() {
    final durationList = [0.5, 1, 1.5, 2];

    Get.bottomSheet(
      BottomSheetView(
        items: durationList
            .map((e) => SheetItem(
                  label: '$e ${StrRes.hours}',
                  onTap: () {
                    controller.bookingConfig.update((val) {
                      val?.duration = (e * 60 * 60).toInt();
                    });
                  },
                ))
            .toList(),
      ),
      isScrollControlled: true,
    );
  }

  void _selectTimezone() async {
    final result = await MNavigator.startSelectedTimezone();
  }

  void _selectRepeatFrequency() async {
    final result =
        await MNavigator.startRepeatModel(type: controller.bookingConfig.value.repeatType.rawValue) as String?;
    // final result = Get.parameters['text'];
    controller.bookingConfig.update((val) {
      val?.repeatType = result == null ? RepeatType.none : RepeatTypeExt.fromString(result);
    });
  }

  void _selectRepeatEnds() async {
    final config = _configRepeatEnds();
    final result = await MNavigator.startRepeatEnds(endsInDays: config.endsInDays, maxLimit: config.maxLimit);
    if (result == null) {
      return;
    }
    final limitCount = result['limitCount'];
    final endsIn = result['endsIn'];
    controller.bookingConfig.update((val) {
      val?.limitCount = limitCount;
      val?.endsIn = endsIn;
    });
  }

  void _enablePassword(bool value) {
    controller.bookingConfig.update((val) {
      val?.enableMeetingPassword = value;
    });
    controller.inputPswFocusNode.requestFocus();
  }

  void _inputPassword(String value) {
    controller.bookingConfig.update((val) {
      val?.meetingPassword = value;
    });
  }

  void _enableEnterBeforeHost(bool value) {
    controller.bookingConfig.update((val) {
      val?.enableEnterBeforeHost = value;
    });
  }

  void _enableMicrophone(bool value) {
    controller.bookingConfig.update((val) {
      val?.enableMicrophone = value;
    });
  }

  void _enableCamera(bool value) {
    controller.bookingConfig.update((val) {
      val?.enableCamera = value;
    });
  }

  Widget _buildDesktopView() {
    return DesktopView(
      bookingConfig: controller.bookingConfig.value,
      onSubmitted: (value) {},
    );
  }

  Widget get _verSpace => const SizedBox(height: 10);

  String get _endsInDaysText {
    final config = _configRepeatEnds();

    final date =
        DateUtil.formatDate(DateTime.fromMillisecondsSinceEpoch(config.endsInDays), format: controller.endsInFormat);
    final limitCount = config.maxLimit;

    return sprintf(StrRes.endsInHit, [date, limitCount]);
  }

  ({int endsInDays, int maxLimit}) _configRepeatEnds() {
    final bookingConfig = controller.bookingConfig.value;
    final type = bookingConfig.repeatType;

    var endsInDays = bookingConfig.endsIn;
    final maxLimit = bookingConfig.limitCount != 0 ? bookingConfig.limitCount : 7;

    if (type == RepeatType.daily) {
      endsInDays = bookingConfig.endsIn != 0
          ? bookingConfig.endsIn
          : DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime).add(maxLimit.days).millisecondsSinceEpoch;
    } else if (type == RepeatType.weekday) {
      var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

      int workdaysAdded = 0;

      while (workdaysAdded < maxLimit) {
        if (originalTime.weekday == DateTime.friday) {
          originalTime = originalTime.add(3.days);
        } else {
          originalTime = originalTime.add(1.days);
        }

        if (originalTime.weekday != DateTime.saturday && originalTime.weekday != DateTime.sunday) {
          workdaysAdded++;
        }
      }

      endsInDays = originalTime.millisecondsSinceEpoch;
    } else if (type == RepeatType.weekly) {
      var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

      for (int i = 0; i < maxLimit; i++) {
        originalTime = originalTime.add(7.days);
      }

      endsInDays = originalTime.millisecondsSinceEpoch;
    } else if (type == RepeatType.biweekly) {
      var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

      for (int i = 0; i < maxLimit; i++) {
        originalTime = originalTime.add(14.days);
      }

      endsInDays = originalTime.millisecondsSinceEpoch;
    } else if (type == RepeatType.monthly) {
      var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

      for (int i = 0; i < maxLimit; i++) {
        int nextMonth = originalTime.month + 1;
        int nextYear = originalTime.year;
        if (nextMonth > 12) {
          nextMonth = 1;
          nextYear++;
        }
        originalTime = DateTime(nextYear, nextMonth, originalTime.day);
      }

      endsInDays = originalTime.millisecondsSinceEpoch;
    }

    return (endsInDays: endsInDays, maxLimit: maxLimit);
  }
}
