import 'dart:io';

import 'package:openim_common/openim_common.dart';

const int kMainWindowId = 0;
const int kInvalidWindowId = -1;

enum WindowEvent { hide, show, newRoom, newSetting, activeSession, activeDisplaySession, sendMessage }

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
      case WindowEvent.sendMessage:
        return 'send_message';
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

bool get useCompatibleUiMode =>
    Platform.isWindows && const [WindowsTarget.w7].contains(windowsBuildNumber.windowsVersion);

const double kTabBarHeight = 28.0;

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

enum  OperationType { participants, roomSettings, leave, end, setting, onlyClose } // case setting for app setting

enum OperationParticipantType {
  pined,
  focus,
  camera,
  microphone,
  nickname,
  setHost,
  kickoff,
  muteAll,
}

enum RoomSetting { allowParticipantUnMute, allowParticipantVideo, onlyHostCanShareScreen, defaultMuted }

enum RepeatType { none, daily, weekday, weekly, biweekly, monthly, custom }

extension RepeatTypeExt on RepeatType {
  String get rawValue {
    switch (this) {
      case RepeatType.none:
        return 'None';
      case RepeatType.daily:
        return 'Daily';
      case RepeatType.weekday:
        return 'Weekday';
      case RepeatType.weekly:
        return 'Weekly';
      case RepeatType.biweekly:
        return 'Biweekly';
      case RepeatType.monthly:
        return 'Monthly';
      case RepeatType.custom:
        return 'Custom';
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

  static RepeatType fromString(String value) {
    switch (value) {
      case 'None':
        return RepeatType.none;
      case 'Daily':
        return RepeatType.daily;
      case 'Weekday':
        return RepeatType.weekday;
      case 'Weekly':
        return RepeatType.weekly;
      case 'Biweekly':
        return RepeatType.biweekly;
      case 'Monthly':
        return RepeatType.monthly;
      case 'Custom':
        return RepeatType.custom;
      default:
        return RepeatType.none;
    }
  }
}

enum UnitType {
  day,
  week,
  month,
}

extension UnitTypeExt on UnitType {
  String get title {
    switch (this) {
      case UnitType.day:
        return StrRes.day;
      case UnitType.week:
        return StrRes.week;
      case UnitType.month:
        return StrRes.month;
    }
  }

  String get rawValue {
    switch (this) {
      case UnitType.day:
        return 'Day';
      case UnitType.week:
        return 'Week';
      case UnitType.month:
        return 'Month';
    }
  }

  static UnitType fromString(String value) {
    switch (value) {
      case 'Day':
        return UnitType.day;
      case 'Week':
        return UnitType.week;
      case 'Month':
        return UnitType.month;
      default:
        return UnitType.day;
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

enum Weekdays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension WeekdaysExt on Weekdays {
  String get title {
    switch (this) {
      case Weekdays.monday:
        return StrRes.monday;
      case Weekdays.tuesday:
        return StrRes.tuesday;
      case Weekdays.wednesday:
        return StrRes.wednesday;
      case Weekdays.thursday:
        return StrRes.thursday;
      case Weekdays.friday:
        return StrRes.friday;
      case Weekdays.saturday:
        return StrRes.saturday;
      case Weekdays.sunday:
        return StrRes.sunday;
    }
  }

  String get rawValue {
    switch (this) {
      case Weekdays.monday:
        return 'Monday';
      case Weekdays.tuesday:
        return 'Tuesday';
      case Weekdays.wednesday:
        return 'Wednesday';
      case Weekdays.thursday:
        return 'Thursday';
      case Weekdays.friday:
        return 'Friday';
      case Weekdays.saturday:
        return 'Saturday';
      case Weekdays.sunday:
        return 'Sunday';
    }
  }

  static Weekdays fromString(String str) {
    switch (str) {
      case 'Monday':
        return Weekdays.monday;
      case 'Tuesday':
        return Weekdays.tuesday;
      case 'Wednesday':
        return Weekdays.wednesday;
      case 'Thursday':
        return Weekdays.thursday;
      case 'Friday':
        return Weekdays.friday;
      case 'Saturday':
        return Weekdays.saturday;
      case 'Sunday':
        return Weekdays.sunday;
      default:
        throw Exception('Invalid Weekdays: $str');
    }
  }
}

enum HostType {
  host,
  coHost,
}

extension HostTypeExt on HostType {
  static HostType fromString(String str) {
    switch (str) {
      case 'Host':
        return HostType.host;
      case 'CoHost':
        return HostType.coHost;
      default:
        throw Exception('Invalid HostType: $str');
    }
  }
}
