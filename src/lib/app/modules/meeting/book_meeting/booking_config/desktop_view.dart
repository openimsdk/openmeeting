import 'package:common_utils/common_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../data/models/booking_config.dart';
import '../../../../data/models/define.dart';
import '../widgets/custom_repeat_view.dart';

class _ModelItem {
  final String title;
  final dynamic value;

  const _ModelItem({required this.title, required this.value});
}

class DesktopView extends StatefulWidget {
  const DesktopView({super.key, required this.bookingConfig, required this.onSubmitted});

  final BookingConfig bookingConfig;

  final ValueChanged<BookingConfig> onSubmitted;
  @override
  State<DesktopView> createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  BookingConfig get bookingConfig => widget.bookingConfig;
  bool isZh = Get.locale!.languageCode.toLowerCase().contains("zh");
  late String format;
  late String endsInFormat;
  final durations = [
    _ModelItem(title: '0.5 ${StrRes.hours}', value: 0.5),
    _ModelItem(title: '1 ${StrRes.hours}', value: 1),
    _ModelItem(title: '1.5 ${StrRes.hours}', value: 1.5),
    _ModelItem(title: '2 ${StrRes.hours}', value: 2),
  ];
  late ValueNotifier<String?> durationValueListenable;

  late List<String> timeSlots;
  late ValueNotifier<String> timeSlotsValueListenable;

  final allTimezones = tz.timeZoneDatabase.locations;
  final _databaseTimeZones = <String>[];
  final timeZones = <String>[];
  late ValueNotifier<String> timeZoneValueListenable;

  final repeatModels = [
    _ModelItem(title: RepeatType.none.title, value: RepeatType.none),
    _ModelItem(title: RepeatType.daily.title, value: RepeatType.daily),
    _ModelItem(title: RepeatType.weekday.title, value: RepeatType.weekday),
    _ModelItem(title: RepeatType.weekly.title, value: RepeatType.weekly),
    _ModelItem(title: RepeatType.biweekly.title, value: RepeatType.biweekly),
    _ModelItem(title: RepeatType.monthly.title, value: RepeatType.monthly),
    _ModelItem(title: RepeatType.custom.title, value: RepeatType.custom),
  ];
  late ValueNotifier<String> repeatModelsValueListenable;

  final repeatEndsTypes = [
    _ModelItem(title: StrRes.day, value: 0),
    _ModelItem(title: StrRes.occurrences, value: 1),
  ];
  late ValueNotifier<String> endsInTypeValueListenable;
  TextEditingController occurrencesController = TextEditingController(text: '1');
  final weekday = DateUtil.getWeekday(DateTime.now(), languageCode: Get.locale!.languageCode);

  final inputPswFocusNode = FocusNode();
  final inputPswController = TextEditingController();

  @override
  void initState() {
    format = isZh ? "MM月dd日 HH:mm" : "MM/dd HH:mm";
    endsInFormat = isZh ? "yyyy年MM月dd日" : "MM/dd, yyyy";
    timeSlots = _generateTimeSlots();
    final beginTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);
    final roundedTime = _roundToNearest15Minutes(beginTime);
    final timeStr = DateUtil.formatDate(roundedTime, format: 'HH:mm');
    timeSlotsValueListenable = ValueNotifier(timeStr);
    durationValueListenable = ValueNotifier(durations.first.title);

    tz.initializeTimeZones();

    final currentTimeZone = tz.local.currentTimeZone;
    final currentTimeZoneStr = _configTimeZoneToString(tz.local.name, currentTimeZone);
    timeZoneValueListenable = ValueNotifier(currentTimeZoneStr);

    List<String> temp = [];
    allTimezones.forEach((name, location) {
      final currentTimeZone = location.currentTimeZone;
      final timeZoneStr = _configTimeZoneToString(name, currentTimeZone);
      temp.add(timeZoneStr);
      // temp.add('$name - ${currentTimeZone.abbreviation}, UTC${_timeOffset2String(currentTimeZone.offset)}${currentTimeZone.isDst ? " DST" : ""}');
    });

    _databaseTimeZones.addAll(temp);
    timeZones.addAll(temp);

    final currentRepeatModel =
        repeatModels.firstWhereOrNull((element) => element.title == bookingConfig.repeatType.title);
    final currentRepeatModelStr = currentRepeatModel?.title ?? repeatModels.first.title;
    repeatModelsValueListenable = ValueNotifier(currentRepeatModelStr);

    final endsInConfig = _configRepeatEnds();
    final currentEndsInType = bookingConfig.endsIn == 0 ? repeatEndsTypes.last : repeatEndsTypes.first;
    endsInTypeValueListenable = ValueNotifier(currentEndsInType.title);
    occurrencesController.text = endsInConfig.maxLimit.toString();

    super.initState();
  }

  String _configTimeZoneToString(String name, tz.TimeZone? timeZone) {
    if (timeZone == null) return "";
    return "$name - UTC${_timeOffset2String(timeZone.offset)}${timeZone.isDst ? " DST" : ""}";
  }

  List<String> _generateTimeSlots() {
    List<String> timeSlots = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 15) {
        String hourStr = (hour < 10) ? '0$hour' : '$hour';
        String minuteStr = (minute < 10) ? '0$minute' : '$minute';
        timeSlots.add('$hourStr:$minuteStr');
      }
    }
    return timeSlots;
  }

  DateTime _roundToNearest15Minutes(DateTime dateTime) {
    int minute = dateTime.minute;
    int roundedMinute = (minute / 15).round() * 15;
    if (roundedMinute == 60) {
      dateTime = dateTime.add(const Duration(hours: 1));
      roundedMinute = 0;
    }
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, roundedMinute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputItem(
              title: StrRes.meetingSubject,
              text: bookingConfig.name,
              placeholder: StrRes.plsInputYouMeetingName,
              onChanged: _inputMeetingName),
          _verSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: _buildSelectedDateItem(
                    title: StrRes.started,
                    text: DateUtil.formatDate(DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime),
                        format: 'MM-dd'),
                    onTap: _selectMeetingBeginDate),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: _buildDropdownItem(
                    items: timeSlots.map((e) => e).toList(),
                    valueListenable: timeSlotsValueListenable,
                    onChanged: _selectMeetingBeginTime),
              )
            ],
          ),
          _verSpace,
          _buildDropdownItem(
              title: StrRes.meetingDuration,
              items: durations.map((e) => e.title).toList(),
              valueListenable: durationValueListenable,
              onChanged: _selectMeetingDuration),
          _verSpace,
          _buildDropdownItem(
              title: StrRes.repeatFrequency,
              items: repeatModels.map((e) => e.title).toList(),
              valueListenable: repeatModelsValueListenable,
              onChanged: _selectRepeatModel),
          _verSpace,
          if (bookingConfig.repeatType == RepeatType.custom)
            CustomRepeatModelView(
              config: bookingConfig,
            ),
          _verSpace,
          if (bookingConfig.repeatType != RepeatType.none)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: _buildDropdownItem(
                      title: StrRes.endsIn,
                      items: repeatEndsTypes.map((e) => e.title).toList(),
                      valueListenable: endsInTypeValueListenable,
                      onChanged: _selectRepeatEndsType),
                ),
                Flexible(
                  child: endsInTypeValueListenable.value == repeatEndsTypes.first.title
                      ? _buildSelectedDateItem(
                          title: '',
                          text: DateUtil.formatDate(DateTime.fromMillisecondsSinceEpoch(_configRepeatEnds().endsInDays),
                              format: 'yyyy-MM-dd'),
                          onTap: _selectMeetingBeginDate)
                      : _buildNumberPicker(),
                ),
              ],
            ),
          _verSpace,
          Text(
            StrRes.securitySetting,
            style: Styles.ts_0C1C33_14sp_medium,
          ),
          _verSpace,
          _buildCheckBoxItem(
              title: StrRes.enterMeetingPassword,
              value: bookingConfig.enableMeetingPassword,
              onChanged: _enablePassword),
          if (bookingConfig.enableMeetingPassword)
            _buildInputItem(
                text: bookingConfig.meetingPassword ?? '',
                placeholder: StrRes.enterMeetingPassword,
                onChanged: _inputPassword),
          _verSpace,
          _buildCheckBoxItem(
              title: StrRes.allowMembersEnterFirst,
              value: bookingConfig.enableEnterBeforeHost,
              onChanged: _enableEnterBeforeHost),
          _verSpace,
          Text(
            StrRes.enterMeetingSetting,
            style: Styles.ts_0C1C33_14sp_medium,
          ),
          _verSpace,
          _buildCheckBoxItem(
              title: StrRes.enterMeetingEnableMicrophone,
              value: bookingConfig.enableMicrophone,
              onChanged: _enableMicrophone),
          _verSpace,
          _buildCheckBoxItem(
              title: StrRes.enterMeetingEnableVideo, value: bookingConfig.enableCamera, onChanged: _enableCamera),
        ],
      ),
    );
  }

  Widget _buildInputItem({String? title, required String text, String? placeholder, ValueChanged<String>? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title,
            style: Styles.ts_0C1C33_14sp_medium,
          ),
        _verSpace,
        CupertinoTextField(
          controller: TextEditingController(text: text),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          placeholder: placeholder,
          clearButtonMode: OverlayVisibilityMode.always,
          style: Styles.ts_0C1C33_14sp,
          onChanged: onChanged,
        )
      ],
    );
  }

  Widget _buildSelectedDateItem(
      {required String title, required String text, String? placeholder, required VoidCallback onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Styles.ts_0C1C33_14sp_medium,
        ),
        _verSpace,
        CupertinoTextField(
          controller: TextEditingController(text: text),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          placeholder: placeholder,
          suffix: const Icon(Icons.keyboard_arrow_down_rounded),
          readOnly: true,
          style: Styles.ts_0C1C33_14sp,
          onTap: onTap,
        ),
      ],
    );
  }

  Widget _buildDropdownItem(
      {String? title,
      required List<String> items,
      required ValueNotifier<String?> valueListenable,
      ValueChanged<String>? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title,
            style: Styles.ts_0C1C33_14sp_medium,
          ),
        _verSpace,
        LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth, maxHeight: 200),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  items: items.map((e) => DropdownItem(height: 34, value: e, child: Text(e))).toList(),
                  valueListenable: valueListenable,
                  onChanged: (value) {
                    onChanged?.call(value!);
                    valueListenable.value = value;
                  },
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      color: Colors.white,
                    ),
                  ),
                  iconStyleData: const IconStyleData(icon: Icon(Icons.keyboard_arrow_down_outlined)),
                  style: Styles.ts_0C1C33_14sp,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNumberPicker() {
    return Container(
      width: 140,
      height: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              if (int.parse(occurrencesController.text) > 1) {
                occurrencesController.text = (int.parse(occurrencesController.text) - 1).toString();
              }
              bookingConfig.repeatTimes = int.parse(occurrencesController.text);
            }),
          ),
          const VerticalDivider(
            width: 1,
          ),
          Flexible(
            child: CupertinoTextField(
              controller: occurrencesController,
              textAlign: TextAlign.center,
              decoration: const BoxDecoration(border: null),
              keyboardType: TextInputType.number,
              style: Styles.ts_0C1C33_14sp,
              onChanged: _selectRepeatEndsTimes,
            ),
          ),
          const VerticalDivider(
            width: 1,
          ),
          IconButton(
            icon: Icon(Icons.add),
            padding: EdgeInsets.zero,
            onPressed: () => setState(() {
              if (int.parse(occurrencesController.text) < 30) {
                occurrencesController.text = (int.parse(occurrencesController.text) + 1).toString();
              }

              bookingConfig.repeatTimes = int.parse(occurrencesController.text);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxItem({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return Row(
      children: [
        Checkbox(
            value: value,
            onChanged: (value) {
              onChanged(value!);
            }),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Styles.ts_0C1C33_14sp,
        ),
      ],
    );
  }

  void _inputMeetingName(String value) {
    bookingConfig.name = value;
  }

  void _selectMeetingBeginDate() async {
    final result = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(),
      dialogSize: const Size(325, 400),
      value: [DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime)],
      borderRadius: BorderRadius.circular(15),
    );

    if (result?.isNotEmpty == true) {
      setState(() {
        final index = timeSlots.indexWhere((element) => element == timeSlotsValueListenable.value);
        bookingConfig.beginTime = DateTime.fromMillisecondsSinceEpoch(result!.first!.millisecondsSinceEpoch)
            .add(Duration(minutes: index * 15))
            .millisecondsSinceEpoch;
      });
    }
    print('${result}');
  }

  void _selectMeetingBeginTime(String value) async {
    final index = timeSlots.indexWhere((element) => element == value);
    bookingConfig.beginTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime)
        .add(Duration(minutes: index * 15))
        .millisecondsSinceEpoch;
  }

  void _selectMeetingDuration(String value) {
    final index = durations.indexWhere((element) => element.title == value);
    bookingConfig.duration = (durations[index].value * 60 * 60).toInt();
  }

  void _selectTimezone(String value) async {}

  void _selectRepeatModel(String value) {
    final index = repeatModels.indexWhere((element) => element.title == value);

    if (index != 0) {
      final config = _configRepeatEnds();
      bookingConfig.endsIn = config.endsInDays;
      bookingConfig.repeatTimes = config.maxLimit;
    }

    setState(() {
      bookingConfig.repeatType = repeatModels[index].value;
    });
  }

  void _selectRepeatEndsType(String value) async {
    setState(() {});
  }

  void _selectRepeatEndsDate(String value) async {
    final result = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(),
      dialogSize: const Size(325, 400),
      value: [DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime)],
      borderRadius: BorderRadius.circular(15),
    );

    if (result?.isNotEmpty == true) {
      setState(() {
        bookingConfig.endsIn = result!.first!.millisecondsSinceEpoch;
      });
    }
    print('${result}');
  }

  void _selectRepeatEndsTimes(String value) async {
    if (value.isEmpty) {
      return;
    }
    bookingConfig.repeatTimes = int.parse(value);
  }

  void _enablePassword(bool value) {
    setState(() {
      bookingConfig.enableMeetingPassword = value;
    });
    inputPswFocusNode.requestFocus();
  }

  void _inputPassword(String value) {
    bookingConfig.meetingPassword = value;
  }

  void _enableEnterBeforeHost(bool value) {
    setState(() {
      bookingConfig.enableEnterBeforeHost = value;
    });
  }

  void _enableMicrophone(bool value) {
    setState(() {
      bookingConfig.enableMicrophone = value;
    });
  }

  void _enableCamera(bool value) {
    setState(() {
      bookingConfig.enableCamera = value;
    });
  }

  String _timeOffset2String(int? offset) {
    if (offset == null) return "";
    String offsetStr = "";

    int offsetInHours = offset ~/ 1000 ~/ 3600;
    if (offsetInHours >= 10) {
      offsetStr += "+$offsetInHours";
    } else if (offsetInHours >= 0) {
      offsetStr = "+0$offsetInHours";
    } else if (offsetInHours > -10) {
      offsetStr = "-0${-offsetInHours}";
    } else {
      offsetStr = "$offsetInHours";
    }

    offsetStr += ":00";

    return offsetStr;
  }

  ({int endsInDays, int maxLimit}) _configRepeatEnds() {
    final bookingConfig = widget.bookingConfig;
    final type = bookingConfig.repeatType;

    var endsInDays = bookingConfig.endsIn;
    final maxLimit = bookingConfig.repeatTimes != 0 ? bookingConfig.repeatTimes : 7;

    if (type == RepeatType.custom) {
      endsInDays = bookingConfig.endsIn != 0
          ? bookingConfig.endsIn
          : DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime).add(maxLimit.days).millisecondsSinceEpoch;
    } else if (type == RepeatType.weekday) {
      var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

      int workdaysAdded = 0;

      while (workdaysAdded < maxLimit) {
        if (originalTime.weekday == DateTime.friday) {
          originalTime = originalTime.add(3.days);
        } else {
          originalTime = originalTime.add(1.days);
        }

        if (originalTime.weekday != DateTime.saturday && originalTime.weekday != DateTime.sunday) {
          workdaysAdded++;
        }
      }

      endsInDays = originalTime.millisecondsSinceEpoch;
    } else if (type == RepeatType.weekly) {
      var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

      for (int i = 0; i < maxLimit; i++) {
        originalTime = originalTime.add(7.days);
      }

      endsInDays = originalTime.millisecondsSinceEpoch;
    } else if (type == RepeatType.biweekly) {
      var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

      for (int i = 0; i < maxLimit; i++) {
        originalTime = originalTime.add(14.days);
      }

      endsInDays = originalTime.millisecondsSinceEpoch;
    } else if (type == RepeatType.monthly) {
      var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

      for (int i = 0; i < maxLimit; i++) {
        int nextMonth = originalTime.month + 1;
        int nextYear = originalTime.year;
        if (nextMonth > 12) {
          nextMonth = 1;
          nextYear++;
        }
        originalTime = DateTime(nextYear, nextMonth, originalTime.day);
      }

      endsInDays = originalTime.millisecondsSinceEpoch;
    } else if (type == RepeatType.custom) {
      final unit = bookingConfig.unit;
      final interval = bookingConfig.interval;

      if (unit == UnitType.day) {
        endsInDays = bookingConfig.endsIn != 0
            ? bookingConfig.endsIn
            : DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime)
                .add((maxLimit * interval).days)
                .millisecondsSinceEpoch;
      } else if (unit == UnitType.week) {
        var originalTime = DateTime.fromMillisecondsSinceEpoch(bookingConfig.beginTime);

        for (int i = 0; i < maxLimit; i++) {
          originalTime = originalTime.add(7.days * interval);
        }

        endsInDays = originalTime.millisecondsSinceEpoch;
      }
    }

    return (endsInDays: endsInDays, maxLimit: maxLimit);
  }

  Widget get _verSpace => const SizedBox(height: 10);
}
