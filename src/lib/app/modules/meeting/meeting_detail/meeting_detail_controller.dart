import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:openmeeting/app/data/models/meeting.pb.dart';
import 'package:openmeeting/app/data/models/pb_extension.dart';
import 'package:openmeeting/app/widgets/meeting/desktop/meeting_alert_dialog.dart';
import '../../../../core/app_controller.dart';
import '../../../../core/data_sp.dart';
import '../../../../core/multi_window_manager.dart';
import '../../../../routes/m_navigator.dart';
import '../../../data/models/meeting_option.dart';
import '../../../data/services/repository/repository_adapter.dart';
import '../meeting_room/meeting_client.dart';

class MeetingDetailController extends GetxController {
  final userInfo = Get.find<AppController>().userInfo!;

  late MeetingInfoSetting meetingInfo;
  late String meetingCreator;
  late int startTime;
  late int endTime;

  final IMeetingRepository repository;

  MeetingDetailController({required this.repository});

  @override
  void onInit() {
    meetingInfo = Get.arguments['meetingInfo'] as MeetingInfoSetting;
    meetingCreator = meetingInfo.creatorNickname;
    startTime = meetingInfo.scheduledTime;
    endTime = meetingInfo.endTime;
    super.onInit();
  }

  String get meetingStartTime => DateUtil.formatDateMs(startTime, format: 'HH:mm');

  String get meetingEndTime => DateUtil.formatDateMs(endTime, format: 'HH:mm');

  String get meetingStartDate => DateUtil.formatDateMs(startTime, format: IMUtils.getTimeFormat1());

  String get meetingEndDate => DateUtil.formatDateMs(endTime, format: IMUtils.getTimeFormat1());

  String get meetingNo => meetingInfo.meetingID;

  bool get isMine => meetingInfo.creatorUserID == userInfo.userId;

  String get meetingDuration {
    final offset = meetingInfo.duration;
    return '${offset ~/ (60 * 1000)}${StrRes.minute}';
  }

  bool isStartedMeeting() {
    final start = DateUtil.getDateTimeByMs(meetingInfo.scheduledTime);
    final now = DateTime.now();
    return start.difference(now).isNegative;
  }

  void copy() {
    IMUtils.copy(text: meetingInfo.meetingID);
  }

  Future<String?> getMeetingPassword(String meetingID, String userID) async {
    final result = await repository.getMeetingInfo(meetingID, userID);

    return result?.password;
  }

  enterMeeting() async {
    if (MeetingClient().isBusy) {
      IMViews.showToast(StrRes.callingBusy);
      return;
    }

    final isEnableMicrophone = DataSp.getMeetingEnableMicrophone();
    final isEnableSpeaker = DataSp.getMeetingEnableSpeaker();
    final isEnableVideo = DataSp.getMeetingEnableVideo();
    final videoIsMirroring = DataSp.getMeetingEnableVideoMirroring();

    final cert = await repository.getLiveKitToken(meetingInfo.meetingID, userInfo.userId);
    if (PlatformExt.isDesktop) {
      windowsManager.newRoom(
          UserInfo(userID: userInfo.userId, nickname: userInfo.nickname), cert, meetingInfo.meetingID);
    } else {
      await MeetingClient().connect(Get.context!,
          url: cert.url,
          token: cert.token,
          roomID: meetingInfo.meetingID,
          options: MeetingOptions(
            enableMicrophone: isEnableMicrophone,
            enableSpeaker: isEnableSpeaker,
            enableVideo: isEnableVideo,
            videoIsMirroring: videoIsMirroring,
          ));
    }

    Get.back();
  }

  editMeeting() {
    Get.bottomSheet(
      BottomSheetView(
        items: [
          SheetItem(label: StrRes.updateMeetingInfo, onTap: _modifyMeetingInfo),
          SheetItem(
            label: StrRes.cancelMeeting,
            textStyle: Styles.ts_FF381F_17sp,
            onTap: _cancelMeeting,
          ),
        ],
      ),
    );
  }

  _cancelMeeting() {
    MeetingAlertDialog.show(Get.context!, StrRes.cancelMeetingConfirmHit, onConfirm: () async {
      final result = await repository.endMeeting(meetingInfo.meetingID, userInfo.userId);

      if (result) {
        IMViews.showToast(StrRes.changedSuccessfully);
        Get.back();
      }
    });
  }

  _modifyMeetingInfo() => MNavigator.startBookMeeting(
        meetingInfo: meetingInfo,
        offAndToNamed: true,
      );
}
