import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/sign_up_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C9A7),
      body: Stack(
        children: [
          // Global Background Image
          Positioned.fill(
            child: Image.asset(
              AppImg.globalBackground,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00C9A7), Color(0xFF008080)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                );
              },
            ),
          ),

          // Main Screen Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),

                  // Top Navigation Bar / Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.backIcon,
                          width: 16.w,
                          height: 16.h,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.arrow_back_ios_new,
                              size: 16.sp,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Character & Logo Illustration Image
                  Center(
                    child: Image.asset(
                      AppImg.signPageImg,
                      width: 160.w,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox(height: 90.h);
                      },
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Title Text: Create a new account
                  Center(
                    child: Text(
                      StaticString.createNewAccount,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 1. Full Name Field
                  _buildFormInputField(
                    controller: controller.fullNameController,
                    hintText: StaticString.fullName,
                    svgIconPath: AppIcons.fullNameIcon,
                  ),

                  SizedBox(height: 14.h),

                  // 2. Date of Birth Field
                  _buildFormInputField(
                    controller: controller.dateOfBirthController,
                    hintText: StaticString.dateOfBirth,
                    svgIconPath: AppIcons.dateOfBirthIcon,
                    readOnly: true,
                    onTap: () => controller.selectDateOfBirth(context),
                    suffixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: 20.sp,
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // 3. Gender Field
                  _buildFormInputField(
                    controller: controller.genderController,
                    hintText: StaticString.gender,
                    svgIconPath: AppIcons.genderIcon,
                    readOnly: true,
                    onTap: () => controller.selectGender(context),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: 24.sp,
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // 4. Contact No Field
                  _buildFormInputField(
                    controller: controller.contactNoController,
                    hintText: StaticString.contactNo,
                    svgIconPath: AppIcons.contactNoIcon,
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 14.h),

                  // 5. Email Field
                  _buildFormInputField(
                    controller: controller.emailController,
                    hintText: StaticString.email,
                    svgIconPath: AppIcons.emailUpIcon,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 14.h),

                  // 6. Password Field
                  Obx(
                    () => _buildFormInputField(
                      controller: controller.passwordController,
                      hintText: StaticString.password,
                      svgIconPath: AppIcons.passwordUpIcon,
                      isObscure: controller.isPasswordObscure.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordObscure.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 20.sp,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // 7. Confirm Password Field
                  Obx(
                    () => _buildFormInputField(
                      controller: controller.confirmPasswordController,
                      hintText: StaticString.confirmPassword,
                      svgIconPath: AppIcons.passwordUpIcon,
                      isObscure: controller.isConfirmPasswordObscure.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordObscure.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 20.sp,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Terms of Service & Privacy Policy Checkbox Row
                  Row(
                    children: [
                      Obx(
                        () => SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: Checkbox(
                            value: controller.isAgreeTerms.value,
                            onChanged: controller.toggleAgreeTerms,
                            activeColor: const Color(0xFF3358FE),
                            checkColor: Colors.white,
                            side: BorderSide(
                              color: Colors.white.withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.toggleAgreeTerms(
                            !controller.isAgreeTerms.value,
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 12.sp,
                                color: const Color(0xFFB4ECE7),
                              ),
                              children: [
                                const TextSpan(text: StaticString.iAgreeWith),
                                TextSpan(
                                  text: StaticString.termsOfService,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const TextSpan(text: StaticString.and),
                                TextSpan(
                                  text: StaticString.privacyPolicy,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: controller.signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3358FE),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                          side: BorderSide(
                            color: const Color(0xFF38E5D8),
                            width: 1.5.w,
                          ),
                        ),
                      ),
                      child: Text(
                        StaticString.signUp,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Footer: have an account? Log in
                  Center(
                    child: GestureDetector(
                      onTap: controller.goToLogin,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 14.sp,
                            color: const Color(0xFFB4ECE7),
                          ),
                          children: [
                            const TextSpan(text: StaticString.haveAnAccount),
                            TextSpan(
                              text: StaticString.logIn,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormInputField({
    required TextEditingController controller,
    required String hintText,
    required String svgIconPath,
    bool isObscure = false,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: const Color(0xFF065967).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: const Color(0xFF38E5D8),
          width: 1.5.w,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 14.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: segoeFont,
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.8),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(14.r),
            child: SvgPicture.asset(
              svgIconPath,
              width: 18.w,
              height: 18.h,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.input,
                  color: Colors.white,
                  size: 20.sp,
                );
              },
            ),
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 16.w,
          ),
        ),
      ),
    );
  }
}
