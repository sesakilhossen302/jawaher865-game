import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SupportContactController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final feedbackController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Lock SupportContactScreen strictly to Portrait mode ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void onSubmit() {
    if (fullNameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your full name',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    if (subjectController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a subject',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    if (feedbackController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your feedback',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Support request submitted successfully!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF22C55E),
      colorText: Colors.white,
    );

    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    feedbackController.dispose();
    super.onClose();
  }
}
