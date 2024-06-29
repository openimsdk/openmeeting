import 'package:openmeeting/app/data/models/pb_extension.dart';

import '../../models/define.dart';
import '../../models/meeting.pb.dart';
import '../../apis.dart';
import 'repository_adapter.dart';

class MeetingRepository implements IMeetingRepository {
  @override
  Future<List<MeetingInfoSetting>> getUnfinished(String userID) async {
    final params = {
      'userID': userID,
      'status': [MeetingStatus.scheduled.rawValue, MeetingStatus.inProgress.rawValue]
    };
    final result = await Apis.getMeetings(params);

    return List<MeetingInfoSetting>.from(
        result['meetingDetails']?.map((e) => MeetingInfoSetting()..mergeFromProto3Json(e)).toList() ?? []);
  }

  @override
  Future<LiveKit> getLiveKitToken(String meetingID, String userID) async {
    final result = await Apis.getLiveKitToken(meetingID, userID);

    return LiveKit()..mergeFromProto3Json(result['liveKit']);
  }

  @override
  Future<MeetingInfoSetting> getMeetingInfo(String meetingId, String userID) async {
    final result = await Apis.getMeeting({'userID': userID, 'meetingID': meetingId});

    return MeetingInfoSetting()..mergeFromProto3Json(result['meetingDetail']);
  }

  @override
  Future<({LiveKit cert, MeetingInfoSetting info})> createMeeting(
      {required CreateMeetingType type,
      required String creatorUserID,
      required CreatorDefinedMeetingInfo creatorDefinedMeetingInfo,
      required MeetingSetting setting,
      MeetingRepeatInfo? repeatInfo}) async {
    final params = {
      'creatorUserID': creatorUserID,
      'creatorDefinedMeetingInfo': {
        'title': creatorDefinedMeetingInfo.title,
        'scheduledTime': creatorDefinedMeetingInfo.scheduledTime.toString().length > 10
            ? creatorDefinedMeetingInfo.scheduledTime.toInt() ~/ 1000
            : creatorDefinedMeetingInfo.scheduledTime.toInt(),
        'meetingDuration': creatorDefinedMeetingInfo.meetingDuration.toInt(),
        'password': creatorDefinedMeetingInfo.password,
      },
      'setting': setting.toProto3Json(),
      if (repeatInfo != null)
        'repeatInfo': {...repeatInfo.toProto3Json() as Map, 'endDate': repeatInfo.endDate.toInt()},
    };

    if (type == CreateMeetingType.quick) {
      final result = await Apis.quicklyMeeting(params);
      final setting = CreateImmediateMeetingResp()..mergeFromProto3Json(result);
      final cert = await getLiveKitToken(setting.detail.meetingID, setting.detail.creatorUserID);

      return (cert: cert, info: setting.detail);
    } else if (type == CreateMeetingType.booking) {
      final result = await Apis.bookingMeeting(params);
      final setting = BookMeetingResp()..mergeFromProto3Json(result);
      final cert = await getLiveKitToken(setting.detail.meetingID, setting.detail.creatorUserID);

      return (cert: cert, info: setting.detail);
    } else {
      final result = await Apis.joinMeeting(params);
      final cert = LiveKit()..mergeFromProto3Json(result);

      return (cert: cert, info: MeetingInfoSetting());
    }
  }

  @override
  Future<LiveKit?> joinMeeting(String meetingID, String userID, {String? password}) async {
    final result = await Apis.joinMeeting({'userID': userID, 'meetingID': meetingID, 'password': password});

    if (result != null) {
      final cert = await getLiveKitToken(meetingID, userID);

      return cert;
    }
    return null;
  }

  @override
  Future<List<MeetingInfoSetting>> getHistory(String userID) async {
    final params = {
      'userID': userID,
      'status': [MeetingStatus.completed.rawValue]
    };
    final result = await Apis.getMeetings(params);

    return List<MeetingInfoSetting>.from(
        result['meetingDetails']?.map((e) => MeetingInfoSetting()..mergeFromProto3Json(e)).toList() ?? []);
  }

  @override
  Future<List<MeetingInfoSetting>> searchHistory(String keywords) {
    throw UnimplementedError();
  }

  @override
  Future<bool> leaveMeeting(String meetingID, String userID) async {
    final params = {'meetingID': meetingID, 'userID': userID};
    try {
      await Apis.leaveMeeting(params);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> endMeeting(String meetingID, String userID) async {
    final params = {'meetingID': meetingID, 'userID': userID};

    try {
      await Apis.endMeeting(params);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setPersonalSetting(String meetingID, String userID, PersonalMeetingSetting setting) async {
    final params = {'meetingID': meetingID, 'userID': userID, 'setting': setting.toProto3Json()};

    try {
      await Apis.setPersonalSetting(params);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateMeetingSetting(UpdateMeetingRequest request) async {
    final params = request.toProto3Json() as Map<String, dynamic>;
    params['scheduledTime'] = request.scheduledTime.toInt();
    params['meetingDuration'] = request.meetingDuration.toInt();
    final repeat = request.repeatInfo.toProto3Json() as Map<String, dynamic>;
    repeat['endDate'] = request.repeatInfo.endDate.toInt();
    params['repeatInfo'] = repeat;

    try {
      await Apis.updateMeetingSetting(params);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> operateAllStream(
    String meetingID,
    String operatorUserID, {
    bool? cameraOnEntry,
    bool? microphoneOnEntry,
  }) async {
    final params = {
      'meetingID': meetingID,
      'operatorUserID': operatorUserID,
      if (cameraOnEntry != null) 'cameraOnEntry': cameraOnEntry,
      if (microphoneOnEntry != null) 'microphoneOnEntry': microphoneOnEntry,
    };

    try {
      await Apis.operateAllStream(params);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> modifyParticipantName(
      {required String meetingID,
      required String userID,
      required String participantUserID,
      required String nickname}) async {
    final params = {
      'meetingID': meetingID,
      'userID': userID,
      'participantUserID': participantUserID,
      'nickname': nickname,
    };

    try {
      await Apis.modifyParticipantName(params);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> kickParticipant(
      {required String meetingID, required String userID, required List<String> participantUserIDs}) async {
    final params = {
      'meetingID': meetingID,
      'userID': userID,
      'participantUserIDs': participantUserIDs,
    };

    try {
      await Apis.kickParticipant(params);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setMeetingHost(
      {required String meetingID,
      required String userID,
      required String hostUserID,
      required List<String> coHostUserIDs}) async {
    final params = {
      'meetingID': meetingID,
      'userID': userID,
      'hostUserID': hostUserID,
      'coHostUserIDs': coHostUserIDs,
    };

    try {
      await Apis.setMeetingHost(params);

      return true;
    } catch (e) {
      return false;
    }
  }
}
