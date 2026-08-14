import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  void sendVerificationCode() {
    Get.toNamed(AppRoute.otpScreen);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
