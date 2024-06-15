import 'dart:async';

import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../../../core/data_sp.dart';
import '../../../core/push_controller.dart';
import '../../../routes/app_navigator.dart';

class MineController extends GetxController {
  final pushLogic = Get.find<PushController>();
  late StreamSubscription kickedOfflineSub;

  void aboutUs() => AppNavigator.startAboutUs();

  void logout() async {
    var confirm = await Get.dialog(CustomDialog(title: StrRes.logoutHint));
    if (confirm == true) {
      try {
        await LoadingView.singleton.wrap(asyncFunction: () async {
          await DataSp.removeLoginCertificate();
        });
        AppNavigator.startLogin();
      } catch (e) {
        IMViews.showToast('e:$e');
      }
    }
  }

  void kickedOffline() async {
    Get.snackbar(StrRes.accountWarn, StrRes.accountException);
    await DataSp.removeLoginCertificate();
    AppNavigator.startLogin();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    kickedOfflineSub.cancel();
    super.onClose();
  }
}
