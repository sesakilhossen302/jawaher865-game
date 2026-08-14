import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/ToastMessage/toast_message.dart';

class SignInEmailController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isObscure = true.obs;
  final RxBool rememberMe = false.obs;

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  void signIn() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty) {
      ToastMessage.showErrorToast('Please enter your email');
      return;
    }

    if (password.isEmpty) {
      ToastMessage.showErrorToast('Please enter your password');
      return;
    }

    ToastMessage.showSuccessToast('Signing in...');
  }

  void continueAsGuest() {
    ToastMessage.showSuccessToast('Continuing as guest...');
  }

  void goToSignUp() {
    ToastMessage.showSuccessToast('Navigate to Sign Up');
  }

  void goToForgotPassword() {
    ToastMessage.showSuccessToast('Navigate to Forgot Password');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
