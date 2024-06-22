import 'package:get/get.dart';

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

    return offAndToNamed ? Get.offAndToNamed(MRoutes.bookingMeeting, arguments: args) : Get.toNamed(MRoutes.bookingMeeting, arguments: args);
  }

  static startMeetingDetail(
    MeetingInfoSetting meetingInfo,
    String meetingCreator, {
    bool offAndToNamed = false,
  }) {
    final args = {'meetingInfo': meetingInfo, 'meetingCreator': meetingCreator};
    return offAndToNamed ? Get.offAndToNamed(MRoutes.meetingDetail, arguments: args) : Get.toNamed(MRoutes.meetingDetail, arguments: args);
  }

  static startEnableCamera() => Get.toNamed(MRoutes.enableCamera);
  static startSelectedTimezone() => Get.toNamed(MRoutes.selectedTimezone);
  static startRepeatModel({String? type}) => Get.toNamed(MRoutes.repeatModel, parameters: {if (type != null) 'type': type.toString()});
  static startCustomRepeat() => Get.toNamed(MRoutes.repeatModel + MRoutes.customRepeat);
  static startRepeatEnds({int? endsInDays, int? maxLimit}) => Get.toNamed(MRoutes.repeatEnds,
      parameters: {if (endsInDays != null) 'endsInDays': endsInDays.toString(), if (maxLimit != null) 'maxLimit': maxLimit.toString()});
  static startHistory() => Get.toNamed(MRoutes.history);
}
