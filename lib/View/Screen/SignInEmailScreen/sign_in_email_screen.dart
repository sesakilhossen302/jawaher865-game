import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/sign_in_email_controller.dart';

class SignInEmailScreen extends GetView<SignInEmailController> {
  const SignInEmailScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C9A7),
      body: Stack(
        children: [
          // Full-Screen Seamless Background Image
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
                  SizedBox(height: 10.h),

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

                  // SizedBox(height: 10.h),

                  // Character & Logo Illustration Image
                  Center(
                    child: Image.asset(
                      AppImg.welcomeSplashImg,
                      width: 200.w,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox(height: 100.h);
                      },
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Title & Subtitle Text
                  Center(
                    child: Column(
                      children: [
                        Text(
                          StaticString.signInWithEmail,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          StaticString.welcomeBackSubTitle,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 13.sp,
                            color: const Color(0xFFB4ECE7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Email Field Section
                  Text(
                    StaticString.email,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildTextField(
                    controller: controller.emailController,
                    hintText: StaticString.enterYourEmail,
                    svgPrefixIcon: AppIcons.emailIcon,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 16.h),

                  // Password Field Section
                  Text(
                    StaticString.password,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Obx(
                    () => _buildTextField(
                      controller: controller.passwordController,
                      hintText: StaticString.enterYourPassword,
                      svgPrefixIcon: AppIcons.passwordIcon,
                      isObscure: controller.isObscure.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscure.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 20.sp,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Remember Me & Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Remember Me Checkbox
                      Row(
                        children: [
                          Obx(
                            () => SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: controller.toggleRememberMe,
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
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () => controller.toggleRememberMe(
                              !controller.rememberMe.value,
                            ),
                            child: Text(
                              StaticString.rememberMe,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 13.sp,
                                color: const Color(0xFFB4ECE7),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Forgot Password Link
                      GestureDetector(
                        onTap: controller.goToForgotPassword,
                        child: Text(
                          StaticString.forgotPassword,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFFB4ECE7),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: controller.signIn,
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
                        StaticString.signIn,
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

                  // OR Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white.withValues(alpha: 0.35),
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          StaticString.or,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.8),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white.withValues(alpha: 0.35),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Continue as Guest Button
                  SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: controller.continueAsGuest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF065967,
                        ).withValues(alpha: 0.85),
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
                        StaticString.continueAsGuest,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 28.h),

                  // Footer: Don't have an account? Sign up
                  Center(
                    child: GestureDetector(
                      onTap: controller.goToSignUp,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 14.sp,
                            color: const Color(0xFFB4ECE7),
                          ),
                          children: [
                            const TextSpan(text: StaticString.dontHaveAccount),
                            TextSpan(
                              text: StaticString.signUp,
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

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String svgPrefixIcon,
    bool isObscure = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 54.h,
      decoration: BoxDecoration(
        color: const Color(0xFF065967).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFF38E5D8), width: 1.5.w),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 15.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: segoeFont,
            fontSize: 15.sp,
            color: Colors.white.withValues(alpha: 0.9),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(14.r),
            child: SvgPicture.asset(
              svgPrefixIcon,
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.input, color: Colors.white, size: 20.sp);
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
