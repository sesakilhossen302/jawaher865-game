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

                      // Illustration Image Section
                      Center(
                        child: Image.asset(
                          AppImg.signPageImg,
                          width: 280.w,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox(height: 200.h);
                          },
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Social Login Options (Google & Apple)
                      Column(
                        children: [
                          _buildSocialButton(
                            onTap: () => controller.signInWithGoogle(),
                            iconPath: AppIcons.googleIcon,
                            label: StaticString.continueWithGoogle.tr,
                            backgroundColor: const Color(
                              0xFF065967,
                            ).withValues(alpha: 0.85),
                            textColor: Colors.white,
                          ),

                          SizedBox(height: 14.h),

                          _buildSocialButton(
                            onTap: () => controller.signInWithApple(),
                            iconPath: AppIcons.appleIcon,
                            label: StaticString.continueWithApple.tr,
                            backgroundColor: const Color(
                              0xFF065967,
                            ).withValues(alpha: 0.85),
                            textColor: Colors.white,
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Divider with 'OR' Text
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color(0xFF38E5D8),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              StaticString.or.tr,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Color(0xFF38E5D8),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Sign in with Email Button
                      _buildActionButton(
                        onTap: () => controller.signInWithEmail(),
                        label: StaticString.signInWithEmail.tr,
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF222222),
                      ),

                      SizedBox(height: 14.h),

                      // Continue as Guest Button
                      _buildActionButton(
                        onTap: () => controller.continueAsGuest(),
                        label: StaticString.continueAsGuest.tr,
                        backgroundColor: const Color(0xFF3358FE),
                        textColor: Colors.white,
                        isBold: true,
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
      height: 54.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
            side: BorderSide(
              color: borderColor ?? const Color(0xFF38E5D8),
              width: 1.5.w,
            ),
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
      height: 54.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
            side: BorderSide(color: const Color(0xFF38E5D8), width: 1.5.w),
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
