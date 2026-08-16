import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class WinningController extends GetxController {
  final RxString winnerName = 'Asaduzzaman'.obs;
  final RxInt winnerScore = 1000.obs;
  final RxString winnerAvatarInitials = 'ش'.obs;
  final RxBool isOnlineMatch = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Allow rotation on Congratulations / Winning Screen (Landscape + Portrait)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);

    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      if (args['isOnlineMatch'] != null) {
        isOnlineMatch.value = args['isOnlineMatch'];
      }
      if (args['winnerName'] != null) winnerName.value = args['winnerName'];
      if (args['winnerScore'] != null) winnerScore.value = args['winnerScore'];
      if (args['winnerAvatar'] != null) winnerAvatarInitials.value = args['winnerAvatar'];
    }
  }

  void onPlayAgain() {
    if (isOnlineMatch.value) {
      // ONLINE PLAY: Tapping Try/Play Again redirects to MatchmakingScreen to find next online opponent
      Get.offAllNamed(AppRoute.matchmakingScreen);
    } else {
      // OFFLINE LOCAL PLAY: Tapping Play Again returns to TeamSelectScreen
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      Get.offNamedUntil(AppRoute.teamSelectScreen, (route) => route.isFirst);
    }
  }
}
