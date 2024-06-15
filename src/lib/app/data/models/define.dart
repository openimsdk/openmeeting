import 'dart:io';

import 'package:openim_common/openim_common.dart';

const kAllDisplayValue = -1;
const int kMainWindowId = 0;
const int kInvalidWindowId = -1;

enum WindowEvent {
  hide,
  show,
  newRoom,
  newSetting,
  activeSession,
  activeDisplaySession,
}

extension WindowEventExt on WindowEvent {
  String get rawValue {
    switch (this) {
      case WindowEvent.hide:
        return 'hide';
      case WindowEvent.show:
        return 'show';
      case WindowEvent.newRoom:
        return 'new_remote_desktop';
      case WindowEvent.newSetting:
        return 'new_setting';
      case WindowEvent.activeSession:
        return 'active_session';
      case WindowEvent.activeDisplaySession:
        return 'active_display_session';
    }
  }
}

int windowsBuildNumber = 0;

/// The windows targets in the publish time order.
enum WindowsTarget {
  naw, // not a windows target
  xp,
  vista,
  w7,
  w8,
  w8_1,
  w10,
  w11
}

/// A convenient method to transform a build number to the corresponding windows version.
extension WindowsTargetExt on int {
  WindowsTarget get windowsVersion => getWindowsTarget(this);
}

bool get useCompatibleUiMode => Platform.isWindows && const [WindowsTarget.w7].contains(windowsBuildNumber.windowsVersion);

/// return a human readable windows version
WindowsTarget getWindowsTarget(int buildNumber) {
  if (!Platform.isWindows) {
    return WindowsTarget.naw;
  }
  if (buildNumber >= 22000) {
    return WindowsTarget.w11;
  } else if (buildNumber >= 10240) {
    return WindowsTarget.w10;
  } else if (buildNumber >= 9600) {
    return WindowsTarget.w8_1;
  } else if (buildNumber >= 9200) {
    return WindowsTarget.w8;
  } else if (buildNumber >= 7601) {
    return WindowsTarget.w7;
  } else if (buildNumber >= 6002) {
    return WindowsTarget.vista;
  } else {
    // minimum support
    return WindowsTarget.xp;
  }
}

/// must keep the order
// ignore: constant_identifier_names
enum WindowType { main, room, setting, unknown }

extension IntExt on int {
  WindowType get windowType {
    switch (this) {
      case 0:
        return WindowType.main;
      case 1:
        return WindowType.room;
      case 2:
        return WindowType.setting;
      default:
        return WindowType.unknown;
    }
  }
}

extension WindowTypeExt on WindowType {
  int get rawValue {
    switch (this) {
      case WindowType.main:
        return 0;
      case WindowType.room:
        return 1;
      case WindowType.setting:
        return 2;
      default:
        return -1;
    }
  }

  String get title {
    switch (this) {
      case WindowType.main:
        return 'main';
      case WindowType.room:
        return 'room';
      case WindowType.setting:
        return 'setting';
      default:
        return 'unknown';
    }
  }
}

enum OperationType { participants, roomSettings, leave, end, setting, onlyClose } // case setting for app setting

enum OperationParticipantType {
  pined,
  focus,
  camera,
  microphone,
  nickname,
  kickoff,
  muteAll,
  unMuteAll,
}

enum RoomSetting { allowParticipantUnMute, allowParticipantVideo, onlyHostCanShareScreen, defaultMuted }

enum RepeatType { none, daily, weekday, weekly, biweekly, monthly, custom }

extension RepeatTypeExt on RepeatType {
  int get rawValue {
    switch (this) {
      case RepeatType.none:
        return 0;
      case RepeatType.daily:
        return 1;
      case RepeatType.weekday:
        return 2;
      case RepeatType.weekly:
        return 3;
      case RepeatType.biweekly:
        return 4;
      case RepeatType.monthly:
        return 5;
      case RepeatType.custom:
        return 6;
    }
  }

  String get title {
    switch (this) {
      case RepeatType.none:
        return StrRes.noRepeat;
      case RepeatType.daily:
        return StrRes.daily;
      case RepeatType.weekday:
        return StrRes.weekday;
      case RepeatType.weekly:
        return StrRes.weekly;
      case RepeatType.biweekly:
        return StrRes.biweekly;
      case RepeatType.monthly:
        return StrRes.monthly;
      case RepeatType.custom:
        return StrRes.custom;
    }
  }
}

extension RepeatTypeToIntExt on int {
  RepeatType get repeatType {
    switch (this) {
      case 0:
        return RepeatType.none;
      case 1:
        return RepeatType.daily;
      case 2:
        return RepeatType.weekday;
      case 3:
        return RepeatType.weekly;
      case 4:
        return RepeatType.biweekly;
      case 5:
        return RepeatType.monthly;
      case 6:
        return RepeatType.custom;
      default:
        return RepeatType.none;
    }
  }
}

enum MeetingStatus {
  scheduled,
  inProgress,
  completed,
}

extension MeetingStatusExt on MeetingStatus {
  String get rawValue {
    switch (this) {
      case MeetingStatus.scheduled:
        return 'Scheduled';
      case MeetingStatus.inProgress:
        return 'In-Progress';
      case MeetingStatus.completed:
        return 'Completed';
    }
  }

  static MeetingStatus fromString(String str) {
    switch (str) {
      case 'Scheduled':
        return MeetingStatus.scheduled;
      case 'In-Progress':
        return MeetingStatus.inProgress;
      case 'Completed':
        return MeetingStatus.completed;
      default:
        throw Exception('Invalid MeetingStatus: $str');
    }
  }
}
