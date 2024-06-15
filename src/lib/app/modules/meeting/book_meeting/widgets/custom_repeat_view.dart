import 'dart:ffi';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';
import 'package:sprintf/sprintf.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/booking_config.dart';

class _ModelItem {
  final String title;
  final int value;

  const _ModelItem({required this.title, required this.value});
}

class CustomRepeatModelView extends StatefulWidget {
  const CustomRepeatModelView({super.key, required this.config});

  final BookingConfig config;

  @override
  State<CustomRepeatModelView> createState() => CustomRepeatModelViewState();
}

class CustomRepeatModelViewState extends State<CustomRepeatModelView> {
  final units = [_ModelItem(title: StrRes.day, value: 0), _ModelItem(title: StrRes.week, value: 1), _ModelItem(title: StrRes.month, value: 2)];
  final cycleValues = [
    List.generate(100, (index) => _ModelItem(title: (index + 1).toString(), value: index + 1)),
    List.generate(12, (index) => _ModelItem(title: (index + 1).toString(), value: index + 1)),
    List.generate(12, (index) => _ModelItem(title: (index + 1).toString(), value: index + 1)),
  ];
  late List<_ModelItem> _weekdayValues;
  final monthsUnits = [_ModelItem(title: StrRes.day, value: 0), _ModelItem(title: StrRes.month, value: 2)];

  late final bookingConfig = Rx<BookingConfig?>(null);
  int get _selectedUnit => bookingConfig.value!.unit;
  final _selectedValue = 0.obs;
  final _selectedMonthValue = 0.obs;
  final _selectedMonthUnit = 0.obs;

  late ValueNotifier<String> _durationValueListenable;

  late ValueNotifier<String> _unitsValueListenable;

  final _selectedWeekdays = <_ModelItem>[].obs;

  late ValueNotifier<String> _monthsUnitsListenable;

  @override
  void initState() {
    super.initState();
    _weekdayValues = _getWeekdays();
    _durationValueListenable = ValueNotifier(cycleValues[0][0].title);
    _unitsValueListenable = ValueNotifier(units[0].title);
    _monthsUnitsListenable = ValueNotifier(monthsUnits[0].title);

    bookingConfig.value = widget.config;

    final DateFormat formatter = DateFormat('EEE');
    final now = formatter.format(DateTime.now());

    var value = [_ModelItem(title: now, value: DateTime.now().weekday)];
    if (bookingConfig.value?.weekdays != null) {
      value = bookingConfig.value!.weekdays!.map((e) => _weekdayValues[e]).toList();
    }
    _selectedWeekdays.value = value;
  }

  List<_ModelItem> _getWeekdays() {
    final now = DateTime.now();
    final DateFormat formatter = DateFormat('EEE');

    // Find the first day of the current week (assuming Monday as the first day)
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    // Generate the list of weekdays from Monday to Friday
    return List.generate(7, (index) {
      final weekday = startOfWeek.add(Duration(days: index));
      final title = formatter.format(weekday);

      return _ModelItem(title: title, value: weekday.weekday);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 10),
      child: PlatformExt.isMobile ? _buildMobileView() : _buildDesktopView(),
    );
  }

  Widget _buildMobileView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(builder: (context, constraints) {
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16),
            color: Colors.white,
            constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: 52.h, maxHeight: 52.h),
            child: Obx(
              () => Text(
                sprintf(StrRes.customRepeatModelHint, ['${cycleValues[_selectedUnit][_selectedValue.value]}${units[_selectedUnit]}']),
                style: Styles.ts_0C1C33_17sp,
              ),
            ),
          );
        }),
        _buildMobilePicker(),
      ],
    );
  }

  Widget _buildMobilePicker() {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Styles.c_E8EAEF, width: 1),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: CupertinoPicker.builder(
              itemExtent: 38.h,
              onSelectedItemChanged: (index) {
                print('index: $index');
                _selectedValue.value = index;
              },
              itemBuilder: (context, index) {
                return Container(alignment: Alignment.center, child: Text('${cycleValues[_selectedUnit][index]}'));
              },
              childCount: cycleValues[_selectedUnit].length,
              selectionOverlay: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(color: Styles.c_E8EAEF, width: 1),
                    top: BorderSide(color: Styles.c_E8EAEF, width: 1),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: CupertinoPicker.builder(
              itemExtent: 38.h,
              onSelectedItemChanged: (index) {
                print('index: $index');
                bookingConfig.value!.unit = index;
              },
              itemBuilder: (context, index) {
                return Container(alignment: Alignment.center, child: Text(units[index].title));
              },
              childCount: units.length,
              selectionOverlay: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(color: Styles.c_E8EAEF, width: 1),
                    top: BorderSide(color: Styles.c_E8EAEF, width: 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopView() {
    return Obx(
      () => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 2,
                child: _buildDropdownItem(
                    title: 'Recur',
                    items: cycleValues[_selectedUnit].map((e) => e.title).toList(),
                    valueListenable: _durationValueListenable,
                    onChanged: (value) {
                      bookingConfig.update((val) {
                        val?.cycleValue = cycleValues[_selectedUnit].indexWhere((element) => element.title == value);
                      });
                    }),
              ),
              Flexible(
                flex: 3,
                child: _buildDropdownItem(
                    items: units.map((e) => e.title).toList(),
                    valueListenable: _unitsValueListenable,
                    onChanged: (value) {
                      bookingConfig.update((val) {
                        val?.unit = units.indexWhere((element) => element.title == value);
                      });
                    }),
              ),
              _selectedUnit != 2
                  ? Container()
                  : Flexible(
                      flex: 3,
                      child: _buildDropdownItem(
                          items: monthsUnits.map((e) => e.title).toList(),
                          valueListenable: _monthsUnitsListenable,
                          onChanged: (value) {
                            _selectedMonthUnit.value = monthsUnits.indexWhere((element) => element.title == value);
                          }),
                    ),
            ],
          ),
          _verSpace,
          if (_selectedUnit == 1) _buildWeekdayView(),
          if (_selectedUnit == 2) _selectedMonthUnit.value == 0 ? _buildSelectedDateView() : _buildCurrentWeekdayInMonthView(),
        ],
      ),
    );
  }

  Widget _buildDropdownItem<T>({String? title, required List<T> items, required ValueNotifier<T> valueListenable, ValueChanged<T>? onChanged}) {
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
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<T>(
                  items: items.map((e) => DropdownItem(height: 40, value: e, child: Text('$e'))).toList(),
                  valueListenable: valueListenable,
                  onChanged: <T>(value) {
                    onChanged?.call(value);
                    valueListenable.value = value;
                  },
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      color: Colors.white,
                    ),
                  ),
                  iconStyleData: IconStyleData(icon: Icon(Icons.keyboard_arrow_down_outlined)),
                  style: Styles.ts_0C1C33_14sp,
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 150,
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWeekdayView() {
    return Wrap(
      children: _weekdayValues
          .map((e) => _buildCheckBoxItem(
              title: e.title,
              value: _selectedWeekdays.contains(e),
              onChanged: (bool value) {
                if (value) {
                  _selectedWeekdays.add(e);
                } else {
                  _selectedWeekdays.remove(e);
                }
              }))
          .toList(),
    );
  }

  Widget _buildSelectedDateView() {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.multi,
      ),
      value: bookingConfig.value!.dates?.map((e) => DateTime.fromMillisecondsSinceEpoch(e)).toList() ?? [],
      onValueChanged: (dates) => bookingConfig.value!.dates = dates.map((e) => e!.millisecondsSinceEpoch).toList(),
    );
  }

  Widget _buildCurrentWeekdayInMonthView() {
    final date = DateTime.now();
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    // Calculate the week number of the current date
    int weekOfMonth = ((date.day + firstDayOfMonth.weekday - 1) / 7).ceil();

    final DateFormat formatter = DateFormat('EEE');
    final now = formatter.format(date);
    final str = '${sprintf(StrRes.Nth, [weekOfMonth])} $now';

    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: 40),
        child: CupertinoTextField(
          controller: TextEditingController(text: str),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          enabled: false,
          textAlignVertical: TextAlignVertical.center,
        ),
      );
    });
  }

  Widget _buildCheckBoxItem({required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
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

  Widget _buildSelectedDateItem({required String title, required String text, String? placeholder, required VoidCallback onTap}) {
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
          suffix: Icon(Icons.keyboard_arrow_down_rounded),
          readOnly: true,
          style: Styles.ts_0C1C33_14sp,
          onTap: onTap,
        ),
      ],
    );
  }

  Widget get _verSpace => const SizedBox(height: 10);
}
