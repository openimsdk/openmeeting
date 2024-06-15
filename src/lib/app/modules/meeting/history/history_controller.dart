import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:openmeeting/core/extension.dart';

import '../../../../core/app_controller.dart';
import '../../../data/services/repository/repository_adapter.dart';
import '../meeting/meeting_controller.dart';

enum SearchState { normal, searching, successful, failure }

class HistoryController extends GetxController {
  //TODO: Implement HistoryController.
  final meetingInfoList = <MeetingInfoExt>[].obs;
  final userInfo = Get.find<AppController>().userInfo!;
  final IMeetingRepository repository;

  HistoryController({required this.repository});

  final searchController = TextEditingController();
  final focusNode = FocusNode();
  final searching = SearchState.normal.obs;

  final sourceMeetings = <MeetingInfoExt>[];

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      final text = searchController.text;

      if (text.isNotEmpty) {
        searchMeeting(text);
      } else {
        meetingInfoList.assignAll(sourceMeetings);
      }
    });

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        meetingInfoList.assignAll(sourceMeetings);
        meetingInfoList.refresh();
      }
    });

    getHistory();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String getMeetingCreateDate(int timestamp) {
    return DateUtil.formatDateMs(
      timestamp,
      format: Get.locale?.languageCode == 'zh' ? 'MM月dd日' : 'MM/dd',
    );
  }

  String getMeetingDuration(MeetingInfoSetting meetingInfo) {
    final startTime = DateUtil.formatDateMs(
      meetingInfo.scheduledTime,
      format: 'HH:mm',
    );
    final endTime = DateUtil.formatDateMs(
      meetingInfo.scheduledTime + meetingInfo.duration,
      format: 'HH:mm',
    );
    return "$startTime-$endTime ${meetingInfo.meetingID.splitStringEveryNChars()}";
  }

  bool isStartedMeeting(MeetingInfoSetting meetingInfo) {
    final start = DateUtil.getDateTimeByMs(meetingInfo.scheduledTime);
    final now = DateTime.now();
    return start.difference(now).isNegative;
  }

  void getHistory() async {
    final result = await repository.getHistory(userInfo.userId);
    final r = _groupMeetingsByDate(result);
    sourceMeetings.assignAll(r);

    meetingInfoList.value.assignAll(sourceMeetings);
    meetingInfoList.refresh();
  }

  void searchMeeting(String keywords) async {
    final result = sourceMeetings
        .where((e) => !e.isHeader && (e.meetingInfo!.meetingName.contains(keywords) || e.meetingInfo!.creatorNickname.contains(keywords)))
        .map((e) => e.meetingInfo!)
        .toList();
    final r = _groupMeetingsByDate(result);
    meetingInfoList.value.assignAll(r);

    meetingInfoList.refresh();
  }

  List<MeetingInfoExt> _groupMeetingsByDate(List<MeetingInfoSetting> meetings) {
    Map<String, List<MeetingInfoSetting>> groupedMap = {};

    meetings.sort((a, b) => b.scheduledTime.compareTo(a.scheduledTime));

    for (var meeting in meetings) {
      String formattedDate = DateUtil.formatDateMs(meeting.scheduledTime, format: 'yyyy-MM-dd');

      if (groupedMap.containsKey(formattedDate)) {
        groupedMap[formattedDate]!.add(meeting);
      } else {
        groupedMap[formattedDate] = [meeting];
      }
    }

    List<MeetingInfoExt> groupedMeetings = [];

    groupedMap.forEach((date, meetings) {
      groupedMeetings.add(MeetingInfoExt(isHeader: true, dateStr: date));
      groupedMeetings.addAll(
        meetings.map((meeting) => MeetingInfoExt(meetingInfo: meeting)).toList(),
      );
    });

    return groupedMeetings;
  }
}
