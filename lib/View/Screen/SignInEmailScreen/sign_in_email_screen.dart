import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../../Widget/CustomGradientButton/custom_gradient_button.dart';
import 'Controller/sign_in_email_controller.dart';

class SignInEmailScreen extends GetView<SignInEmailController> {
  const SignInEmailScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // FULL PAGE BACKGROUND
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // CONTENT ON TOP OF BACKGROUND
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
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
                              StaticString.signInWithEmail.tr,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              StaticString.welcomeBackSubTitle.tr,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 13.sp,
                                color: const Color(0xFF4A3800),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Email Field Section
                      Text(
                        StaticString.email.tr,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF222222),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: controller.emailController,
                        hintText: StaticString.enterYourEmail.tr,
                        svgPrefixIcon: AppIcons.emailIcon,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 16.h),

                      // Password Field Section
                      Text(
                        StaticString.password.tr,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF222222),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Obx(
                        () => _buildTextField(
                          controller: controller.passwordController,
                          hintText: StaticString.enterYourPassword.tr,
                          svgPrefixIcon: AppIcons.passwordIcon,
                          isObscure: controller.isObscure.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isObscure.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFF5A4400).withValues(alpha: 0.75),
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
                                    activeColor: const Color(0xFFFF5252),
                                    checkColor: Colors.white,
                                    side: BorderSide(
                                      color: const Color(0xFF4A3800).withValues(alpha: 0.5),
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
                                  StaticString.rememberMe.tr,
                                  style: TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 13.sp,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Forgot Password Link
                          GestureDetector(
                            onTap: controller.goToForgotPassword,
                            child: Text(
                              StaticString.forgotPassword.tr,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF007AFF),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      // Sign In Button (Coral-Orange Gradient)
                      CustomGradientButton(
                        onTap: controller.signIn,
                        text: StaticString.signIn.tr,
                        height: 54.h,
                        borderRadius: BorderRadius.circular(25.r),
                      ),

                      SizedBox(height: 20.h),

                      // OR Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: const Color(0xFF4A3800).withValues(alpha: 0.25),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              StaticString.or.tr,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4A3800),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: const Color(0xFF4A3800).withValues(alpha: 0.25),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Continue as Guest Button (Solid Pure White)
                      Container(
                        width: double.infinity,
                        height: 54.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: controller.continueAsGuest,
                            borderRadius: BorderRadius.circular(25.r),
                            child: Center(
                              child: Text(
                                StaticString.continueAsGuest.tr,
                                style: TextStyle(
                                  fontFamily: segoeFont,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1E1E1E),
                                ),
                              ),
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
                                color: const Color(0xFF333333),
                              ),
                              children: [
                                TextSpan(text: StaticString.dontHaveAccount.tr),
                                TextSpan(
                                  text: StaticString.signUpBtn.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF007AFF),
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
            ),
          ],
        ),
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
      height: 52.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.40),
          width: 1.2.w,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 15.sp,
          color: const Color(0xFF222222),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: segoeFont,
            fontSize: 15.sp,
            color: const Color(0xFF5A4400).withValues(alpha: 0.65),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(14.r),
            child: SvgPicture.asset(
              svgPrefixIcon,
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                const Color(0xFF5A4400).withValues(alpha: 0.75),
                BlendMode.srcIn,
              ),
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.input,
                  color: const Color(0xFF5A4400).withValues(alpha: 0.75),
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
