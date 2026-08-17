import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCommunityController extends GetxController {
  final RxInt selectedTabIndex = 0.obs; // 0: My Meelas, 1: Friends, 2: Featured Meelas
  final chatInputController = TextEditingController();

  final RxList<Map<String, String>> chatMessages = <Map<String, String>>[
    {'message': 'Hello !', 'time': '1:20 am'},
  ].obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void sendChatMessage(String message) {
    if (message.trim().isEmpty) return;
    chatMessages.add({
      'message': message.trim(),
      'time': '1:21 am',
    });
    chatInputController.clear();
  }

  void onJoinMeelas() {
    Get.snackbar(
      'Join Meelas',
      'Join Meelas tapped',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF3358FE),
      colorText: Colors.white,
    );
  }

  void onCreateMeelas() {
    Get.snackbar(
      'Create Meelas',
      'Create Meelas tapped',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF3358FE),
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    chatInputController.dispose();
    super.onClose();
  }
}
