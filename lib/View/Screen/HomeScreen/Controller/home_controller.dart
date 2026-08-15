import 'package:get/get.dart';
import '../../MainScreen/Controller/main_controller.dart';

class HomeController extends GetxController {
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
