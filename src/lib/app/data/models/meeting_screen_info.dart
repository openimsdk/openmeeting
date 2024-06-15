import 'package:openmeeting/app/data/models/meeting.pb.dart';

import 'define.dart';
import 'meeting_option.dart';

class MeetingScreenInfo {
  final WindowType type;
  final UserInfo userInfo;
  final LiveKit? certificate;
  final String? roomID;
  final MeetingOptions? options;
  final int windowId;

  MeetingScreenInfo({required this.type, required this.userInfo, this.certificate, this.roomID, this.options, this.windowId = -1});

  factory MeetingScreenInfo.fromMap(Map<String, dynamic> json) => MeetingScreenInfo(
        type: (json['type'] as int).windowType,
        userInfo: UserInfo()..mergeFromProto3Json(json['userInfo']),
        certificate: json['certificate'] == null ? null : LiveKit()
          ?..mergeFromProto3Json(json['certificate']),
        roomID: json['roomID'],
        options: json['option'] == null ? null : MeetingOptions.fromMap(json['option']),
        windowId: json['windowId'] ?? -1,
      );

  Map<String, dynamic> toMap() => {
        'type': type.rawValue,
        'userInfo': userInfo.toProto3Json(),
        'certificate': certificate?.toProto3Json(),
        'roomID': roomID,
        'option': options?.toMap(),
        'windowId': windowId
      };
}
