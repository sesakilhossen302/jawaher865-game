import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../MainScreen/Controller/main_controller.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Enforce portrait mode for HomeScreen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void onPlayTap() {
    if (Get.isRegistered<MainController>()) {
      Get.find<MainController>().changeIndex(1);
    }
  }

  void onViewAllLeaderboardTap() {
    if (Get.isRegistered<MainController>()) {
      Get.find<MainController>().changeIndex(2);
    }
  }
}
