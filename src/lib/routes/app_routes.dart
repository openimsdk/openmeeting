part of 'app_pages.dart';

abstract class AppRoutes {
  static const notFound = '/not-found';
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const meetingRoom = '/meeting_room';

  static const meetingSetup = '/meeting_setup';
  static const changePassword = '/change_password';
  static const aboutUs = '/about_us';
}

extension RoutesExtension on String {
  String toRoute() => '/${toLowerCase()}';
}
