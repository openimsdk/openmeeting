import 'package:fixnum/fixnum.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/define.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../../core/app_controller.dart';
import '../../../../data/models/booking_config.dart';
import '../../../../data/models/meeting.pb.dart';
import '../../../../data/services/repository/repository_adapter.dart';

class BookingConfigController extends GetxController {
  final bookingConfig = BookingConfig(name: '', beginTime: DateTime.now().millisecondsSinceEpoch, duration: 3600).obs;
  bool isZh = false;
  String format = '';
  String endsInFormat = '';
  TextEditingController inputNameController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final userInfo = Get.find<AppController>().userInfo!;
  TextEditingController pswEditingController = TextEditingController();
  TextEditingController inputPswController = TextEditingController();
  FocusNode inputPswFocusNode = FocusNode();

  final IMeetingRepository repository;
  BookingConfigController({required this.repository});

  MeetingInfoSetting? meetingInfo;

  bool get isModify => meetingInfo != null;

  @override
  void onInit() {
    super.onInit();

    isZh = Get.locale!.languageCode.toLowerCase().contains("zh");
    format = isZh ? "MM月dd日 HH:mm" : "MM/dd HH:mm";
    endsInFormat = isZh ? "yyyy年MM月dd日" : "MM/dd, yyyy";
    final defaultMeetingName = sprintf(StrRes.meetingInitiatorIs, [userInfo.nickname]);
    inputNameController.text = defaultMeetingName;
    bookingConfig.value.name = defaultMeetingName;

    meetingInfo = Get.arguments['meetingInfo'] as MeetingInfoSetting?;

    if (meetingInfo != null) {
      inputNameController.text = meetingInfo!.meetingName;
      bookingConfig.value.name = meetingInfo!.meetingName;
      bookingConfig.value.beginTime = meetingInfo!.scheduledTime;
      bookingConfig.value.duration = meetingInfo!.duration ~/ 1000;
      bookingConfig.value.meetingPassword = meetingInfo!.password;
      bookingConfig.value.enableMeetingPassword = meetingInfo!.password?.isNotEmpty == true;
      pswEditingController.text = meetingInfo!.password ?? '';
      bookingConfig.value.enableCamera = meetingInfo!.setting.disableCameraOnJoin;
      bookingConfig.value.enableMicrophone = meetingInfo!.setting.disableMicrophoneOnJoin;
      bookingConfig.value.interval = meetingInfo!.repeatInfo.interval;
      bookingConfig.value.unit = UnitTypeExt.fromString(meetingInfo!.repeatInfo.uintType);
      bookingConfig.value.repeatType = meetingInfo!.repeatType;
      bookingConfig.value.repeatTimes = meetingInfo!.repeatInfo.repeatTimes;
      bookingConfig.value.endsIn = meetingInfo!.repeatInfo.endDate.toInt();
      bookingConfig.value.repeatDaysOfWeek = meetingInfo!.repeatInfo.repeatDaysOfWeek.map((e) => e.value).toList();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  void enterMeeting() async {
    if (bookingConfig.value.enableMeetingPassword) {
      if (bookingConfig.value.meetingPassword?.isEmpty == true) {
        IMViews.showToast(StrRes.plsEnterPassword);
        return;
      }
    }

    if (isModify) {
      final repeatDaysOfWeek = bookingConfig.value.repeatDaysOfWeek?.map((e) {
        Logger.print('repeat days of week index: $e');
        return DayOfWeek.valueOf(e - 1)!;
      }).toList();
      final request = UpdateMeetingRequest(
        meetingID: meetingInfo!.meetingID,
        updatingUserID: userInfo.userId,
        title: bookingConfig.value.name,
        scheduledTime:
            Int64(bookingConfig.value.beginTime.toString().length > 10 ? bookingConfig.value.beginTime ~/ 1000 : bookingConfig.value.beginTime),
        meetingDuration: Int64(bookingConfig.value.duration),
        password: bookingConfig.value.meetingPassword,
        disableCameraOnJoin: !bookingConfig.value.enableCamera,
        disableMicrophoneOnJoin: !bookingConfig.value.enableMicrophone,
        repeatInfo: MeetingRepeatInfo(
          endDate: Int64(bookingConfig.value.endsIn),
          repeatType: bookingConfig.value.repeatType.rawValue,
          repeatTimes: bookingConfig.value.repeatTimes,
          interval: bookingConfig.value.interval,
          uintType: bookingConfig.value.unit.rawValue,
          repeatDaysOfWeek: repeatDaysOfWeek,
        ),
      );
      await repository.updateMeetingSetting(request);
    } else {
      await repository.createMeeting(
        type: CreateMeetingType.booking,
        creatorUserID: userInfo.userId,
        creatorDefinedMeetingInfo: CreatorDefinedMeetingInfo(
            title: bookingConfig.value.name,
            scheduledTime: Int64(bookingConfig.value.beginTime),
            meetingDuration: Int64(bookingConfig.value.duration),
            password: bookingConfig.value.meetingPassword),
        setting:
            MeetingSetting(disableCameraOnJoin: !bookingConfig.value.enableCamera, disableMicrophoneOnJoin: !bookingConfig.value.enableMicrophone),
        repeatInfo: MeetingRepeatInfo(
          endDate: Int64(bookingConfig.value.endsIn),
          repeatType: bookingConfig.value.repeatType.rawValue,
          repeatTimes: bookingConfig.value.repeatTimes,
          interval: bookingConfig.value.interval,
          uintType: bookingConfig.value.unit.rawValue,
          repeatDaysOfWeek: bookingConfig.value.repeatDaysOfWeek?.map((e) => DayOfWeek.valueOf(e - 1)!),
        ),
      );
    }
    Get.back();
  }
}
