import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SelectedTimezoneController extends GetxController {
  final allTimezones = tz.timeZoneDatabase.locations;
  final _databaseTimeZones = <String>[];
  final searchController = TextEditingController();
  final timeZones = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    tz.initializeTimeZones();

    List<String> temp = [];
    allTimezones.forEach((name, location) {
      final currentTimeZone = location.currentTimeZone;

      temp.add('$name - ${currentTimeZone.abbreviation}, UTC${_timeOffset2String(currentTimeZone.offset)}${currentTimeZone.isDst ? " DST" : ""}');
    });

    _databaseTimeZones.addAll(temp);
    timeZones.addAll(temp);
  }

  @override
  void onReady() {
    super.onReady();

    searchController.addListener(_onSearchTextChanged);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _onSearchTextChanged() {
    // 调用过滤搜索结果的方法
    _filterSearchResults(searchController.text);
  }

  void _filterSearchResults(String query) {
    List<String> searchResult = [];
    if (query.isNotEmpty) {
      searchResult = _databaseTimeZones.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
      timeZones.value = searchResult;
    } else {
      searchResult.clear();
      timeZones.value = _databaseTimeZones;
    }
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
}
