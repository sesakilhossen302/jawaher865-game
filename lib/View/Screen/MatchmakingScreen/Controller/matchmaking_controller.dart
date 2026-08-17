import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class MatchmakingController extends GetxController {
  final RxBool isOpponentFound = false.obs;
  final RxString statusText = 'Searching for opponent...'.obs;
  final RxString subText = 'Connecting with online players'.obs;

  Timer? _searchTimer;
  Timer? _navigateTimer;

  @override
  void onInit() {
    super.onInit();
    // Enforce portrait mode for MatchmakingScreen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _startMatchmaking();
  }

  void _startMatchmaking() {
    // 1. Simulate finding an online opponent after 2.5 seconds
    _searchTimer = Timer(const Duration(milliseconds: 2500), () {
      isOpponentFound.value = true;
      statusText.value = 'Opponent found!';
      subText.value = 'Connecting you now';

      // 2. Auto-navigate to 2 vs 2 VS Match screen after 1.8 seconds
      _navigateTimer = Timer(const Duration(milliseconds: 1800), () {
        Get.offNamed(AppRoute.vsMatchScreen);
      });
    });
  }

  @override
  void onClose() {
    _searchTimer?.cancel();
    _navigateTimer?.cancel();
    super.onClose();
  }
}
