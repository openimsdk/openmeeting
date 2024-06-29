import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:openmeeting/app/data/models/booking_config.dart';

import '../app/data/models/meeting.pb.dart';
import 'm_pages.dart';

class MNavigator {
  static Future<T?>? startMeeting<T>() => Get.toNamed(MRoutes.meeting);

  static Future<T?>? startJoinMeeting<T>() => Get.toNamed(MRoutes.joinMeeting);

  static startBookMeeting({
    MeetingInfoSetting? meetingInfo,
    bool offAndToNamed = false,
    Map<String, String?>? result,
  }) {
    final args = {'meetingInfo': meetingInfo};

    return offAndToNamed
        ? Get.offAndToNamed(
            MRoutes.bookingMeeting,
            arguments: args,
          )
        : Get.toNamed(
            MRoutes.bookingMeeting,
            arguments: args,
          );
  }

  static popToBookMeeting({Map<String, String?>? result}) {
    Get.until((route) => route.settings.name == MRoutes.bookingMeeting);
  }

  static startMeetingDetail(
    MeetingInfoSetting meetingInfo,
    String meetingCreator, {
    bool offAndToNamed = false,
  }) {
    final args = {'meetingInfo': meetingInfo, 'meetingCreator': meetingCreator};
    return offAndToNamed
        ? Get.offAndToNamed(MRoutes.meetingDetail, arguments: args)
        : Get.toNamed(MRoutes.meetingDetail, arguments: args);
  }

  static startEnableCamera() => Get.toNamed(MRoutes.enableCamera);
  static startSelectedTimezone() => Get.toNamed(MRoutes.selectedTimezone);
  static startRepeatModel({BookingConfig? config}) => Get.toNamed(
        MRoutes.repeatModel,
        arguments: config != null ? {'config': config} : null,
      );
  static startCustomRepeat({BookingConfig? config}) => Get.toNamed(
        MRoutes.customRepeat,
        arguments: config != null ? {'config': config} : null,
      );
  static startRepeatEnds({int? endsInDays, int? maxLimit}) => Get.toNamed(MRoutes.repeatEnds, parameters: {
        if (endsInDays != null) 'endsInDays': endsInDays.toString(),
        if (maxLimit != null) 'maxLimit': maxLimit.toString()
      });
  static startHistory() => Get.toNamed(MRoutes.history);
}
