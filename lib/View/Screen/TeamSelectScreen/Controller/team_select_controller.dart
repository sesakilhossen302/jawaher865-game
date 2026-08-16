import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class TeamSelectController extends GetxController {
  late TextEditingController blueTeamController;
  late TextEditingController redTeamController;

  @override
  void onInit() {
    super.onInit();
    blueTeamController = TextEditingController(text: 'Blue Team');
    redTeamController = TextEditingController(text: 'Red Team');
  }

  void ensureControllersInitialized() {
    try {
      final _ = blueTeamController.text;
    } catch (_) {
      blueTeamController = TextEditingController(text: 'Blue Team');
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
            ? 'Blue Team'
            : blueTeamController.text.trim(),
        'redTeam': redTeamController.text.trim().isEmpty
            ? 'Red Team'
            : redTeamController.text.trim(),
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
