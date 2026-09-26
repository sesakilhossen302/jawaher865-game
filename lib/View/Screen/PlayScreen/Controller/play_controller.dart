import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class PlayController extends GetxController {
  final RxInt selectedNavIndex = 1.obs;

  @override
  void onInit() {
    super.onInit();
    // Enforce portrait mode for PlayScreen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void onStartNowTap() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Get.toNamed(AppRoute.teamSelectScreen);
  }

  void onPlayOnlineTap() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Get.toNamed(AppRoute.matchmakingScreen);
  }

  void onCommunityTap() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    Get.toNamed(AppRoute.myCommunityScreen);
  }
}
