import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/sign_controller.dart';

class SignScreen extends GetView<SignController> {
  const SignScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Global Background Image
          Positioned.fill(
            child: Image.asset(
              AppImg.globalBackground,
              fit: BoxFit.cover,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
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

                  const Spacer(flex: 1),

                  // Character & Logo Illustration Image
                  Image.asset(
                    AppImg.signPageImg,
                    width: 220.w,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(height: 120.h);
                    },
                  ),

                  SizedBox(height: 24.h),

                  // Buttons Section
                  Column(
                    children: [
                      // Continue with Google Button
                      _buildSocialButton(
                        onTap: () => controller.signInWithGoogle(),
                        iconPath: AppIcons.googleIcon,
                        label: StaticString.continueWithGoogle,
                        backgroundColor: const Color(
                          0xFF1E464C,
                        ).withValues(alpha: 0.7),
                        borderColor: const Color(
                          0xFF5CA2A6,
                        ).withValues(alpha: 0.4),
                        textColor: Colors.white,
                      ),

                      SizedBox(height: 14.h),

                      // Continue with Apple Button
                      _buildSocialButton(
                        onTap: () => controller.signInWithApple(),
                        iconPath: AppIcons.appleIcon,
                        label: StaticString.continueWithApple,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
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

                      // Sign in with Email Button
                      _buildActionButton(
                        onTap: () => controller.signInWithEmail(),
                        label: StaticString.signInWithEmail,
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF222222),
                      ),

                      SizedBox(height: 14.h),

                      // Continue as Guest Button
                      _buildActionButton(
                        onTap: () => controller.continueAsGuest(),
                        label: StaticString.continueAsGuest,
                        backgroundColor: const Color(0xFF3358FE),
                        textColor: Colors.white,
                        isBold: true,
                      ),
                    ],
                  ),

                  SizedBox(height: 75.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required String iconPath,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: borderColor != null
                ? BorderSide(color: borderColor, width: 1.w)
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22.w,
              height: 22.h,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.g_mobiledata, size: 24.sp, color: textColor);
              },
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    bool isBold = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 16.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
