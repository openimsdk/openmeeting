import '../../models/meeting.pb.dart';

enum CreateMeetingType {
  quick,
  booking,
  join,
}

abstract class IMeetingRepository {
  Future<List<MeetingInfoSetting>> getUnfinished(String userID) {
    throw UnimplementedError();
  }

  Future<LiveKit> getLiveKitToken(String meetingID, String userID) async {
    throw UnimplementedError();
  }

  Future<MeetingInfoSetting?> getMeetingInfo(String meetingId, String userID) {
    throw UnimplementedError();
  }

  Future<({LiveKit cert, MeetingInfoSetting info})> createMeeting(
      {required CreateMeetingType type,
      required String creatorUserID,
      required CreatorDefinedMeetingInfo creatorDefinedMeetingInfo,
      required MeetingSetting setting}) {
    throw UnimplementedError();
  }

  Future<LiveKit?> joinMeeting(String meetingID, String userID, {String? password}) {
    throw UnimplementedError();
  }

  Future<List<MeetingInfoSetting>> getHistory(String userID) {
    throw UnimplementedError();
  }

  Future<List<MeetingInfoSetting>> searchHistory(String keywords) {
    throw UnimplementedError();
  }

  Future<bool> leaveMeeting(String meetingID, String userID) {
    throw UnimplementedError();
  }

  Future<bool> endMeeting(String meetingID, String userID) {
    throw UnimplementedError();
  }

  Future<bool> setPersonalSetting(String meetingID, String userID, PersonalMeetingSetting setting) {
    throw UnimplementedError();
  }

  Future<bool> updateMeetingSetting(UpdateMeetingRequest request) {
    throw UnimplementedError();
  }

  Future<bool> operateAllStream(
    String meetingID,
    String operatorUserID, {
    bool? cameraOnEntry,
    bool? microphoneOnEntry,
  }) {
    throw UnimplementedError();
  }
}
