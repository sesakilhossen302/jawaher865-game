import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/ToastMessage/toast_message.dart';

class OtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();

  void verifyOtp() {
    Get.toNamed(AppRoute.resetPasswordScreen);
  }

  void resendCode() {
    ToastMessage.showSuccessToast('Verification code resent to your email!');
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}
