import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class TeamSelectController extends GetxController {
  final TextEditingController blueTeamController = TextEditingController(text: 'Blue Team');
  final TextEditingController redTeamController = TextEditingController(text: 'Red Team');

  void onNextTap() {
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
    blueTeamController.dispose();
    redTeamController.dispose();
    super.onClose();
  }
}
