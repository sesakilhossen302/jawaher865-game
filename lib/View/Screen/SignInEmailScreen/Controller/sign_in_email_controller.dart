import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
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
    Get.toNamed(AppRoute.otpScreen);
  }

  void continueAsGuest() {
    ToastMessage.showSuccessToast('Continuing as guest...');
  }

  void goToSignUp() {
    Get.toNamed(AppRoute.signUpScreen);
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
