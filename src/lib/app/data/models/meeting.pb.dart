//
//  Generated code. Do not modify.
//  source: meeting.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

/// Defines LiveKit access information.
class LiveKit extends $pb.GeneratedMessage {
  factory LiveKit({
    $core.String? token,
    $core.String? url,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    if (url != null) {
      $result.url = url;
    }
    return $result;
  }
  LiveKit._() : super();
  factory LiveKit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LiveKit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LiveKit', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LiveKit clone() => LiveKit()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LiveKit copyWith(void Function(LiveKit) updates) => super.copyWith((message) => updates(message as LiveKit)) as LiveKit;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LiveKit create() => LiveKit._();
  LiveKit createEmptyInstance() => create();
  static $pb.PbList<LiveKit> createRepeated() => $pb.PbList<LiveKit>();
  @$core.pragma('dart2js:noInline')
  static LiveKit getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LiveKit>(create);
  static LiveKit? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => clearField(2);
}

/// Information about a specific meeting that cannot be changed once set.
class SystemGeneratedMeetingInfo extends $pb.GeneratedMessage {
  factory SystemGeneratedMeetingInfo({
    $core.String? creatorUserID,
    $core.String? creatorNickname,
    $core.String? status,
    $fixnum.Int64? startTime,
    $core.String? meetingID,
  }) {
    final $result = create();
    if (creatorUserID != null) {
      $result.creatorUserID = creatorUserID;
    }
    if (creatorNickname != null) {
      $result.creatorNickname = creatorNickname;
    }
    if (status != null) {
      $result.status = status;
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    return $result;
  }
  SystemGeneratedMeetingInfo._() : super();
  factory SystemGeneratedMeetingInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SystemGeneratedMeetingInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SystemGeneratedMeetingInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'creatorUserID', protoName: 'creatorUserID')
    ..aOS(2, _omitFieldNames ? '' : 'creatorNickname', protoName: 'creatorNickname')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aInt64(4, _omitFieldNames ? '' : 'startTime', protoName: 'startTime')
    ..aOS(5, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SystemGeneratedMeetingInfo clone() => SystemGeneratedMeetingInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SystemGeneratedMeetingInfo copyWith(void Function(SystemGeneratedMeetingInfo) updates) => super.copyWith((message) => updates(message as SystemGeneratedMeetingInfo)) as SystemGeneratedMeetingInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemGeneratedMeetingInfo create() => SystemGeneratedMeetingInfo._();
  SystemGeneratedMeetingInfo createEmptyInstance() => create();
  static $pb.PbList<SystemGeneratedMeetingInfo> createRepeated() => $pb.PbList<SystemGeneratedMeetingInfo>();
  @$core.pragma('dart2js:noInline')
  static SystemGeneratedMeetingInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SystemGeneratedMeetingInfo>(create);
  static SystemGeneratedMeetingInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get creatorUserID => $_getSZ(0);
  @$pb.TagNumber(1)
  set creatorUserID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreatorUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreatorUserID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get creatorNickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set creatorNickname($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatorNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorNickname() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get startTime => $_getI64(3);
  @$pb.TagNumber(4)
  set startTime($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStartTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartTime() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get meetingID => $_getSZ(4);
  @$pb.TagNumber(5)
  set meetingID($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMeetingID() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeetingID() => clearField(5);
}

/// Information about a specific meeting that can be modified.
class CreatorDefinedMeetingInfo extends $pb.GeneratedMessage {
  factory CreatorDefinedMeetingInfo({
    $core.String? title,
    $fixnum.Int64? scheduledTime,
    $fixnum.Int64? meetingDuration,
    $core.String? password,
    $core.String? timeZone,
    $core.String? hostUserID,
    $core.Iterable<$core.String>? coHostUSerID,
  }) {
    final $result = create();
    if (title != null) {
      $result.title = title;
    }
    if (scheduledTime != null) {
      $result.scheduledTime = scheduledTime;
    }
    if (meetingDuration != null) {
      $result.meetingDuration = meetingDuration;
    }
    if (password != null) {
      $result.password = password;
    }
    if (timeZone != null) {
      $result.timeZone = timeZone;
    }
    if (hostUserID != null) {
      $result.hostUserID = hostUserID;
    }
    if (coHostUSerID != null) {
      $result.coHostUSerID.addAll(coHostUSerID);
    }
    return $result;
  }
  CreatorDefinedMeetingInfo._() : super();
  factory CreatorDefinedMeetingInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatorDefinedMeetingInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatorDefinedMeetingInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aInt64(2, _omitFieldNames ? '' : 'scheduledTime', protoName: 'scheduledTime')
    ..aInt64(3, _omitFieldNames ? '' : 'meetingDuration', protoName: 'meetingDuration')
    ..aOS(4, _omitFieldNames ? '' : 'password')
    ..aOS(5, _omitFieldNames ? '' : 'timeZone', protoName: 'timeZone')
    ..aOS(6, _omitFieldNames ? '' : 'hostUserID', protoName: 'hostUserID')
    ..pPS(7, _omitFieldNames ? '' : 'coHostUSerID', protoName: 'coHostUSerID')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatorDefinedMeetingInfo clone() => CreatorDefinedMeetingInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatorDefinedMeetingInfo copyWith(void Function(CreatorDefinedMeetingInfo) updates) => super.copyWith((message) => updates(message as CreatorDefinedMeetingInfo)) as CreatorDefinedMeetingInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatorDefinedMeetingInfo create() => CreatorDefinedMeetingInfo._();
  CreatorDefinedMeetingInfo createEmptyInstance() => create();
  static $pb.PbList<CreatorDefinedMeetingInfo> createRepeated() => $pb.PbList<CreatorDefinedMeetingInfo>();
  @$core.pragma('dart2js:noInline')
  static CreatorDefinedMeetingInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatorDefinedMeetingInfo>(create);
  static CreatorDefinedMeetingInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get scheduledTime => $_getI64(1);
  @$pb.TagNumber(2)
  set scheduledTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScheduledTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearScheduledTime() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get meetingDuration => $_getI64(2);
  @$pb.TagNumber(3)
  set meetingDuration($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMeetingDuration() => $_has(2);
  @$pb.TagNumber(3)
  void clearMeetingDuration() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get password => $_getSZ(3);
  @$pb.TagNumber(4)
  set password($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPassword() => $_has(3);
  @$pb.TagNumber(4)
  void clearPassword() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get timeZone => $_getSZ(4);
  @$pb.TagNumber(5)
  set timeZone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimeZone() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimeZone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get hostUserID => $_getSZ(5);
  @$pb.TagNumber(6)
  set hostUserID($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHostUserID() => $_has(5);
  @$pb.TagNumber(6)
  void clearHostUserID() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get coHostUSerID => $_getList(6);
}

/// Information about a specific meeting, combining system-generated and creator-defined information.
class MeetingInfo extends $pb.GeneratedMessage {
  factory MeetingInfo({
    SystemGeneratedMeetingInfo? systemGenerated,
    CreatorDefinedMeetingInfo? creatorDefinedMeeting,
  }) {
    final $result = create();
    if (systemGenerated != null) {
      $result.systemGenerated = systemGenerated;
    }
    if (creatorDefinedMeeting != null) {
      $result.creatorDefinedMeeting = creatorDefinedMeeting;
    }
    return $result;
  }
  MeetingInfo._() : super();
  factory MeetingInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeetingInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MeetingInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<SystemGeneratedMeetingInfo>(1, _omitFieldNames ? '' : 'systemGenerated', protoName: 'systemGenerated', subBuilder: SystemGeneratedMeetingInfo.create)
    ..aOM<CreatorDefinedMeetingInfo>(2, _omitFieldNames ? '' : 'creatorDefinedMeeting', protoName: 'creatorDefinedMeeting', subBuilder: CreatorDefinedMeetingInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MeetingInfo clone() => MeetingInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MeetingInfo copyWith(void Function(MeetingInfo) updates) => super.copyWith((message) => updates(message as MeetingInfo)) as MeetingInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MeetingInfo create() => MeetingInfo._();
  MeetingInfo createEmptyInstance() => create();
  static $pb.PbList<MeetingInfo> createRepeated() => $pb.PbList<MeetingInfo>();
  @$core.pragma('dart2js:noInline')
  static MeetingInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MeetingInfo>(create);
  static MeetingInfo? _defaultInstance;

  @$pb.TagNumber(1)
  SystemGeneratedMeetingInfo get systemGenerated => $_getN(0);
  @$pb.TagNumber(1)
  set systemGenerated(SystemGeneratedMeetingInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSystemGenerated() => $_has(0);
  @$pb.TagNumber(1)
  void clearSystemGenerated() => clearField(1);
  @$pb.TagNumber(1)
  SystemGeneratedMeetingInfo ensureSystemGenerated() => $_ensure(0);

  @$pb.TagNumber(2)
  CreatorDefinedMeetingInfo get creatorDefinedMeeting => $_getN(1);
  @$pb.TagNumber(2)
  set creatorDefinedMeeting(CreatorDefinedMeetingInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatorDefinedMeeting() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorDefinedMeeting() => clearField(2);
  @$pb.TagNumber(2)
  CreatorDefinedMeetingInfo ensureCreatorDefinedMeeting() => $_ensure(1);
}

class MeetingRepeatInfo extends $pb.GeneratedMessage {
  factory MeetingRepeatInfo({
    $fixnum.Int64? endDate,
    $core.int? repeatTimes,
    $core.String? repeatType,
    $core.String? uintType,
    $core.int? interval,
  }) {
    final $result = create();
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (repeatTimes != null) {
      $result.repeatTimes = repeatTimes;
    }
    if (repeatType != null) {
      $result.repeatType = repeatType;
    }
    if (uintType != null) {
      $result.uintType = uintType;
    }
    if (interval != null) {
      $result.interval = interval;
    }
    return $result;
  }
  MeetingRepeatInfo._() : super();
  factory MeetingRepeatInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeetingRepeatInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MeetingRepeatInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'endDate', protoName: 'endDate')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'repeatTimes', $pb.PbFieldType.O3, protoName: 'repeatTimes')
    ..aOS(3, _omitFieldNames ? '' : 'repeatType', protoName: 'repeatType')
    ..aOS(4, _omitFieldNames ? '' : 'uintType', protoName: 'uintType')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'interval', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MeetingRepeatInfo clone() => MeetingRepeatInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MeetingRepeatInfo copyWith(void Function(MeetingRepeatInfo) updates) => super.copyWith((message) => updates(message as MeetingRepeatInfo)) as MeetingRepeatInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MeetingRepeatInfo create() => MeetingRepeatInfo._();
  MeetingRepeatInfo createEmptyInstance() => create();
  static $pb.PbList<MeetingRepeatInfo> createRepeated() => $pb.PbList<MeetingRepeatInfo>();
  @$core.pragma('dart2js:noInline')
  static MeetingRepeatInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MeetingRepeatInfo>(create);
  static MeetingRepeatInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get endDate => $_getI64(0);
  @$pb.TagNumber(1)
  set endDate($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEndDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearEndDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get repeatTimes => $_getIZ(1);
  @$pb.TagNumber(2)
  set repeatTimes($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRepeatTimes() => $_has(1);
  @$pb.TagNumber(2)
  void clearRepeatTimes() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get repeatType => $_getSZ(2);
  @$pb.TagNumber(3)
  set repeatType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRepeatType() => $_has(2);
  @$pb.TagNumber(3)
  void clearRepeatType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uintType => $_getSZ(3);
  @$pb.TagNumber(4)
  set uintType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUintType() => $_has(3);
  @$pb.TagNumber(4)
  void clearUintType() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get interval => $_getIZ(4);
  @$pb.TagNumber(5)
  set interval($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasInterval() => $_has(4);
  @$pb.TagNumber(5)
  void clearInterval() => clearField(5);
}

/// Settings controlling meeting features such as video, audio, and screen sharing permissions.
class MeetingSetting extends $pb.GeneratedMessage {
  factory MeetingSetting({
    $core.bool? canParticipantsEnableCamera,
    $core.bool? canParticipantsUnmuteMicrophone,
    $core.bool? canParticipantsShareScreen,
    $core.bool? disableCameraOnJoin,
    $core.bool? disableMicrophoneOnJoin,
    $core.bool? canParticipantJoinMeetingEarly,
    $core.bool? lockMeeting,
    $core.bool? audioEncouragement,
    $core.bool? videoMirroring,
  }) {
    final $result = create();
    if (canParticipantsEnableCamera != null) {
      $result.canParticipantsEnableCamera = canParticipantsEnableCamera;
    }
    if (canParticipantsUnmuteMicrophone != null) {
      $result.canParticipantsUnmuteMicrophone = canParticipantsUnmuteMicrophone;
    }
    if (canParticipantsShareScreen != null) {
      $result.canParticipantsShareScreen = canParticipantsShareScreen;
    }
    if (disableCameraOnJoin != null) {
      $result.disableCameraOnJoin = disableCameraOnJoin;
    }
    if (disableMicrophoneOnJoin != null) {
      $result.disableMicrophoneOnJoin = disableMicrophoneOnJoin;
    }
    if (canParticipantJoinMeetingEarly != null) {
      $result.canParticipantJoinMeetingEarly = canParticipantJoinMeetingEarly;
    }
    if (lockMeeting != null) {
      $result.lockMeeting = lockMeeting;
    }
    if (audioEncouragement != null) {
      $result.audioEncouragement = audioEncouragement;
    }
    if (videoMirroring != null) {
      $result.videoMirroring = videoMirroring;
    }
    return $result;
  }
  MeetingSetting._() : super();
  factory MeetingSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeetingSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MeetingSetting', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'canParticipantsEnableCamera', protoName: 'canParticipantsEnableCamera')
    ..aOB(2, _omitFieldNames ? '' : 'canParticipantsUnmuteMicrophone', protoName: 'canParticipantsUnmuteMicrophone')
    ..aOB(3, _omitFieldNames ? '' : 'canParticipantsShareScreen', protoName: 'canParticipantsShareScreen')
    ..aOB(4, _omitFieldNames ? '' : 'disableCameraOnJoin', protoName: 'disableCameraOnJoin')
    ..aOB(5, _omitFieldNames ? '' : 'disableMicrophoneOnJoin', protoName: 'disableMicrophoneOnJoin')
    ..aOB(6, _omitFieldNames ? '' : 'canParticipantJoinMeetingEarly', protoName: 'canParticipantJoinMeetingEarly')
    ..aOB(7, _omitFieldNames ? '' : 'lockMeeting', protoName: 'lockMeeting')
    ..aOB(8, _omitFieldNames ? '' : 'audioEncouragement', protoName: 'audioEncouragement')
    ..aOB(9, _omitFieldNames ? '' : 'videoMirroring', protoName: 'videoMirroring')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MeetingSetting clone() => MeetingSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MeetingSetting copyWith(void Function(MeetingSetting) updates) => super.copyWith((message) => updates(message as MeetingSetting)) as MeetingSetting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MeetingSetting create() => MeetingSetting._();
  MeetingSetting createEmptyInstance() => create();
  static $pb.PbList<MeetingSetting> createRepeated() => $pb.PbList<MeetingSetting>();
  @$core.pragma('dart2js:noInline')
  static MeetingSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MeetingSetting>(create);
  static MeetingSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get canParticipantsEnableCamera => $_getBF(0);
  @$pb.TagNumber(1)
  set canParticipantsEnableCamera($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCanParticipantsEnableCamera() => $_has(0);
  @$pb.TagNumber(1)
  void clearCanParticipantsEnableCamera() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get canParticipantsUnmuteMicrophone => $_getBF(1);
  @$pb.TagNumber(2)
  set canParticipantsUnmuteMicrophone($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCanParticipantsUnmuteMicrophone() => $_has(1);
  @$pb.TagNumber(2)
  void clearCanParticipantsUnmuteMicrophone() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get canParticipantsShareScreen => $_getBF(2);
  @$pb.TagNumber(3)
  set canParticipantsShareScreen($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCanParticipantsShareScreen() => $_has(2);
  @$pb.TagNumber(3)
  void clearCanParticipantsShareScreen() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get disableCameraOnJoin => $_getBF(3);
  @$pb.TagNumber(4)
  set disableCameraOnJoin($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDisableCameraOnJoin() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisableCameraOnJoin() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get disableMicrophoneOnJoin => $_getBF(4);
  @$pb.TagNumber(5)
  set disableMicrophoneOnJoin($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDisableMicrophoneOnJoin() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisableMicrophoneOnJoin() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get canParticipantJoinMeetingEarly => $_getBF(5);
  @$pb.TagNumber(6)
  set canParticipantJoinMeetingEarly($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCanParticipantJoinMeetingEarly() => $_has(5);
  @$pb.TagNumber(6)
  void clearCanParticipantJoinMeetingEarly() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get lockMeeting => $_getBF(6);
  @$pb.TagNumber(7)
  set lockMeeting($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLockMeeting() => $_has(6);
  @$pb.TagNumber(7)
  void clearLockMeeting() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get audioEncouragement => $_getBF(7);
  @$pb.TagNumber(8)
  set audioEncouragement($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAudioEncouragement() => $_has(7);
  @$pb.TagNumber(8)
  void clearAudioEncouragement() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get videoMirroring => $_getBF(8);
  @$pb.TagNumber(9)
  set videoMirroring($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasVideoMirroring() => $_has(8);
  @$pb.TagNumber(9)
  void clearVideoMirroring() => clearField(9);
}

/// Detailed information about a meeting, combining info and settings.
class MeetingInfoSetting extends $pb.GeneratedMessage {
  factory MeetingInfoSetting({
    MeetingInfo? info,
    MeetingSetting? setting,
    MeetingRepeatInfo? repeatInfo,
  }) {
    final $result = create();
    if (info != null) {
      $result.info = info;
    }
    if (setting != null) {
      $result.setting = setting;
    }
    if (repeatInfo != null) {
      $result.repeatInfo = repeatInfo;
    }
    return $result;
  }
  MeetingInfoSetting._() : super();
  factory MeetingInfoSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeetingInfoSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MeetingInfoSetting', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<MeetingInfo>(1, _omitFieldNames ? '' : 'info', subBuilder: MeetingInfo.create)
    ..aOM<MeetingSetting>(2, _omitFieldNames ? '' : 'setting', subBuilder: MeetingSetting.create)
    ..aOM<MeetingRepeatInfo>(3, _omitFieldNames ? '' : 'repeatInfo', protoName: 'repeatInfo', subBuilder: MeetingRepeatInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MeetingInfoSetting clone() => MeetingInfoSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MeetingInfoSetting copyWith(void Function(MeetingInfoSetting) updates) => super.copyWith((message) => updates(message as MeetingInfoSetting)) as MeetingInfoSetting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MeetingInfoSetting create() => MeetingInfoSetting._();
  MeetingInfoSetting createEmptyInstance() => create();
  static $pb.PbList<MeetingInfoSetting> createRepeated() => $pb.PbList<MeetingInfoSetting>();
  @$core.pragma('dart2js:noInline')
  static MeetingInfoSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MeetingInfoSetting>(create);
  static MeetingInfoSetting? _defaultInstance;

  @$pb.TagNumber(1)
  MeetingInfo get info => $_getN(0);
  @$pb.TagNumber(1)
  set info(MeetingInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => clearField(1);
  @$pb.TagNumber(1)
  MeetingInfo ensureInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  MeetingSetting get setting => $_getN(1);
  @$pb.TagNumber(2)
  set setting(MeetingSetting v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSetting() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetting() => clearField(2);
  @$pb.TagNumber(2)
  MeetingSetting ensureSetting() => $_ensure(1);

  @$pb.TagNumber(3)
  MeetingRepeatInfo get repeatInfo => $_getN(2);
  @$pb.TagNumber(3)
  set repeatInfo(MeetingRepeatInfo v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRepeatInfo() => $_has(2);
  @$pb.TagNumber(3)
  void clearRepeatInfo() => clearField(3);
  @$pb.TagNumber(3)
  MeetingRepeatInfo ensureRepeatInfo() => $_ensure(2);
}

class UserInfo extends $pb.GeneratedMessage {
  factory UserInfo({
    $core.String? userID,
    $core.String? nickname,
    $core.String? account,
  }) {
    final $result = create();
    if (userID != null) {
      $result.userID = userID;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  UserInfo._() : super();
  factory UserInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOS(2, _omitFieldNames ? '' : 'nickname')
    ..aOS(3, _omitFieldNames ? '' : 'account')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserInfo clone() => UserInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserInfo copyWith(void Function(UserInfo) updates) => super.copyWith((message) => updates(message as UserInfo)) as UserInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserInfo create() => UserInfo._();
  UserInfo createEmptyInstance() => create();
  static $pb.PbList<UserInfo> createRepeated() => $pb.PbList<UserInfo>();
  @$core.pragma('dart2js:noInline')
  static UserInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserInfo>(create);
  static UserInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userID => $_getSZ(0);
  @$pb.TagNumber(1)
  set userID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get nickname => $_getSZ(1);
  @$pb.TagNumber(2)
  set nickname($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNickname() => $_has(1);
  @$pb.TagNumber(2)
  void clearNickname() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get account => $_getSZ(2);
  @$pb.TagNumber(3)
  set account($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => clearField(3);
}

/// participant meta data
class ParticipantMetaData extends $pb.GeneratedMessage {
  factory ParticipantMetaData({
    UserInfo? userInfo,
  }) {
    final $result = create();
    if (userInfo != null) {
      $result.userInfo = userInfo;
    }
    return $result;
  }
  ParticipantMetaData._() : super();
  factory ParticipantMetaData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ParticipantMetaData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ParticipantMetaData', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<UserInfo>(1, _omitFieldNames ? '' : 'userInfo', protoName: 'userInfo', subBuilder: UserInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ParticipantMetaData clone() => ParticipantMetaData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ParticipantMetaData copyWith(void Function(ParticipantMetaData) updates) => super.copyWith((message) => updates(message as ParticipantMetaData)) as ParticipantMetaData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ParticipantMetaData create() => ParticipantMetaData._();
  ParticipantMetaData createEmptyInstance() => create();
  static $pb.PbList<ParticipantMetaData> createRepeated() => $pb.PbList<ParticipantMetaData>();
  @$core.pragma('dart2js:noInline')
  static ParticipantMetaData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ParticipantMetaData>(create);
  static ParticipantMetaData? _defaultInstance;

  @$pb.TagNumber(1)
  UserInfo get userInfo => $_getN(0);
  @$pb.TagNumber(1)
  set userInfo(UserInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserInfo() => clearField(1);
  @$pb.TagNumber(1)
  UserInfo ensureUserInfo() => $_ensure(0);
}

/// Request to book a future meeting.
class BookMeetingReq extends $pb.GeneratedMessage {
  factory BookMeetingReq({
    $core.String? creatorUserID,
    CreatorDefinedMeetingInfo? creatorDefinedMeetingInfo,
    MeetingSetting? setting,
    MeetingRepeatInfo? repeatInfo,
  }) {
    final $result = create();
    if (creatorUserID != null) {
      $result.creatorUserID = creatorUserID;
    }
    if (creatorDefinedMeetingInfo != null) {
      $result.creatorDefinedMeetingInfo = creatorDefinedMeetingInfo;
    }
    if (setting != null) {
      $result.setting = setting;
    }
    if (repeatInfo != null) {
      $result.repeatInfo = repeatInfo;
    }
    return $result;
  }
  BookMeetingReq._() : super();
  factory BookMeetingReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BookMeetingReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BookMeetingReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'creatorUserID', protoName: 'creatorUserID')
    ..aOM<CreatorDefinedMeetingInfo>(2, _omitFieldNames ? '' : 'creatorDefinedMeetingInfo', protoName: 'creatorDefinedMeetingInfo', subBuilder: CreatorDefinedMeetingInfo.create)
    ..aOM<MeetingSetting>(3, _omitFieldNames ? '' : 'setting', subBuilder: MeetingSetting.create)
    ..aOM<MeetingRepeatInfo>(4, _omitFieldNames ? '' : 'repeatInfo', protoName: 'repeatInfo', subBuilder: MeetingRepeatInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BookMeetingReq clone() => BookMeetingReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BookMeetingReq copyWith(void Function(BookMeetingReq) updates) => super.copyWith((message) => updates(message as BookMeetingReq)) as BookMeetingReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BookMeetingReq create() => BookMeetingReq._();
  BookMeetingReq createEmptyInstance() => create();
  static $pb.PbList<BookMeetingReq> createRepeated() => $pb.PbList<BookMeetingReq>();
  @$core.pragma('dart2js:noInline')
  static BookMeetingReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BookMeetingReq>(create);
  static BookMeetingReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get creatorUserID => $_getSZ(0);
  @$pb.TagNumber(1)
  set creatorUserID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreatorUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreatorUserID() => clearField(1);

  @$pb.TagNumber(2)
  CreatorDefinedMeetingInfo get creatorDefinedMeetingInfo => $_getN(1);
  @$pb.TagNumber(2)
  set creatorDefinedMeetingInfo(CreatorDefinedMeetingInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatorDefinedMeetingInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorDefinedMeetingInfo() => clearField(2);
  @$pb.TagNumber(2)
  CreatorDefinedMeetingInfo ensureCreatorDefinedMeetingInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  MeetingSetting get setting => $_getN(2);
  @$pb.TagNumber(3)
  set setting(MeetingSetting v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSetting() => $_has(2);
  @$pb.TagNumber(3)
  void clearSetting() => clearField(3);
  @$pb.TagNumber(3)
  MeetingSetting ensureSetting() => $_ensure(2);

  @$pb.TagNumber(4)
  MeetingRepeatInfo get repeatInfo => $_getN(3);
  @$pb.TagNumber(4)
  set repeatInfo(MeetingRepeatInfo v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRepeatInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearRepeatInfo() => clearField(4);
  @$pb.TagNumber(4)
  MeetingRepeatInfo ensureRepeatInfo() => $_ensure(3);
}

/// Response after booking a meeting.
class BookMeetingResp extends $pb.GeneratedMessage {
  factory BookMeetingResp({
    MeetingInfoSetting? detail,
  }) {
    final $result = create();
    if (detail != null) {
      $result.detail = detail;
    }
    return $result;
  }
  BookMeetingResp._() : super();
  factory BookMeetingResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BookMeetingResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BookMeetingResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<MeetingInfoSetting>(1, _omitFieldNames ? '' : 'detail', subBuilder: MeetingInfoSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BookMeetingResp clone() => BookMeetingResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BookMeetingResp copyWith(void Function(BookMeetingResp) updates) => super.copyWith((message) => updates(message as BookMeetingResp)) as BookMeetingResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BookMeetingResp create() => BookMeetingResp._();
  BookMeetingResp createEmptyInstance() => create();
  static $pb.PbList<BookMeetingResp> createRepeated() => $pb.PbList<BookMeetingResp>();
  @$core.pragma('dart2js:noInline')
  static BookMeetingResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BookMeetingResp>(create);
  static BookMeetingResp? _defaultInstance;

  @$pb.TagNumber(1)
  MeetingInfoSetting get detail => $_getN(0);
  @$pb.TagNumber(1)
  set detail(MeetingInfoSetting v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDetail() => $_has(0);
  @$pb.TagNumber(1)
  void clearDetail() => clearField(1);
  @$pb.TagNumber(1)
  MeetingInfoSetting ensureDetail() => $_ensure(0);
}

/// Request to create an immediate meeting.
class CreateImmediateMeetingReq extends $pb.GeneratedMessage {
  factory CreateImmediateMeetingReq({
    $core.String? creatorUserID,
    CreatorDefinedMeetingInfo? creatorDefinedMeetingInfo,
    MeetingSetting? setting,
  }) {
    final $result = create();
    if (creatorUserID != null) {
      $result.creatorUserID = creatorUserID;
    }
    if (creatorDefinedMeetingInfo != null) {
      $result.creatorDefinedMeetingInfo = creatorDefinedMeetingInfo;
    }
    if (setting != null) {
      $result.setting = setting;
    }
    return $result;
  }
  CreateImmediateMeetingReq._() : super();
  factory CreateImmediateMeetingReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateImmediateMeetingReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateImmediateMeetingReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'creatorUserID', protoName: 'creatorUserID')
    ..aOM<CreatorDefinedMeetingInfo>(2, _omitFieldNames ? '' : 'creatorDefinedMeetingInfo', protoName: 'creatorDefinedMeetingInfo', subBuilder: CreatorDefinedMeetingInfo.create)
    ..aOM<MeetingSetting>(3, _omitFieldNames ? '' : 'setting', subBuilder: MeetingSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateImmediateMeetingReq clone() => CreateImmediateMeetingReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateImmediateMeetingReq copyWith(void Function(CreateImmediateMeetingReq) updates) => super.copyWith((message) => updates(message as CreateImmediateMeetingReq)) as CreateImmediateMeetingReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateImmediateMeetingReq create() => CreateImmediateMeetingReq._();
  CreateImmediateMeetingReq createEmptyInstance() => create();
  static $pb.PbList<CreateImmediateMeetingReq> createRepeated() => $pb.PbList<CreateImmediateMeetingReq>();
  @$core.pragma('dart2js:noInline')
  static CreateImmediateMeetingReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateImmediateMeetingReq>(create);
  static CreateImmediateMeetingReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get creatorUserID => $_getSZ(0);
  @$pb.TagNumber(1)
  set creatorUserID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCreatorUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreatorUserID() => clearField(1);

  @$pb.TagNumber(2)
  CreatorDefinedMeetingInfo get creatorDefinedMeetingInfo => $_getN(1);
  @$pb.TagNumber(2)
  set creatorDefinedMeetingInfo(CreatorDefinedMeetingInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatorDefinedMeetingInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorDefinedMeetingInfo() => clearField(2);
  @$pb.TagNumber(2)
  CreatorDefinedMeetingInfo ensureCreatorDefinedMeetingInfo() => $_ensure(1);

  @$pb.TagNumber(3)
  MeetingSetting get setting => $_getN(2);
  @$pb.TagNumber(3)
  set setting(MeetingSetting v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSetting() => $_has(2);
  @$pb.TagNumber(3)
  void clearSetting() => clearField(3);
  @$pb.TagNumber(3)
  MeetingSetting ensureSetting() => $_ensure(2);
}

/// Response after creating an immediate meeting.
class CreateImmediateMeetingResp extends $pb.GeneratedMessage {
  factory CreateImmediateMeetingResp({
    MeetingInfoSetting? detail,
    LiveKit? liveKit,
  }) {
    final $result = create();
    if (detail != null) {
      $result.detail = detail;
    }
    if (liveKit != null) {
      $result.liveKit = liveKit;
    }
    return $result;
  }
  CreateImmediateMeetingResp._() : super();
  factory CreateImmediateMeetingResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateImmediateMeetingResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateImmediateMeetingResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<MeetingInfoSetting>(1, _omitFieldNames ? '' : 'detail', subBuilder: MeetingInfoSetting.create)
    ..aOM<LiveKit>(2, _omitFieldNames ? '' : 'liveKit', protoName: 'liveKit', subBuilder: LiveKit.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateImmediateMeetingResp clone() => CreateImmediateMeetingResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateImmediateMeetingResp copyWith(void Function(CreateImmediateMeetingResp) updates) => super.copyWith((message) => updates(message as CreateImmediateMeetingResp)) as CreateImmediateMeetingResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateImmediateMeetingResp create() => CreateImmediateMeetingResp._();
  CreateImmediateMeetingResp createEmptyInstance() => create();
  static $pb.PbList<CreateImmediateMeetingResp> createRepeated() => $pb.PbList<CreateImmediateMeetingResp>();
  @$core.pragma('dart2js:noInline')
  static CreateImmediateMeetingResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateImmediateMeetingResp>(create);
  static CreateImmediateMeetingResp? _defaultInstance;

  @$pb.TagNumber(1)
  MeetingInfoSetting get detail => $_getN(0);
  @$pb.TagNumber(1)
  set detail(MeetingInfoSetting v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDetail() => $_has(0);
  @$pb.TagNumber(1)
  void clearDetail() => clearField(1);
  @$pb.TagNumber(1)
  MeetingInfoSetting ensureDetail() => $_ensure(0);

  @$pb.TagNumber(2)
  LiveKit get liveKit => $_getN(1);
  @$pb.TagNumber(2)
  set liveKit(LiveKit v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLiveKit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLiveKit() => clearField(2);
  @$pb.TagNumber(2)
  LiveKit ensureLiveKit() => $_ensure(1);
}

/// Request to join a meeting.
class JoinMeetingReq extends $pb.GeneratedMessage {
  factory JoinMeetingReq({
    $core.String? meetingID,
    $core.String? userID,
    $core.String? password,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    if (password != null) {
      $result.password = password;
    }
    return $result;
  }
  JoinMeetingReq._() : super();
  factory JoinMeetingReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinMeetingReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinMeetingReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOS(3, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinMeetingReq clone() => JoinMeetingReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinMeetingReq copyWith(void Function(JoinMeetingReq) updates) => super.copyWith((message) => updates(message as JoinMeetingReq)) as JoinMeetingReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinMeetingReq create() => JoinMeetingReq._();
  JoinMeetingReq createEmptyInstance() => create();
  static $pb.PbList<JoinMeetingReq> createRepeated() => $pb.PbList<JoinMeetingReq>();
  @$core.pragma('dart2js:noInline')
  static JoinMeetingReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinMeetingReq>(create);
  static JoinMeetingReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => clearField(3);
}

/// Response after joining a meeting.
class JoinMeetingResp extends $pb.GeneratedMessage {
  factory JoinMeetingResp({
    LiveKit? liveKit,
  }) {
    final $result = create();
    if (liveKit != null) {
      $result.liveKit = liveKit;
    }
    return $result;
  }
  JoinMeetingResp._() : super();
  factory JoinMeetingResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinMeetingResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinMeetingResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<LiveKit>(1, _omitFieldNames ? '' : 'liveKit', protoName: 'liveKit', subBuilder: LiveKit.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinMeetingResp clone() => JoinMeetingResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinMeetingResp copyWith(void Function(JoinMeetingResp) updates) => super.copyWith((message) => updates(message as JoinMeetingResp)) as JoinMeetingResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinMeetingResp create() => JoinMeetingResp._();
  JoinMeetingResp createEmptyInstance() => create();
  static $pb.PbList<JoinMeetingResp> createRepeated() => $pb.PbList<JoinMeetingResp>();
  @$core.pragma('dart2js:noInline')
  static JoinMeetingResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinMeetingResp>(create);
  static JoinMeetingResp? _defaultInstance;

  @$pb.TagNumber(1)
  LiveKit get liveKit => $_getN(0);
  @$pb.TagNumber(1)
  set liveKit(LiveKit v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLiveKit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLiveKit() => clearField(1);
  @$pb.TagNumber(1)
  LiveKit ensureLiveKit() => $_ensure(0);
}

/// Request to get a specific meeting token.
class GetMeetingTokenReq extends $pb.GeneratedMessage {
  factory GetMeetingTokenReq({
    $core.String? meetingID,
    $core.String? userID,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    return $result;
  }
  GetMeetingTokenReq._() : super();
  factory GetMeetingTokenReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMeetingTokenReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMeetingTokenReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMeetingTokenReq clone() => GetMeetingTokenReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMeetingTokenReq copyWith(void Function(GetMeetingTokenReq) updates) => super.copyWith((message) => updates(message as GetMeetingTokenReq)) as GetMeetingTokenReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeetingTokenReq create() => GetMeetingTokenReq._();
  GetMeetingTokenReq createEmptyInstance() => create();
  static $pb.PbList<GetMeetingTokenReq> createRepeated() => $pb.PbList<GetMeetingTokenReq>();
  @$core.pragma('dart2js:noInline')
  static GetMeetingTokenReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeetingTokenReq>(create);
  static GetMeetingTokenReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);
}

/// Response after getting a specific meeting.
class GetMeetingTokenResp extends $pb.GeneratedMessage {
  factory GetMeetingTokenResp({
    $core.String? meetingID,
    LiveKit? liveKit,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (liveKit != null) {
      $result.liveKit = liveKit;
    }
    return $result;
  }
  GetMeetingTokenResp._() : super();
  factory GetMeetingTokenResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMeetingTokenResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMeetingTokenResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOM<LiveKit>(2, _omitFieldNames ? '' : 'liveKit', protoName: 'liveKit', subBuilder: LiveKit.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMeetingTokenResp clone() => GetMeetingTokenResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMeetingTokenResp copyWith(void Function(GetMeetingTokenResp) updates) => super.copyWith((message) => updates(message as GetMeetingTokenResp)) as GetMeetingTokenResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeetingTokenResp create() => GetMeetingTokenResp._();
  GetMeetingTokenResp createEmptyInstance() => create();
  static $pb.PbList<GetMeetingTokenResp> createRepeated() => $pb.PbList<GetMeetingTokenResp>();
  @$core.pragma('dart2js:noInline')
  static GetMeetingTokenResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeetingTokenResp>(create);
  static GetMeetingTokenResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  LiveKit get liveKit => $_getN(1);
  @$pb.TagNumber(2)
  set liveKit(LiveKit v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLiveKit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLiveKit() => clearField(2);
  @$pb.TagNumber(2)
  LiveKit ensureLiveKit() => $_ensure(1);
}

/// Request to leave a meeting.
class LeaveMeetingReq extends $pb.GeneratedMessage {
  factory LeaveMeetingReq({
    $core.String? meetingID,
    $core.String? userID,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    return $result;
  }
  LeaveMeetingReq._() : super();
  factory LeaveMeetingReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaveMeetingReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaveMeetingReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaveMeetingReq clone() => LeaveMeetingReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaveMeetingReq copyWith(void Function(LeaveMeetingReq) updates) => super.copyWith((message) => updates(message as LeaveMeetingReq)) as LeaveMeetingReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveMeetingReq create() => LeaveMeetingReq._();
  LeaveMeetingReq createEmptyInstance() => create();
  static $pb.PbList<LeaveMeetingReq> createRepeated() => $pb.PbList<LeaveMeetingReq>();
  @$core.pragma('dart2js:noInline')
  static LeaveMeetingReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveMeetingReq>(create);
  static LeaveMeetingReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);
}

/// Response after leaving a meeting.
class LeaveMeetingResp extends $pb.GeneratedMessage {
  factory LeaveMeetingResp() => create();
  LeaveMeetingResp._() : super();
  factory LeaveMeetingResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LeaveMeetingResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LeaveMeetingResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LeaveMeetingResp clone() => LeaveMeetingResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LeaveMeetingResp copyWith(void Function(LeaveMeetingResp) updates) => super.copyWith((message) => updates(message as LeaveMeetingResp)) as LeaveMeetingResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveMeetingResp create() => LeaveMeetingResp._();
  LeaveMeetingResp createEmptyInstance() => create();
  static $pb.PbList<LeaveMeetingResp> createRepeated() => $pb.PbList<LeaveMeetingResp>();
  @$core.pragma('dart2js:noInline')
  static LeaveMeetingResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveMeetingResp>(create);
  static LeaveMeetingResp? _defaultInstance;
}

/// Request to end a meeting.
class EndMeetingReq extends $pb.GeneratedMessage {
  factory EndMeetingReq({
    $core.String? meetingID,
    $core.String? userID,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    return $result;
  }
  EndMeetingReq._() : super();
  factory EndMeetingReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EndMeetingReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EndMeetingReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EndMeetingReq clone() => EndMeetingReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EndMeetingReq copyWith(void Function(EndMeetingReq) updates) => super.copyWith((message) => updates(message as EndMeetingReq)) as EndMeetingReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndMeetingReq create() => EndMeetingReq._();
  EndMeetingReq createEmptyInstance() => create();
  static $pb.PbList<EndMeetingReq> createRepeated() => $pb.PbList<EndMeetingReq>();
  @$core.pragma('dart2js:noInline')
  static EndMeetingReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EndMeetingReq>(create);
  static EndMeetingReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);
}

/// Response after ending a meeting.
class EndMeetingResp extends $pb.GeneratedMessage {
  factory EndMeetingResp() => create();
  EndMeetingResp._() : super();
  factory EndMeetingResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EndMeetingResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EndMeetingResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EndMeetingResp clone() => EndMeetingResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EndMeetingResp copyWith(void Function(EndMeetingResp) updates) => super.copyWith((message) => updates(message as EndMeetingResp)) as EndMeetingResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndMeetingResp create() => EndMeetingResp._();
  EndMeetingResp createEmptyInstance() => create();
  static $pb.PbList<EndMeetingResp> createRepeated() => $pb.PbList<EndMeetingResp>();
  @$core.pragma('dart2js:noInline')
  static EndMeetingResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EndMeetingResp>(create);
  static EndMeetingResp? _defaultInstance;
}

/// Request to get a list of meetings both created and joined by a user.
class GetMeetingsReq extends $pb.GeneratedMessage {
  factory GetMeetingsReq({
    $core.String? userID,
    $core.Iterable<$core.String>? status,
  }) {
    final $result = create();
    if (userID != null) {
      $result.userID = userID;
    }
    if (status != null) {
      $result.status.addAll(status);
    }
    return $result;
  }
  GetMeetingsReq._() : super();
  factory GetMeetingsReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMeetingsReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMeetingsReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..pPS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMeetingsReq clone() => GetMeetingsReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMeetingsReq copyWith(void Function(GetMeetingsReq) updates) => super.copyWith((message) => updates(message as GetMeetingsReq)) as GetMeetingsReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeetingsReq create() => GetMeetingsReq._();
  GetMeetingsReq createEmptyInstance() => create();
  static $pb.PbList<GetMeetingsReq> createRepeated() => $pb.PbList<GetMeetingsReq>();
  @$core.pragma('dart2js:noInline')
  static GetMeetingsReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeetingsReq>(create);
  static GetMeetingsReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userID => $_getSZ(0);
  @$pb.TagNumber(1)
  set userID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserID() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get status => $_getList(1);
}

/// Response with a list of meetings that the user has created or joined.
class GetMeetingsResp extends $pb.GeneratedMessage {
  factory GetMeetingsResp({
    $core.Iterable<MeetingInfoSetting>? meetingDetails,
  }) {
    final $result = create();
    if (meetingDetails != null) {
      $result.meetingDetails.addAll(meetingDetails);
    }
    return $result;
  }
  GetMeetingsResp._() : super();
  factory GetMeetingsResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMeetingsResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMeetingsResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..pc<MeetingInfoSetting>(1, _omitFieldNames ? '' : 'meetingDetails', $pb.PbFieldType.PM, protoName: 'meetingDetails', subBuilder: MeetingInfoSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMeetingsResp clone() => GetMeetingsResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMeetingsResp copyWith(void Function(GetMeetingsResp) updates) => super.copyWith((message) => updates(message as GetMeetingsResp)) as GetMeetingsResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeetingsResp create() => GetMeetingsResp._();
  GetMeetingsResp createEmptyInstance() => create();
  static $pb.PbList<GetMeetingsResp> createRepeated() => $pb.PbList<GetMeetingsResp>();
  @$core.pragma('dart2js:noInline')
  static GetMeetingsResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeetingsResp>(create);
  static GetMeetingsResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MeetingInfoSetting> get meetingDetails => $_getList(0);
}

/// Request to get information about a specific meeting.
class GetMeetingReq extends $pb.GeneratedMessage {
  factory GetMeetingReq({
    $core.String? userID,
    $core.String? meetingID,
  }) {
    final $result = create();
    if (userID != null) {
      $result.userID = userID;
    }
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    return $result;
  }
  GetMeetingReq._() : super();
  factory GetMeetingReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMeetingReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMeetingReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOS(2, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMeetingReq clone() => GetMeetingReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMeetingReq copyWith(void Function(GetMeetingReq) updates) => super.copyWith((message) => updates(message as GetMeetingReq)) as GetMeetingReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeetingReq create() => GetMeetingReq._();
  GetMeetingReq createEmptyInstance() => create();
  static $pb.PbList<GetMeetingReq> createRepeated() => $pb.PbList<GetMeetingReq>();
  @$core.pragma('dart2js:noInline')
  static GetMeetingReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeetingReq>(create);
  static GetMeetingReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userID => $_getSZ(0);
  @$pb.TagNumber(1)
  set userID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get meetingID => $_getSZ(1);
  @$pb.TagNumber(2)
  set meetingID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMeetingID() => $_has(1);
  @$pb.TagNumber(2)
  void clearMeetingID() => clearField(2);
}

/// Response with detailed information about a meeting.
class GetMeetingResp extends $pb.GeneratedMessage {
  factory GetMeetingResp({
    MeetingInfoSetting? meetingDetail,
  }) {
    final $result = create();
    if (meetingDetail != null) {
      $result.meetingDetail = meetingDetail;
    }
    return $result;
  }
  GetMeetingResp._() : super();
  factory GetMeetingResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMeetingResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMeetingResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<MeetingInfoSetting>(1, _omitFieldNames ? '' : 'meetingDetail', protoName: 'meetingDetail', subBuilder: MeetingInfoSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMeetingResp clone() => GetMeetingResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMeetingResp copyWith(void Function(GetMeetingResp) updates) => super.copyWith((message) => updates(message as GetMeetingResp)) as GetMeetingResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeetingResp create() => GetMeetingResp._();
  GetMeetingResp createEmptyInstance() => create();
  static $pb.PbList<GetMeetingResp> createRepeated() => $pb.PbList<GetMeetingResp>();
  @$core.pragma('dart2js:noInline')
  static GetMeetingResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeetingResp>(create);
  static GetMeetingResp? _defaultInstance;

  @$pb.TagNumber(1)
  MeetingInfoSetting get meetingDetail => $_getN(0);
  @$pb.TagNumber(1)
  set meetingDetail(MeetingInfoSetting v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingDetail() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingDetail() => clearField(1);
  @$pb.TagNumber(1)
  MeetingInfoSetting ensureMeetingDetail() => $_ensure(0);
}

class ModifyMeetingParticipantNickNameReq extends $pb.GeneratedMessage {
  factory ModifyMeetingParticipantNickNameReq({
    $core.String? meetingID,
    $core.String? userID,
    $core.String? participantUserID,
    $core.String? nickname,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    if (participantUserID != null) {
      $result.participantUserID = participantUserID;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    return $result;
  }
  ModifyMeetingParticipantNickNameReq._() : super();
  factory ModifyMeetingParticipantNickNameReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ModifyMeetingParticipantNickNameReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ModifyMeetingParticipantNickNameReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOS(3, _omitFieldNames ? '' : 'participantUserID', protoName: 'participantUserID')
    ..aOS(4, _omitFieldNames ? '' : 'nickname')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ModifyMeetingParticipantNickNameReq clone() => ModifyMeetingParticipantNickNameReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ModifyMeetingParticipantNickNameReq copyWith(void Function(ModifyMeetingParticipantNickNameReq) updates) => super.copyWith((message) => updates(message as ModifyMeetingParticipantNickNameReq)) as ModifyMeetingParticipantNickNameReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ModifyMeetingParticipantNickNameReq create() => ModifyMeetingParticipantNickNameReq._();
  ModifyMeetingParticipantNickNameReq createEmptyInstance() => create();
  static $pb.PbList<ModifyMeetingParticipantNickNameReq> createRepeated() => $pb.PbList<ModifyMeetingParticipantNickNameReq>();
  @$core.pragma('dart2js:noInline')
  static ModifyMeetingParticipantNickNameReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ModifyMeetingParticipantNickNameReq>(create);
  static ModifyMeetingParticipantNickNameReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get participantUserID => $_getSZ(2);
  @$pb.TagNumber(3)
  set participantUserID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParticipantUserID() => $_has(2);
  @$pb.TagNumber(3)
  void clearParticipantUserID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get nickname => $_getSZ(3);
  @$pb.TagNumber(4)
  set nickname($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNickname() => $_has(3);
  @$pb.TagNumber(4)
  void clearNickname() => clearField(4);
}

class ModifyMeetingParticipantNickNameResp extends $pb.GeneratedMessage {
  factory ModifyMeetingParticipantNickNameResp() => create();
  ModifyMeetingParticipantNickNameResp._() : super();
  factory ModifyMeetingParticipantNickNameResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ModifyMeetingParticipantNickNameResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ModifyMeetingParticipantNickNameResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ModifyMeetingParticipantNickNameResp clone() => ModifyMeetingParticipantNickNameResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ModifyMeetingParticipantNickNameResp copyWith(void Function(ModifyMeetingParticipantNickNameResp) updates) => super.copyWith((message) => updates(message as ModifyMeetingParticipantNickNameResp)) as ModifyMeetingParticipantNickNameResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ModifyMeetingParticipantNickNameResp create() => ModifyMeetingParticipantNickNameResp._();
  ModifyMeetingParticipantNickNameResp createEmptyInstance() => create();
  static $pb.PbList<ModifyMeetingParticipantNickNameResp> createRepeated() => $pb.PbList<ModifyMeetingParticipantNickNameResp>();
  @$core.pragma('dart2js:noInline')
  static ModifyMeetingParticipantNickNameResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ModifyMeetingParticipantNickNameResp>(create);
  static ModifyMeetingParticipantNickNameResp? _defaultInstance;
}

/// Request to update specific fields of a meeting.
class UpdateMeetingRequest extends $pb.GeneratedMessage {
  factory UpdateMeetingRequest({
    $core.String? meetingID,
    $core.String? updatingUserID,
    $core.String? title,
    $fixnum.Int64? scheduledTime,
    $fixnum.Int64? meetingDuration,
    $core.String? password,
    $core.String? timeZone,
    MeetingRepeatInfo? repeatInfo,
    $core.bool? canParticipantsEnableCamera,
    $core.bool? canParticipantsUnmuteMicrophone,
    $core.bool? canParticipantsShareScreen,
    $core.bool? disableCameraOnJoin,
    $core.bool? disableMicrophoneOnJoin,
    $core.bool? canParticipantJoinMeetingEarly,
    $core.bool? lockMeeting,
    $core.bool? audioEncouragement,
    $core.bool? videoMirroring,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (updatingUserID != null) {
      $result.updatingUserID = updatingUserID;
    }
    if (title != null) {
      $result.title = title;
    }
    if (scheduledTime != null) {
      $result.scheduledTime = scheduledTime;
    }
    if (meetingDuration != null) {
      $result.meetingDuration = meetingDuration;
    }
    if (password != null) {
      $result.password = password;
    }
    if (timeZone != null) {
      $result.timeZone = timeZone;
    }
    if (repeatInfo != null) {
      $result.repeatInfo = repeatInfo;
    }
    if (canParticipantsEnableCamera != null) {
      $result.canParticipantsEnableCamera = canParticipantsEnableCamera;
    }
    if (canParticipantsUnmuteMicrophone != null) {
      $result.canParticipantsUnmuteMicrophone = canParticipantsUnmuteMicrophone;
    }
    if (canParticipantsShareScreen != null) {
      $result.canParticipantsShareScreen = canParticipantsShareScreen;
    }
    if (disableCameraOnJoin != null) {
      $result.disableCameraOnJoin = disableCameraOnJoin;
    }
    if (disableMicrophoneOnJoin != null) {
      $result.disableMicrophoneOnJoin = disableMicrophoneOnJoin;
    }
    if (canParticipantJoinMeetingEarly != null) {
      $result.canParticipantJoinMeetingEarly = canParticipantJoinMeetingEarly;
    }
    if (lockMeeting != null) {
      $result.lockMeeting = lockMeeting;
    }
    if (audioEncouragement != null) {
      $result.audioEncouragement = audioEncouragement;
    }
    if (videoMirroring != null) {
      $result.videoMirroring = videoMirroring;
    }
    return $result;
  }
  UpdateMeetingRequest._() : super();
  factory UpdateMeetingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMeetingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateMeetingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'updatingUserID', protoName: 'updatingUserID')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aInt64(4, _omitFieldNames ? '' : 'scheduledTime', protoName: 'scheduledTime')
    ..aInt64(5, _omitFieldNames ? '' : 'meetingDuration', protoName: 'meetingDuration')
    ..aOS(6, _omitFieldNames ? '' : 'password')
    ..aOS(7, _omitFieldNames ? '' : 'timeZone', protoName: 'timeZone')
    ..aOM<MeetingRepeatInfo>(8, _omitFieldNames ? '' : 'repeatInfo', protoName: 'repeatInfo', subBuilder: MeetingRepeatInfo.create)
    ..aOB(9, _omitFieldNames ? '' : 'canParticipantsEnableCamera', protoName: 'canParticipantsEnableCamera')
    ..aOB(10, _omitFieldNames ? '' : 'canParticipantsUnmuteMicrophone', protoName: 'canParticipantsUnmuteMicrophone')
    ..aOB(11, _omitFieldNames ? '' : 'canParticipantsShareScreen', protoName: 'canParticipantsShareScreen')
    ..aOB(12, _omitFieldNames ? '' : 'disableCameraOnJoin', protoName: 'disableCameraOnJoin')
    ..aOB(13, _omitFieldNames ? '' : 'disableMicrophoneOnJoin', protoName: 'disableMicrophoneOnJoin')
    ..aOB(14, _omitFieldNames ? '' : 'canParticipantJoinMeetingEarly', protoName: 'canParticipantJoinMeetingEarly')
    ..aOB(15, _omitFieldNames ? '' : 'lockMeeting', protoName: 'lockMeeting')
    ..aOB(16, _omitFieldNames ? '' : 'audioEncouragement', protoName: 'audioEncouragement')
    ..aOB(17, _omitFieldNames ? '' : 'videoMirroring', protoName: 'videoMirroring')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMeetingRequest clone() => UpdateMeetingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMeetingRequest copyWith(void Function(UpdateMeetingRequest) updates) => super.copyWith((message) => updates(message as UpdateMeetingRequest)) as UpdateMeetingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMeetingRequest create() => UpdateMeetingRequest._();
  UpdateMeetingRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMeetingRequest> createRepeated() => $pb.PbList<UpdateMeetingRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMeetingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMeetingRequest>(create);
  static UpdateMeetingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get updatingUserID => $_getSZ(1);
  @$pb.TagNumber(2)
  set updatingUserID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdatingUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdatingUserID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get scheduledTime => $_getI64(3);
  @$pb.TagNumber(4)
  set scheduledTime($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasScheduledTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearScheduledTime() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get meetingDuration => $_getI64(4);
  @$pb.TagNumber(5)
  set meetingDuration($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMeetingDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearMeetingDuration() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get password => $_getSZ(5);
  @$pb.TagNumber(6)
  set password($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPassword() => $_has(5);
  @$pb.TagNumber(6)
  void clearPassword() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get timeZone => $_getSZ(6);
  @$pb.TagNumber(7)
  set timeZone($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTimeZone() => $_has(6);
  @$pb.TagNumber(7)
  void clearTimeZone() => clearField(7);

  @$pb.TagNumber(8)
  MeetingRepeatInfo get repeatInfo => $_getN(7);
  @$pb.TagNumber(8)
  set repeatInfo(MeetingRepeatInfo v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasRepeatInfo() => $_has(7);
  @$pb.TagNumber(8)
  void clearRepeatInfo() => clearField(8);
  @$pb.TagNumber(8)
  MeetingRepeatInfo ensureRepeatInfo() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get canParticipantsEnableCamera => $_getBF(8);
  @$pb.TagNumber(9)
  set canParticipantsEnableCamera($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCanParticipantsEnableCamera() => $_has(8);
  @$pb.TagNumber(9)
  void clearCanParticipantsEnableCamera() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get canParticipantsUnmuteMicrophone => $_getBF(9);
  @$pb.TagNumber(10)
  set canParticipantsUnmuteMicrophone($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCanParticipantsUnmuteMicrophone() => $_has(9);
  @$pb.TagNumber(10)
  void clearCanParticipantsUnmuteMicrophone() => clearField(10);

  @$pb.TagNumber(11)
  $core.bool get canParticipantsShareScreen => $_getBF(10);
  @$pb.TagNumber(11)
  set canParticipantsShareScreen($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCanParticipantsShareScreen() => $_has(10);
  @$pb.TagNumber(11)
  void clearCanParticipantsShareScreen() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get disableCameraOnJoin => $_getBF(11);
  @$pb.TagNumber(12)
  set disableCameraOnJoin($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDisableCameraOnJoin() => $_has(11);
  @$pb.TagNumber(12)
  void clearDisableCameraOnJoin() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get disableMicrophoneOnJoin => $_getBF(12);
  @$pb.TagNumber(13)
  set disableMicrophoneOnJoin($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasDisableMicrophoneOnJoin() => $_has(12);
  @$pb.TagNumber(13)
  void clearDisableMicrophoneOnJoin() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get canParticipantJoinMeetingEarly => $_getBF(13);
  @$pb.TagNumber(14)
  set canParticipantJoinMeetingEarly($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCanParticipantJoinMeetingEarly() => $_has(13);
  @$pb.TagNumber(14)
  void clearCanParticipantJoinMeetingEarly() => clearField(14);

  @$pb.TagNumber(15)
  $core.bool get lockMeeting => $_getBF(14);
  @$pb.TagNumber(15)
  set lockMeeting($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasLockMeeting() => $_has(14);
  @$pb.TagNumber(15)
  void clearLockMeeting() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get audioEncouragement => $_getBF(15);
  @$pb.TagNumber(16)
  set audioEncouragement($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasAudioEncouragement() => $_has(15);
  @$pb.TagNumber(16)
  void clearAudioEncouragement() => clearField(16);

  @$pb.TagNumber(17)
  $core.bool get videoMirroring => $_getBF(16);
  @$pb.TagNumber(17)
  set videoMirroring($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasVideoMirroring() => $_has(16);
  @$pb.TagNumber(17)
  void clearVideoMirroring() => clearField(17);
}

/// Response after updating meeting settings.
class UpdateMeetingResp extends $pb.GeneratedMessage {
  factory UpdateMeetingResp() => create();
  UpdateMeetingResp._() : super();
  factory UpdateMeetingResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMeetingResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateMeetingResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMeetingResp clone() => UpdateMeetingResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMeetingResp copyWith(void Function(UpdateMeetingResp) updates) => super.copyWith((message) => updates(message as UpdateMeetingResp)) as UpdateMeetingResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMeetingResp create() => UpdateMeetingResp._();
  UpdateMeetingResp createEmptyInstance() => create();
  static $pb.PbList<UpdateMeetingResp> createRepeated() => $pb.PbList<UpdateMeetingResp>();
  @$core.pragma('dart2js:noInline')
  static UpdateMeetingResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMeetingResp>(create);
  static UpdateMeetingResp? _defaultInstance;
}

/// Personal meeting settings related to video and audio on entry.
class PersonalMeetingSetting extends $pb.GeneratedMessage {
  factory PersonalMeetingSetting({
    $core.bool? cameraOnEntry,
    $core.bool? microphoneOnEntry,
  }) {
    final $result = create();
    if (cameraOnEntry != null) {
      $result.cameraOnEntry = cameraOnEntry;
    }
    if (microphoneOnEntry != null) {
      $result.microphoneOnEntry = microphoneOnEntry;
    }
    return $result;
  }
  PersonalMeetingSetting._() : super();
  factory PersonalMeetingSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PersonalMeetingSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PersonalMeetingSetting', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'cameraOnEntry', protoName: 'cameraOnEntry')
    ..aOB(2, _omitFieldNames ? '' : 'microphoneOnEntry', protoName: 'microphoneOnEntry')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PersonalMeetingSetting clone() => PersonalMeetingSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PersonalMeetingSetting copyWith(void Function(PersonalMeetingSetting) updates) => super.copyWith((message) => updates(message as PersonalMeetingSetting)) as PersonalMeetingSetting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PersonalMeetingSetting create() => PersonalMeetingSetting._();
  PersonalMeetingSetting createEmptyInstance() => create();
  static $pb.PbList<PersonalMeetingSetting> createRepeated() => $pb.PbList<PersonalMeetingSetting>();
  @$core.pragma('dart2js:noInline')
  static PersonalMeetingSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PersonalMeetingSetting>(create);
  static PersonalMeetingSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get cameraOnEntry => $_getBF(0);
  @$pb.TagNumber(1)
  set cameraOnEntry($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCameraOnEntry() => $_has(0);
  @$pb.TagNumber(1)
  void clearCameraOnEntry() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get microphoneOnEntry => $_getBF(1);
  @$pb.TagNumber(2)
  set microphoneOnEntry($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMicrophoneOnEntry() => $_has(1);
  @$pb.TagNumber(2)
  void clearMicrophoneOnEntry() => clearField(2);
}

/// Request to get personal meeting settings.
class GetPersonalMeetingSettingsReq extends $pb.GeneratedMessage {
  factory GetPersonalMeetingSettingsReq({
    $core.String? meetingID,
    $core.String? userID,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    return $result;
  }
  GetPersonalMeetingSettingsReq._() : super();
  factory GetPersonalMeetingSettingsReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPersonalMeetingSettingsReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPersonalMeetingSettingsReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPersonalMeetingSettingsReq clone() => GetPersonalMeetingSettingsReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPersonalMeetingSettingsReq copyWith(void Function(GetPersonalMeetingSettingsReq) updates) => super.copyWith((message) => updates(message as GetPersonalMeetingSettingsReq)) as GetPersonalMeetingSettingsReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPersonalMeetingSettingsReq create() => GetPersonalMeetingSettingsReq._();
  GetPersonalMeetingSettingsReq createEmptyInstance() => create();
  static $pb.PbList<GetPersonalMeetingSettingsReq> createRepeated() => $pb.PbList<GetPersonalMeetingSettingsReq>();
  @$core.pragma('dart2js:noInline')
  static GetPersonalMeetingSettingsReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPersonalMeetingSettingsReq>(create);
  static GetPersonalMeetingSettingsReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);
}

/// Response with personal meeting settings.
class GetPersonalMeetingSettingsResp extends $pb.GeneratedMessage {
  factory GetPersonalMeetingSettingsResp({
    PersonalMeetingSetting? setting,
  }) {
    final $result = create();
    if (setting != null) {
      $result.setting = setting;
    }
    return $result;
  }
  GetPersonalMeetingSettingsResp._() : super();
  factory GetPersonalMeetingSettingsResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPersonalMeetingSettingsResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPersonalMeetingSettingsResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<PersonalMeetingSetting>(1, _omitFieldNames ? '' : 'setting', subBuilder: PersonalMeetingSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPersonalMeetingSettingsResp clone() => GetPersonalMeetingSettingsResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPersonalMeetingSettingsResp copyWith(void Function(GetPersonalMeetingSettingsResp) updates) => super.copyWith((message) => updates(message as GetPersonalMeetingSettingsResp)) as GetPersonalMeetingSettingsResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPersonalMeetingSettingsResp create() => GetPersonalMeetingSettingsResp._();
  GetPersonalMeetingSettingsResp createEmptyInstance() => create();
  static $pb.PbList<GetPersonalMeetingSettingsResp> createRepeated() => $pb.PbList<GetPersonalMeetingSettingsResp>();
  @$core.pragma('dart2js:noInline')
  static GetPersonalMeetingSettingsResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPersonalMeetingSettingsResp>(create);
  static GetPersonalMeetingSettingsResp? _defaultInstance;

  @$pb.TagNumber(1)
  PersonalMeetingSetting get setting => $_getN(0);
  @$pb.TagNumber(1)
  set setting(PersonalMeetingSetting v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSetting() => $_has(0);
  @$pb.TagNumber(1)
  void clearSetting() => clearField(1);
  @$pb.TagNumber(1)
  PersonalMeetingSetting ensureSetting() => $_ensure(0);
}

/// Request to set personal meeting settings.
class SetPersonalMeetingSettingsReq extends $pb.GeneratedMessage {
  factory SetPersonalMeetingSettingsReq({
    $core.String? meetingID,
    $core.String? userID,
    $core.bool? cameraOnEntry,
    $core.bool? microphoneOnEntry,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    if (cameraOnEntry != null) {
      $result.cameraOnEntry = cameraOnEntry;
    }
    if (microphoneOnEntry != null) {
      $result.microphoneOnEntry = microphoneOnEntry;
    }
    return $result;
  }
  SetPersonalMeetingSettingsReq._() : super();
  factory SetPersonalMeetingSettingsReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPersonalMeetingSettingsReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetPersonalMeetingSettingsReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOB(3, _omitFieldNames ? '' : 'cameraOnEntry', protoName: 'cameraOnEntry')
    ..aOB(4, _omitFieldNames ? '' : 'microphoneOnEntry', protoName: 'microphoneOnEntry')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPersonalMeetingSettingsReq clone() => SetPersonalMeetingSettingsReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPersonalMeetingSettingsReq copyWith(void Function(SetPersonalMeetingSettingsReq) updates) => super.copyWith((message) => updates(message as SetPersonalMeetingSettingsReq)) as SetPersonalMeetingSettingsReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetPersonalMeetingSettingsReq create() => SetPersonalMeetingSettingsReq._();
  SetPersonalMeetingSettingsReq createEmptyInstance() => create();
  static $pb.PbList<SetPersonalMeetingSettingsReq> createRepeated() => $pb.PbList<SetPersonalMeetingSettingsReq>();
  @$core.pragma('dart2js:noInline')
  static SetPersonalMeetingSettingsReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPersonalMeetingSettingsReq>(create);
  static SetPersonalMeetingSettingsReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get cameraOnEntry => $_getBF(2);
  @$pb.TagNumber(3)
  set cameraOnEntry($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCameraOnEntry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCameraOnEntry() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get microphoneOnEntry => $_getBF(3);
  @$pb.TagNumber(4)
  set microphoneOnEntry($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMicrophoneOnEntry() => $_has(3);
  @$pb.TagNumber(4)
  void clearMicrophoneOnEntry() => clearField(4);
}

/// Response after setting personal meeting settings.
class SetPersonalMeetingSettingsResp extends $pb.GeneratedMessage {
  factory SetPersonalMeetingSettingsResp() => create();
  SetPersonalMeetingSettingsResp._() : super();
  factory SetPersonalMeetingSettingsResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPersonalMeetingSettingsResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetPersonalMeetingSettingsResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPersonalMeetingSettingsResp clone() => SetPersonalMeetingSettingsResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPersonalMeetingSettingsResp copyWith(void Function(SetPersonalMeetingSettingsResp) updates) => super.copyWith((message) => updates(message as SetPersonalMeetingSettingsResp)) as SetPersonalMeetingSettingsResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetPersonalMeetingSettingsResp create() => SetPersonalMeetingSettingsResp._();
  SetPersonalMeetingSettingsResp createEmptyInstance() => create();
  static $pb.PbList<SetPersonalMeetingSettingsResp> createRepeated() => $pb.PbList<SetPersonalMeetingSettingsResp>();
  @$core.pragma('dart2js:noInline')
  static SetPersonalMeetingSettingsResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPersonalMeetingSettingsResp>(create);
  static SetPersonalMeetingSettingsResp? _defaultInstance;
}

class PersonalData extends $pb.GeneratedMessage {
  factory PersonalData({
    $core.String? userID,
    PersonalMeetingSetting? personalSetting,
    PersonalMeetingSetting? limitSetting,
  }) {
    final $result = create();
    if (userID != null) {
      $result.userID = userID;
    }
    if (personalSetting != null) {
      $result.personalSetting = personalSetting;
    }
    if (limitSetting != null) {
      $result.limitSetting = limitSetting;
    }
    return $result;
  }
  PersonalData._() : super();
  factory PersonalData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PersonalData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PersonalData', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOM<PersonalMeetingSetting>(2, _omitFieldNames ? '' : 'personalSetting', protoName: 'personalSetting', subBuilder: PersonalMeetingSetting.create)
    ..aOM<PersonalMeetingSetting>(3, _omitFieldNames ? '' : 'limitSetting', protoName: 'limitSetting', subBuilder: PersonalMeetingSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PersonalData clone() => PersonalData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PersonalData copyWith(void Function(PersonalData) updates) => super.copyWith((message) => updates(message as PersonalData)) as PersonalData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PersonalData create() => PersonalData._();
  PersonalData createEmptyInstance() => create();
  static $pb.PbList<PersonalData> createRepeated() => $pb.PbList<PersonalData>();
  @$core.pragma('dart2js:noInline')
  static PersonalData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PersonalData>(create);
  static PersonalData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userID => $_getSZ(0);
  @$pb.TagNumber(1)
  set userID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserID() => clearField(1);

  @$pb.TagNumber(2)
  PersonalMeetingSetting get personalSetting => $_getN(1);
  @$pb.TagNumber(2)
  set personalSetting(PersonalMeetingSetting v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPersonalSetting() => $_has(1);
  @$pb.TagNumber(2)
  void clearPersonalSetting() => clearField(2);
  @$pb.TagNumber(2)
  PersonalMeetingSetting ensurePersonalSetting() => $_ensure(1);

  /// limitSetting is that host user limit this user's stream operation
  @$pb.TagNumber(3)
  PersonalMeetingSetting get limitSetting => $_getN(2);
  @$pb.TagNumber(3)
  set limitSetting(PersonalMeetingSetting v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimitSetting() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimitSetting() => clearField(3);
  @$pb.TagNumber(3)
  PersonalMeetingSetting ensureLimitSetting() => $_ensure(2);
}

/// Metadata about a meeting, primarily used for encapsulating meeting details.
class MeetingMetadata extends $pb.GeneratedMessage {
  factory MeetingMetadata({
    MeetingInfoSetting? detail,
    $core.Iterable<PersonalData>? personalData,
  }) {
    final $result = create();
    if (detail != null) {
      $result.detail = detail;
    }
    if (personalData != null) {
      $result.personalData.addAll(personalData);
    }
    return $result;
  }
  MeetingMetadata._() : super();
  factory MeetingMetadata.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeetingMetadata.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MeetingMetadata', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOM<MeetingInfoSetting>(1, _omitFieldNames ? '' : 'detail', subBuilder: MeetingInfoSetting.create)
    ..pc<PersonalData>(2, _omitFieldNames ? '' : 'personalData', $pb.PbFieldType.PM, protoName: 'personalData', subBuilder: PersonalData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MeetingMetadata clone() => MeetingMetadata()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MeetingMetadata copyWith(void Function(MeetingMetadata) updates) => super.copyWith((message) => updates(message as MeetingMetadata)) as MeetingMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MeetingMetadata create() => MeetingMetadata._();
  MeetingMetadata createEmptyInstance() => create();
  static $pb.PbList<MeetingMetadata> createRepeated() => $pb.PbList<MeetingMetadata>();
  @$core.pragma('dart2js:noInline')
  static MeetingMetadata getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MeetingMetadata>(create);
  static MeetingMetadata? _defaultInstance;

  @$pb.TagNumber(1)
  MeetingInfoSetting get detail => $_getN(0);
  @$pb.TagNumber(1)
  set detail(MeetingInfoSetting v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDetail() => $_has(0);
  @$pb.TagNumber(1)
  void clearDetail() => clearField(1);
  @$pb.TagNumber(1)
  MeetingInfoSetting ensureDetail() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<PersonalData> get personalData => $_getList(1);
}

/// operate room all stream related to video and audio on entry.
class OperateRoomAllStreamReq extends $pb.GeneratedMessage {
  factory OperateRoomAllStreamReq({
    $core.String? meetingID,
    $core.String? operatorUserID,
    $core.bool? cameraOnEntry,
    $core.bool? microphoneOnEntry,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (operatorUserID != null) {
      $result.operatorUserID = operatorUserID;
    }
    if (cameraOnEntry != null) {
      $result.cameraOnEntry = cameraOnEntry;
    }
    if (microphoneOnEntry != null) {
      $result.microphoneOnEntry = microphoneOnEntry;
    }
    return $result;
  }
  OperateRoomAllStreamReq._() : super();
  factory OperateRoomAllStreamReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OperateRoomAllStreamReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OperateRoomAllStreamReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'operatorUserID', protoName: 'operatorUserID')
    ..aOB(3, _omitFieldNames ? '' : 'cameraOnEntry', protoName: 'cameraOnEntry')
    ..aOB(4, _omitFieldNames ? '' : 'microphoneOnEntry', protoName: 'microphoneOnEntry')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OperateRoomAllStreamReq clone() => OperateRoomAllStreamReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OperateRoomAllStreamReq copyWith(void Function(OperateRoomAllStreamReq) updates) => super.copyWith((message) => updates(message as OperateRoomAllStreamReq)) as OperateRoomAllStreamReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OperateRoomAllStreamReq create() => OperateRoomAllStreamReq._();
  OperateRoomAllStreamReq createEmptyInstance() => create();
  static $pb.PbList<OperateRoomAllStreamReq> createRepeated() => $pb.PbList<OperateRoomAllStreamReq>();
  @$core.pragma('dart2js:noInline')
  static OperateRoomAllStreamReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OperateRoomAllStreamReq>(create);
  static OperateRoomAllStreamReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get operatorUserID => $_getSZ(1);
  @$pb.TagNumber(2)
  set operatorUserID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOperatorUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperatorUserID() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get cameraOnEntry => $_getBF(2);
  @$pb.TagNumber(3)
  set cameraOnEntry($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCameraOnEntry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCameraOnEntry() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get microphoneOnEntry => $_getBF(3);
  @$pb.TagNumber(4)
  set microphoneOnEntry($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMicrophoneOnEntry() => $_has(3);
  @$pb.TagNumber(4)
  void clearMicrophoneOnEntry() => clearField(4);
}

/// Response with operate room all stream.
class OperateRoomAllStreamResp extends $pb.GeneratedMessage {
  factory OperateRoomAllStreamResp({
    $core.Iterable<$core.String>? streamNotExistUserIDList,
    $core.Iterable<$core.String>? failedUserIDList,
  }) {
    final $result = create();
    if (streamNotExistUserIDList != null) {
      $result.streamNotExistUserIDList.addAll(streamNotExistUserIDList);
    }
    if (failedUserIDList != null) {
      $result.failedUserIDList.addAll(failedUserIDList);
    }
    return $result;
  }
  OperateRoomAllStreamResp._() : super();
  factory OperateRoomAllStreamResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OperateRoomAllStreamResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OperateRoomAllStreamResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'streamNotExistUserIDList', protoName: 'streamNotExistUserIDList')
    ..pPS(2, _omitFieldNames ? '' : 'failedUserIDList', protoName: 'failedUserIDList')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OperateRoomAllStreamResp clone() => OperateRoomAllStreamResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OperateRoomAllStreamResp copyWith(void Function(OperateRoomAllStreamResp) updates) => super.copyWith((message) => updates(message as OperateRoomAllStreamResp)) as OperateRoomAllStreamResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OperateRoomAllStreamResp create() => OperateRoomAllStreamResp._();
  OperateRoomAllStreamResp createEmptyInstance() => create();
  static $pb.PbList<OperateRoomAllStreamResp> createRepeated() => $pb.PbList<OperateRoomAllStreamResp>();
  @$core.pragma('dart2js:noInline')
  static OperateRoomAllStreamResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OperateRoomAllStreamResp>(create);
  static OperateRoomAllStreamResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get streamNotExistUserIDList => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get failedUserIDList => $_getList(1);
}

class RemoveMeetingParticipantsReq extends $pb.GeneratedMessage {
  factory RemoveMeetingParticipantsReq({
    $core.String? meetingID,
    $core.String? userID,
    $core.Iterable<$core.String>? participantUserIDs,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    if (participantUserIDs != null) {
      $result.participantUserIDs.addAll(participantUserIDs);
    }
    return $result;
  }
  RemoveMeetingParticipantsReq._() : super();
  factory RemoveMeetingParticipantsReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveMeetingParticipantsReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveMeetingParticipantsReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..pPS(3, _omitFieldNames ? '' : 'participantUserIDs', protoName: 'participantUserIDs')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveMeetingParticipantsReq clone() => RemoveMeetingParticipantsReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveMeetingParticipantsReq copyWith(void Function(RemoveMeetingParticipantsReq) updates) => super.copyWith((message) => updates(message as RemoveMeetingParticipantsReq)) as RemoveMeetingParticipantsReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveMeetingParticipantsReq create() => RemoveMeetingParticipantsReq._();
  RemoveMeetingParticipantsReq createEmptyInstance() => create();
  static $pb.PbList<RemoveMeetingParticipantsReq> createRepeated() => $pb.PbList<RemoveMeetingParticipantsReq>();
  @$core.pragma('dart2js:noInline')
  static RemoveMeetingParticipantsReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveMeetingParticipantsReq>(create);
  static RemoveMeetingParticipantsReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get participantUserIDs => $_getList(2);
}

class RemoveMeetingParticipantsResp extends $pb.GeneratedMessage {
  factory RemoveMeetingParticipantsResp({
    $core.Iterable<$core.String>? successUserIDList,
    $core.Iterable<$core.String>? failedUserIDList,
  }) {
    final $result = create();
    if (successUserIDList != null) {
      $result.successUserIDList.addAll(successUserIDList);
    }
    if (failedUserIDList != null) {
      $result.failedUserIDList.addAll(failedUserIDList);
    }
    return $result;
  }
  RemoveMeetingParticipantsResp._() : super();
  factory RemoveMeetingParticipantsResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveMeetingParticipantsResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveMeetingParticipantsResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'successUserIDList', protoName: 'successUserIDList')
    ..pPS(2, _omitFieldNames ? '' : 'failedUserIDList', protoName: 'failedUserIDList')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveMeetingParticipantsResp clone() => RemoveMeetingParticipantsResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveMeetingParticipantsResp copyWith(void Function(RemoveMeetingParticipantsResp) updates) => super.copyWith((message) => updates(message as RemoveMeetingParticipantsResp)) as RemoveMeetingParticipantsResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveMeetingParticipantsResp create() => RemoveMeetingParticipantsResp._();
  RemoveMeetingParticipantsResp createEmptyInstance() => create();
  static $pb.PbList<RemoveMeetingParticipantsResp> createRepeated() => $pb.PbList<RemoveMeetingParticipantsResp>();
  @$core.pragma('dart2js:noInline')
  static RemoveMeetingParticipantsResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveMeetingParticipantsResp>(create);
  static RemoveMeetingParticipantsResp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get successUserIDList => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get failedUserIDList => $_getList(1);
}

class SetMeetingHostInfoReq extends $pb.GeneratedMessage {
  factory SetMeetingHostInfoReq({
    $core.String? meetingID,
    $core.String? userID,
    $core.String? hostUserID,
    $core.Iterable<$core.String>? coHostUserIDs,
  }) {
    final $result = create();
    if (meetingID != null) {
      $result.meetingID = meetingID;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    if (hostUserID != null) {
      $result.hostUserID = hostUserID;
    }
    if (coHostUserIDs != null) {
      $result.coHostUserIDs.addAll(coHostUserIDs);
    }
    return $result;
  }
  SetMeetingHostInfoReq._() : super();
  factory SetMeetingHostInfoReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetMeetingHostInfoReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetMeetingHostInfoReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'meetingID', protoName: 'meetingID')
    ..aOS(2, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOS(3, _omitFieldNames ? '' : 'hostUserID', protoName: 'hostUserID')
    ..pPS(4, _omitFieldNames ? '' : 'coHostUserIDs', protoName: 'coHostUserIDs')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetMeetingHostInfoReq clone() => SetMeetingHostInfoReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetMeetingHostInfoReq copyWith(void Function(SetMeetingHostInfoReq) updates) => super.copyWith((message) => updates(message as SetMeetingHostInfoReq)) as SetMeetingHostInfoReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetMeetingHostInfoReq create() => SetMeetingHostInfoReq._();
  SetMeetingHostInfoReq createEmptyInstance() => create();
  static $pb.PbList<SetMeetingHostInfoReq> createRepeated() => $pb.PbList<SetMeetingHostInfoReq>();
  @$core.pragma('dart2js:noInline')
  static SetMeetingHostInfoReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetMeetingHostInfoReq>(create);
  static SetMeetingHostInfoReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get meetingID => $_getSZ(0);
  @$pb.TagNumber(1)
  set meetingID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMeetingID() => $_has(0);
  @$pb.TagNumber(1)
  void clearMeetingID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(2)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get hostUserID => $_getSZ(2);
  @$pb.TagNumber(3)
  set hostUserID($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHostUserID() => $_has(2);
  @$pb.TagNumber(3)
  void clearHostUserID() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get coHostUserIDs => $_getList(3);
}

class SetMeetingHostInfoResp extends $pb.GeneratedMessage {
  factory SetMeetingHostInfoResp() => create();
  SetMeetingHostInfoResp._() : super();
  factory SetMeetingHostInfoResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetMeetingHostInfoResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetMeetingHostInfoResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetMeetingHostInfoResp clone() => SetMeetingHostInfoResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetMeetingHostInfoResp copyWith(void Function(SetMeetingHostInfoResp) updates) => super.copyWith((message) => updates(message as SetMeetingHostInfoResp)) as SetMeetingHostInfoResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetMeetingHostInfoResp create() => SetMeetingHostInfoResp._();
  SetMeetingHostInfoResp createEmptyInstance() => create();
  static $pb.PbList<SetMeetingHostInfoResp> createRepeated() => $pb.PbList<SetMeetingHostInfoResp>();
  @$core.pragma('dart2js:noInline')
  static SetMeetingHostInfoResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetMeetingHostInfoResp>(create);
  static SetMeetingHostInfoResp? _defaultInstance;
}

enum NotifyMeetingData_MessageType {
  streamOperateData, 
  meetingHostData, 
  notSet
}

class NotifyMeetingData extends $pb.GeneratedMessage {
  factory NotifyMeetingData({
    $core.String? operatorUserID,
    StreamOperateData? streamOperateData,
    MeetingHostData? meetingHostData,
  }) {
    final $result = create();
    if (operatorUserID != null) {
      $result.operatorUserID = operatorUserID;
    }
    if (streamOperateData != null) {
      $result.streamOperateData = streamOperateData;
    }
    if (meetingHostData != null) {
      $result.meetingHostData = meetingHostData;
    }
    return $result;
  }
  NotifyMeetingData._() : super();
  factory NotifyMeetingData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotifyMeetingData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, NotifyMeetingData_MessageType> _NotifyMeetingData_MessageTypeByTag = {
    2 : NotifyMeetingData_MessageType.streamOperateData,
    3 : NotifyMeetingData_MessageType.meetingHostData,
    0 : NotifyMeetingData_MessageType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NotifyMeetingData', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'operatorUserID', protoName: 'operatorUserID')
    ..aOM<StreamOperateData>(2, _omitFieldNames ? '' : 'streamOperateData', protoName: 'streamOperateData', subBuilder: StreamOperateData.create)
    ..aOM<MeetingHostData>(3, _omitFieldNames ? '' : 'meetingHostData', protoName: 'meetingHostData', subBuilder: MeetingHostData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NotifyMeetingData clone() => NotifyMeetingData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NotifyMeetingData copyWith(void Function(NotifyMeetingData) updates) => super.copyWith((message) => updates(message as NotifyMeetingData)) as NotifyMeetingData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotifyMeetingData create() => NotifyMeetingData._();
  NotifyMeetingData createEmptyInstance() => create();
  static $pb.PbList<NotifyMeetingData> createRepeated() => $pb.PbList<NotifyMeetingData>();
  @$core.pragma('dart2js:noInline')
  static NotifyMeetingData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotifyMeetingData>(create);
  static NotifyMeetingData? _defaultInstance;

  NotifyMeetingData_MessageType whichMessageType() => _NotifyMeetingData_MessageTypeByTag[$_whichOneof(0)]!;
  void clearMessageType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get operatorUserID => $_getSZ(0);
  @$pb.TagNumber(1)
  set operatorUserID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOperatorUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearOperatorUserID() => clearField(1);

  @$pb.TagNumber(2)
  StreamOperateData get streamOperateData => $_getN(1);
  @$pb.TagNumber(2)
  set streamOperateData(StreamOperateData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStreamOperateData() => $_has(1);
  @$pb.TagNumber(2)
  void clearStreamOperateData() => clearField(2);
  @$pb.TagNumber(2)
  StreamOperateData ensureStreamOperateData() => $_ensure(1);

  @$pb.TagNumber(3)
  MeetingHostData get meetingHostData => $_getN(2);
  @$pb.TagNumber(3)
  set meetingHostData(MeetingHostData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMeetingHostData() => $_has(2);
  @$pb.TagNumber(3)
  void clearMeetingHostData() => clearField(3);
  @$pb.TagNumber(3)
  MeetingHostData ensureMeetingHostData() => $_ensure(2);
}

class StreamOperateData extends $pb.GeneratedMessage {
  factory StreamOperateData({
    $core.Iterable<UserOperationData>? operation,
  }) {
    final $result = create();
    if (operation != null) {
      $result.operation.addAll(operation);
    }
    return $result;
  }
  StreamOperateData._() : super();
  factory StreamOperateData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StreamOperateData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamOperateData', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..pc<UserOperationData>(1, _omitFieldNames ? '' : 'operation', $pb.PbFieldType.PM, subBuilder: UserOperationData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StreamOperateData clone() => StreamOperateData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StreamOperateData copyWith(void Function(StreamOperateData) updates) => super.copyWith((message) => updates(message as StreamOperateData)) as StreamOperateData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamOperateData create() => StreamOperateData._();
  StreamOperateData createEmptyInstance() => create();
  static $pb.PbList<StreamOperateData> createRepeated() => $pb.PbList<StreamOperateData>();
  @$core.pragma('dart2js:noInline')
  static StreamOperateData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamOperateData>(create);
  static StreamOperateData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserOperationData> get operation => $_getList(0);
}

class UserOperationData extends $pb.GeneratedMessage {
  factory UserOperationData({
    $core.String? userID,
    $core.bool? cameraOnEntry,
    $core.bool? microphoneOnEntry,
  }) {
    final $result = create();
    if (userID != null) {
      $result.userID = userID;
    }
    if (cameraOnEntry != null) {
      $result.cameraOnEntry = cameraOnEntry;
    }
    if (microphoneOnEntry != null) {
      $result.microphoneOnEntry = microphoneOnEntry;
    }
    return $result;
  }
  UserOperationData._() : super();
  factory UserOperationData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserOperationData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserOperationData', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOB(2, _omitFieldNames ? '' : 'cameraOnEntry', protoName: 'cameraOnEntry')
    ..aOB(3, _omitFieldNames ? '' : 'microphoneOnEntry', protoName: 'microphoneOnEntry')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserOperationData clone() => UserOperationData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserOperationData copyWith(void Function(UserOperationData) updates) => super.copyWith((message) => updates(message as UserOperationData)) as UserOperationData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserOperationData create() => UserOperationData._();
  UserOperationData createEmptyInstance() => create();
  static $pb.PbList<UserOperationData> createRepeated() => $pb.PbList<UserOperationData>();
  @$core.pragma('dart2js:noInline')
  static UserOperationData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserOperationData>(create);
  static UserOperationData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userID => $_getSZ(0);
  @$pb.TagNumber(1)
  set userID($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserID() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserID() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get cameraOnEntry => $_getBF(1);
  @$pb.TagNumber(2)
  set cameraOnEntry($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCameraOnEntry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCameraOnEntry() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get microphoneOnEntry => $_getBF(2);
  @$pb.TagNumber(3)
  set microphoneOnEntry($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMicrophoneOnEntry() => $_has(2);
  @$pb.TagNumber(3)
  void clearMicrophoneOnEntry() => clearField(3);
}

class MeetingHostData extends $pb.GeneratedMessage {
  factory MeetingHostData({
    $core.String? operatorNickname,
    $core.String? userID,
    $core.String? hostType,
  }) {
    final $result = create();
    if (operatorNickname != null) {
      $result.operatorNickname = operatorNickname;
    }
    if (userID != null) {
      $result.userID = userID;
    }
    if (hostType != null) {
      $result.hostType = hostType;
    }
    return $result;
  }
  MeetingHostData._() : super();
  factory MeetingHostData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MeetingHostData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MeetingHostData', package: const $pb.PackageName(_omitMessageNames ? '' : 'openmeeting.meeting'), createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'operatorNickname', protoName: 'operatorNickname')
    ..aOS(3, _omitFieldNames ? '' : 'userID', protoName: 'userID')
    ..aOS(4, _omitFieldNames ? '' : 'hostType', protoName: 'hostType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MeetingHostData clone() => MeetingHostData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MeetingHostData copyWith(void Function(MeetingHostData) updates) => super.copyWith((message) => updates(message as MeetingHostData)) as MeetingHostData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MeetingHostData create() => MeetingHostData._();
  MeetingHostData createEmptyInstance() => create();
  static $pb.PbList<MeetingHostData> createRepeated() => $pb.PbList<MeetingHostData>();
  @$core.pragma('dart2js:noInline')
  static MeetingHostData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MeetingHostData>(create);
  static MeetingHostData? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get operatorNickname => $_getSZ(0);
  @$pb.TagNumber(2)
  set operatorNickname($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasOperatorNickname() => $_has(0);
  @$pb.TagNumber(2)
  void clearOperatorNickname() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userID => $_getSZ(1);
  @$pb.TagNumber(3)
  set userID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserID() => $_has(1);
  @$pb.TagNumber(3)
  void clearUserID() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get hostType => $_getSZ(2);
  @$pb.TagNumber(4)
  set hostType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasHostType() => $_has(2);
  @$pb.TagNumber(4)
  void clearHostType() => clearField(4);
}

class MeetingServiceApi {
  $pb.RpcClient _client;
  MeetingServiceApi(this._client);

  $async.Future<BookMeetingResp> bookMeeting($pb.ClientContext? ctx, BookMeetingReq request) =>
    _client.invoke<BookMeetingResp>(ctx, 'MeetingService', 'BookMeeting', request, BookMeetingResp())
  ;
  $async.Future<CreateImmediateMeetingResp> createImmediateMeeting($pb.ClientContext? ctx, CreateImmediateMeetingReq request) =>
    _client.invoke<CreateImmediateMeetingResp>(ctx, 'MeetingService', 'CreateImmediateMeeting', request, CreateImmediateMeetingResp())
  ;
  $async.Future<JoinMeetingResp> joinMeeting($pb.ClientContext? ctx, JoinMeetingReq request) =>
    _client.invoke<JoinMeetingResp>(ctx, 'MeetingService', 'JoinMeeting', request, JoinMeetingResp())
  ;
  $async.Future<GetMeetingTokenResp> getMeetingToken($pb.ClientContext? ctx, GetMeetingTokenReq request) =>
    _client.invoke<GetMeetingTokenResp>(ctx, 'MeetingService', 'GetMeetingToken', request, GetMeetingTokenResp())
  ;
  $async.Future<LeaveMeetingResp> leaveMeeting($pb.ClientContext? ctx, LeaveMeetingReq request) =>
    _client.invoke<LeaveMeetingResp>(ctx, 'MeetingService', 'LeaveMeeting', request, LeaveMeetingResp())
  ;
  $async.Future<EndMeetingResp> endMeeting($pb.ClientContext? ctx, EndMeetingReq request) =>
    _client.invoke<EndMeetingResp>(ctx, 'MeetingService', 'EndMeeting', request, EndMeetingResp())
  ;
  $async.Future<GetMeetingsResp> getMeetings($pb.ClientContext? ctx, GetMeetingsReq request) =>
    _client.invoke<GetMeetingsResp>(ctx, 'MeetingService', 'GetMeetings', request, GetMeetingsResp())
  ;
  $async.Future<GetMeetingResp> getMeeting($pb.ClientContext? ctx, GetMeetingReq request) =>
    _client.invoke<GetMeetingResp>(ctx, 'MeetingService', 'GetMeeting', request, GetMeetingResp())
  ;
  $async.Future<UpdateMeetingResp> updateMeeting($pb.ClientContext? ctx, UpdateMeetingRequest request) =>
    _client.invoke<UpdateMeetingResp>(ctx, 'MeetingService', 'UpdateMeeting', request, UpdateMeetingResp())
  ;
  $async.Future<GetPersonalMeetingSettingsResp> getPersonalMeetingSettings($pb.ClientContext? ctx, GetPersonalMeetingSettingsReq request) =>
    _client.invoke<GetPersonalMeetingSettingsResp>(ctx, 'MeetingService', 'GetPersonalMeetingSettings', request, GetPersonalMeetingSettingsResp())
  ;
  $async.Future<SetPersonalMeetingSettingsResp> setPersonalMeetingSettings($pb.ClientContext? ctx, SetPersonalMeetingSettingsReq request) =>
    _client.invoke<SetPersonalMeetingSettingsResp>(ctx, 'MeetingService', 'SetPersonalMeetingSettings', request, SetPersonalMeetingSettingsResp())
  ;
  $async.Future<OperateRoomAllStreamResp> operateRoomAllStream($pb.ClientContext? ctx, OperateRoomAllStreamReq request) =>
    _client.invoke<OperateRoomAllStreamResp>(ctx, 'MeetingService', 'OperateRoomAllStream', request, OperateRoomAllStreamResp())
  ;
  $async.Future<ModifyMeetingParticipantNickNameResp> modifyMeetingParticipantNickName($pb.ClientContext? ctx, ModifyMeetingParticipantNickNameReq request) =>
    _client.invoke<ModifyMeetingParticipantNickNameResp>(ctx, 'MeetingService', 'ModifyMeetingParticipantNickName', request, ModifyMeetingParticipantNickNameResp())
  ;
  $async.Future<RemoveMeetingParticipantsResp> removeParticipants($pb.ClientContext? ctx, RemoveMeetingParticipantsReq request) =>
    _client.invoke<RemoveMeetingParticipantsResp>(ctx, 'MeetingService', 'RemoveParticipants', request, RemoveMeetingParticipantsResp())
  ;
  $async.Future<SetMeetingHostInfoResp> setMeetingHostInfo($pb.ClientContext? ctx, SetMeetingHostInfoReq request) =>
    _client.invoke<SetMeetingHostInfoResp>(ctx, 'MeetingService', 'SetMeetingHostInfo', request, SetMeetingHostInfoResp())
  ;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
