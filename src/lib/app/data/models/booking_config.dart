import 'package:openmeeting/app/data/models/define.dart';

class BookingConfig {
  String name;
  int beginTime;
  int duration;
  int timeZone;
  RepeatType repeatType;
  int endsIn;
  int repeatTimes;
  // custom repeat mode
  int interval;
  UnitType unit;
  List<int>? weekdays;
  int monthUnit;
  List<int>? dates;

  bool enableMeetingPassword;
  String? meetingPassword;
  bool enableEnterBeforeHost;
  bool enableMicrophone;
  bool enableCamera;

  BookingConfig({
    required this.name,
    required this.beginTime,
    required this.duration,
    this.timeZone = 8,
    this.repeatType = RepeatType.none,
    this.endsIn = 0,
    this.repeatTimes = 0,
    this.interval = 0,
    this.unit = UnitType.day,
    this.weekdays,
    this.monthUnit = 0,
    this.dates,
    this.enableMeetingPassword = false,
    this.meetingPassword,
    this.enableEnterBeforeHost = true,
    this.enableMicrophone = true,
    this.enableCamera = true,
  });

  factory BookingConfig.fromMap(Map<String, dynamic> json) => BookingConfig(
        name: json['name'],
        beginTime: json['beginTime'],
        duration: json['duration'],
        timeZone: json['timeZone'],
        repeatType: json['repeatType'] == null ? RepeatType.none : RepeatTypeExt.fromString(json['repeatType']),
        endsIn: json['endsIn'],
        repeatTimes: json['repeatTimes'],
        interval: json['interval'],
        unit: json['unit'] == null ? UnitType.day : UnitTypeExt.fromString(json['unit']),
        weekdays: json['weekdays'],
        monthUnit: json['monthUnit'],
        dates: json['dates'],
        enableMeetingPassword: json['enableMeetingPassword'],
        meetingPassword: json['meetingPassword'],
        enableEnterBeforeHost: json['enableEnterBeforeHost'],
        enableMicrophone: json['enableMicrophone'],
        enableCamera: json['enableCamera'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'beginTime': beginTime,
        'duration': duration,
        'timeZone': timeZone,
        'repeatType': repeatType.rawValue,
        'endsIn': endsIn,
        'repeatTimes': repeatTimes,
        'interval': interval,
        'unit': unit.rawValue,
        'weekdays': weekdays,
        'monthUnit': monthUnit,
        'dates': dates,
        'enableMeetingPassword': enableMeetingPassword,
        'meetingPassword': meetingPassword,
        'enableEnterBeforeHost': enableEnterBeforeHost,
        'enableMicrophone': enableMicrophone,
        'enableCamera': enableCamera,
      };
}
