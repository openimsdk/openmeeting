import 'package:get/get.dart';

import '../app/modules/meeting/book_meeting/booking_config/booking_config_binding.dart';
import '../app/modules/meeting/book_meeting/booking_config/booking_config_page.dart';
import '../app/modules/meeting/book_meeting/custom_repeat/custom_repeat_binding.dart';
import '../app/modules/meeting/book_meeting/custom_repeat/custom_repeat_page.dart';
import '../app/modules/meeting/book_meeting/repeat_ends/repeat_ends_binding.dart';
import '../app/modules/meeting/book_meeting/repeat_ends/repeat_ends_page.dart';
import '../app/modules/meeting/book_meeting/repeat_model/repeat_model_binding.dart';
import '../app/modules/meeting/book_meeting/repeat_model/repeat_model_page.dart';
import '../app/modules/meeting/book_meeting/selected_timezone/selected_timezone_binding.dart';
import '../app/modules/meeting/book_meeting/selected_timezone/selected_timezone_page.dart';
import '../app/modules/meeting/history/history_binding.dart';
import '../app/modules/meeting/history/history_page.dart';
import '../app/modules/meeting/join_meeting/join_meeting_binding.dart';
import '../app/modules/meeting/join_meeting/join_meeting_view.dart';
import '../app/modules/meeting/meeting/meeting_binding.dart';
import '../app/modules/meeting/meeting/meeting_view.dart';
import '../app/modules/meeting/meeting/mobile/enable_camera/enable_camera_binding.dart';
import '../app/modules/meeting/meeting/mobile/enable_camera/enable_camera_view.dart';
import '../app/modules/meeting/meeting_detail/meeting_detail_binding.dart';
import '../app/modules/meeting/meeting_detail/meeting_detail_view.dart';

part 'm_routes.dart';

class MPages {
  static _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    List<GetPage> children = const [],
    bool popGesture = true,
  }) =>
      GetPage(
          name: name,
          page: page,
          binding: binding,
          transition: Transition.cupertino,
          popGesture: popGesture,
          preventDuplicates: true,
          children: children);

  static final pages = <GetPage>[
    _pageBuilder(
      name: MRoutes.meeting,
      page: () => MeetingPage(),
      binding: MeetingBinding(),
      popGesture: false,
    ),
    _pageBuilder(
      name: MRoutes.joinMeeting,
      page: () => JoinMeetingPage(),
      binding: JoinMeetingBinding(),
    ),
    _pageBuilder(name: MRoutes.bookingMeeting, page: () => const BookingConfigPage(), binding: BookingConfigBinding()),
    _pageBuilder(
      name: MRoutes.meetingDetail,
      page: () => MeetingDetailPage(),
      binding: MeetingDetailBinding(),
    ),
    _pageBuilder(name: MRoutes.enableCamera, page: () => EnableCameraPage(), binding: EnableCameraBinding()),
    _pageBuilder(
      name: MRoutes.selectedTimezone,
      page: () => const SelectedTimezonePage(),
      binding: SelectedTimezoneBinding(),
    ),
    _pageBuilder(name: MRoutes.repeatModel, page: () => const RepeatModelPage(), binding: RepeatModelBinding(), children: [
      _pageBuilder(
        name: MRoutes.customRepeat,
        page: () => const CustomRepeatPage(),
        binding: CustomRepeatBinding(),
      ),
    ]),
    _pageBuilder(
      name: MRoutes.repeatEnds,
      page: () => const RepeatEndsPage(),
      binding: RepeatEndsBinding(),
    ),
    _pageBuilder(
      name: MRoutes.history,
      page: () => const HistoryPage(),
      binding: HistoryBinding(),
    ),
  ];
}
