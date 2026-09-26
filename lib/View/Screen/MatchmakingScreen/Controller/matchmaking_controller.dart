import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class MatchmakingController extends GetxController {
  final RxBool isOpponentFound = false.obs;
  final RxString statusText = 'Searching for players...'.obs;
  final RxString subText = 'Connecting with online melases'.obs;

  Timer? _searchTimer;
  Timer? _navigateTimer;

  @override
  void onInit() {
    super.onInit();
    // Enforce portrait mode during matchmaking
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _startMatchmaking();
  }

  void _startMatchmaking() {
    // Simulate finding online match after 2.5 seconds
    _searchTimer = Timer(const Duration(milliseconds: 2500), () {
      if (isClosed) return;
      isOpponentFound.value = true;
      statusText.value = 'Opponent Found!';
      subText.value = 'Preparing arena match...';

      _navigateTimer = Timer(const Duration(milliseconds: 1000), () {
        if (isClosed) return;
        Get.offNamed(AppRoute.vsMatchScreen);
      });
    });
  }

  void skipToMatch() {
    _searchTimer?.cancel();
    _navigateTimer?.cancel();
    isOpponentFound.value = true;
    statusText.value = 'Opponent Found!';
    subText.value = 'Preparing arena match...';
    Get.offNamed(AppRoute.vsMatchScreen);
  }

  @override
  void onClose() {
    _searchTimer?.cancel();
    _navigateTimer?.cancel();
    super.onClose();
  }
}
