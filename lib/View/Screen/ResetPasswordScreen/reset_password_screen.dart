import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/reset_password_controller.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

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
                      SizedBox(height: 12.h),

                      // Back Button
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

                      SizedBox(height: 20.h),

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

                      SizedBox(height: 24.h),

                      // Reset Password Title
                      Center(
                        child: Text(
                          StaticString.resetPasswordTitle.tr,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // Password Field
                      Obx(
                        () => _buildInputField(
                          controller: controller.passwordController,
                          hintText: StaticString.password.tr,
                          svgPrefixIcon: AppIcons.passwordUpIcon,
                          isObscure: controller.isPasswordObscure.value,
                          onSuffixTap: controller.togglePasswordVisibility,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Confirm Password Field
                      Obx(
                        () => _buildInputField(
                          controller: controller.confirmPasswordController,
                          hintText: StaticString.confirmPassword.tr,
                          svgPrefixIcon: AppIcons.passwordUpIcon,
                          isObscure: controller.isConfirmPasswordObscure.value,
                          onSuffixTap: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Update and Continue Button
                      SizedBox(
                        width: double.infinity,
                        height: 54.h,
                        child: ElevatedButton(
                          onPressed: controller.updateAndContinue,
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
                            StaticString.updateAndContinue.tr,
                            style: TextStyle(
                              fontFamily: segoeFont,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40.h),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required String svgPrefixIcon,
    required bool isObscure,
    required VoidCallback onSuffixTap,
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
                return Icon(Icons.lock_outline, color: Colors.white, size: 20.sp);
              },
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isObscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.white.withValues(alpha: 0.9),
              size: 20.sp,
            ),
            onPressed: onSuffixTap,
          ),
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
