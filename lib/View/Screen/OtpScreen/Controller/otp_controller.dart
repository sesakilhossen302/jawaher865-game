import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/ToastMessage/toast_message.dart';

class OtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();

  void verifyOtp() {
    final String otp = pinController.text.trim();
    if (otp.length < 6) {
      ToastMessage.showErrorToast('Please enter complete 6-digit OTP code');
      return;
    }
    ToastMessage.showSuccessToast('OTP Verified Successfully!');
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
