import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class PlayController extends GetxController {
  final RxInt selectedNavIndex = 1.obs;

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void onStartNowTap() {
    Get.toNamed(AppRoute.teamSelectScreen);
  }

  void onPlayOnlineTap() {
    Get.toNamed(AppRoute.teamSelectScreen);
  }
}
