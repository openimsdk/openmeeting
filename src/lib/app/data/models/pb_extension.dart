import 'package:openmeeting/app/data/models/define.dart';

import 'meeting.pb.dart';
import 'user_info.dart' as ui;

extension MeetingInfoSettingExt on MeetingInfoSetting {
  String get creatorUserID => info.systemGenerated.creatorUserID;
  String get creatorNickname => info.systemGenerated.creatorNickname;
  String get meetingID => info.systemGenerated.meetingID;
  String get meetingName => info.creatorDefinedMeeting.title;
  int get scheduledTime => info.creatorDefinedMeeting.scheduledTime.toInt() * 1000;
  int get duration => info.creatorDefinedMeeting.meetingDuration.toInt() * 1000;
  int get endTime => scheduledTime + duration * 1000;
  String? get password => info.creatorDefinedMeeting.password;
  bool get shouldCheckPassword => password?.isNotEmpty == true;
  MeetingStatus get status => MeetingStatusExt.fromString(info.systemGenerated.status);
  String get hostUserID =>
      info.creatorDefinedMeeting.hostUserID.isNotEmpty ? info.creatorDefinedMeeting.hostUserID : creatorUserID;
  List<String> get coHostUSerID => info.creatorDefinedMeeting.coHostUSerID;
  RepeatType get repeatType => RepeatTypeExt.fromString(repeatInfo.repeatType);
}

extension UserInfoExt on ui.UserInfo {
  UserInfo toPBUser() {
    return UserInfo(userID: userId, nickname: nickname);
  }
}
