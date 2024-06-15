class BookingConfig {
  String name;
  int beginTime;
  int duration;
  int timeZone;
  int repeatType;
  int endsIn;
  int limitCount;
  // custom repeat mode
  int cycleValue;
  int unit;
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
    this.repeatType = 0,
    this.endsIn = 0,
    this.limitCount = 0,
    this.cycleValue = 1,
    this.unit = 0,
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
        repeatType: json['repeatType'],
        endsIn: json['endsIn'],
        limitCount: json['limitCount'],
        cycleValue: json['cycleValue'],
        unit: json['unit'],
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
        'repeatType': repeatType,
        'endsIn': endsIn,
        'limitCount': limitCount,
        'cycleValue': cycleValue,
        'unit': unit,
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
