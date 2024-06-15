import 'package:get/get.dart';
import 'package:openmeeting/routes/m_pages.dart';

import '../app/modules/login/login_binding.dart';
import '../app/modules/login/login_view.dart';
import '../app/modules/mine/about_us/about_us_binding.dart';
import '../app/modules/mine/about_us/about_us_view.dart';
import '../app/modules/mine/change_pwd/change_pwd_binding.dart';
import '../app/modules/mine/change_pwd/change_pwd_view.dart';
import '../app/modules/mine/meeting_setup/meeting_setup_binding.dart';
import '../app/modules/mine/meeting_setup/meeting_setup_view.dart';
import '../app/modules/splash/splash_binding.dart';
import '../app/modules/splash/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  /// 左滑关闭页面用于android
  static _pageBuilder({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool preventDuplicates = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        preventDuplicates: preventDuplicates,
        transition: Transition.cupertino,
        popGesture: true,
      );

  static final pages = mainPages + subPages;

  static final mainPages = <GetPage>[
    _pageBuilder(
      name: AppRoutes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.meetingSetup,
      page: () => MeetingSetupPage(),
      binding: MeetingSetupBinding(),
    ),
    ...MPages.pages
  ];

  static final subPages = <GetPage>[
    _pageBuilder(
      name: AppRoutes.changePassword,
      page: () => ChangePwdPage(),
      binding: ChangePwdBinding(),
    ),
    _pageBuilder(
      name: AppRoutes.aboutUs,
      page: () => AboutUsPage(),
      binding: AboutUsBinding(),
    ),
  ];

  static final GetPage settingPage = _pageBuilder(
    name: AppRoutes.meetingSetup,
    page: () => MeetingSetupPage(),
    binding: MeetingSetupBinding(),
  );
}
