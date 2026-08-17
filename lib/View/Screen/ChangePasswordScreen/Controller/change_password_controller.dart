import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool isOldPasswordVisible = false.obs;
  final RxBool isNewPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Lock ChangePasswordScreen strictly to Portrait mode ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void onSaveAndChange() {
    if (oldPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your old password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    if (newPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your new password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'New password and Confirm password do not match',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Password changed successfully!',
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
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
