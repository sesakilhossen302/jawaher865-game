import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamSelectController extends GetxController {
  final TextEditingController blueTeamController = TextEditingController(text: 'Blue Team');
  final TextEditingController redTeamController = TextEditingController(text: 'Red Team');

  void onNextTap() {
    // Action for Next button
  }

  @override
  void onClose() {
    blueTeamController.dispose();
    redTeamController.dispose();
    super.onClose();
  }
}
