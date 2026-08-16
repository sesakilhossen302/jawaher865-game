import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class WinningController extends GetxController {
  final RxString winnerName = 'Asadujjaman'.obs;
  final RxInt winnerScore = 1000.obs;
  final RxString winnerAvatarInitials = 'ش'.obs;

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
      if (args['winnerName'] != null) winnerName.value = args['winnerName'];
      if (args['winnerScore'] != null) winnerScore.value = args['winnerScore'];
      if (args['winnerAvatar'] != null) winnerAvatarInitials.value = args['winnerAvatar'];
    }
  }

  void onPlayAgain() {
    // Lock orientation back to Portrait when returning to Team Select
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Get.offNamedUntil(AppRoute.teamSelectScreen, (route) => route.isFirst);
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.onClose();
  }
}
