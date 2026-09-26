import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class TeamSelectController extends GetxController {
  late TextEditingController blueTeamController;
  late TextEditingController redTeamController;

  final RxString selectedBlueIcon = ''.obs;
  final RxString selectedRedIcon = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Maintain landscape mode throughout the gameplay flow
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    blueTeamController = TextEditingController(text: 'Green Team');
    redTeamController = TextEditingController(text: 'Red Team');
  }

  void onBackTap() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Get.back();
  }

  void ensureControllersInitialized() {
    try {
      final _ = blueTeamController.text;
    } catch (_) {
      blueTeamController = TextEditingController(text: 'Green Team');
    }

    try {
      final _ = redTeamController.text;
    } catch (_) {
      redTeamController = TextEditingController(text: 'Red Team');
    }
  }

  void onNextTap() {
    ensureControllersInitialized();
    Get.toNamed(
      AppRoute.chooseCategoryScreen,
      arguments: {
        'blueTeam': blueTeamController.text.trim().isEmpty
            ? 'Green Team'
            : blueTeamController.text.trim(),
        'redTeam': redTeamController.text.trim().isEmpty
            ? 'Red Team'
            : redTeamController.text.trim(),
        'blueIcon': selectedBlueIcon.value,
        'redIcon': selectedRedIcon.value,
      },
    );
  }

  @override
  void onClose() {
    try {
      blueTeamController.dispose();
    } catch (_) {}
    try {
      redTeamController.dispose();
    } catch (_) {}
    super.onClose();
  }
}
