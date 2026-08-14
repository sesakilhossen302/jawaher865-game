import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class SignUpController extends GetxController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final RxBool isPasswordObscure = true.obs;
  final RxBool isConfirmPasswordObscure = true.obs;
  final RxBool isAgreeTerms = false.obs;

  void togglePasswordVisibility() {
    isPasswordObscure.value = !isPasswordObscure.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscure.value = !isConfirmPasswordObscure.value;
  }

  void toggleAgreeTerms(bool? value) {
    isAgreeTerms.value = value ?? false;
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dateOfBirthController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void selectGender(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Color(0xFF065967),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Male', style: TextStyle(color: Colors.white)),
              onTap: () {
                genderController.text = 'Male';
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Female', style: TextStyle(color: Colors.white)),
              onTap: () {
                genderController.text = 'Female';
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Other', style: TextStyle(color: Colors.white)),
              onTap: () {
                genderController.text = 'Other';
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void signUp() {
    Get.toNamed(AppRoute.otpScreen);
  }

  void goToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    dateOfBirthController.dispose();
    genderController.dispose();
    contactNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
