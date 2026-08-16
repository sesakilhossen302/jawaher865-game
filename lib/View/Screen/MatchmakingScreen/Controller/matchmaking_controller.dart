import 'dart:async';
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
    _startMatchmaking();
  }

  void _startMatchmaking() {
    // 1. Simulate finding an online opponent after 2.5 seconds
    _searchTimer = Timer(const Duration(milliseconds: 2500), () {
      isOpponentFound.value = true;
      statusText.value = 'Opponent found!';
      subText.value = 'Connecting you now';

      // 2. Auto-navigate to Game Board after 2 seconds
      _navigateTimer = Timer(const Duration(milliseconds: 2000), () {
        Get.offNamed(
          AppRoute.gameBoardScreen,
          arguments: {
            'player1': 'You (Blue)',
            'player2': 'Online Rival (Red)',
          },
        );
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
