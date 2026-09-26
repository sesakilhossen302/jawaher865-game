import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../../Widget/CustomGradientButton/custom_gradient_button.dart';
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

                      // Social Login Options (Google, Apple, Email)
                      Column(
                        children: [
                          // Continue with Google Button (Golden translucent glass)
                          _buildCustomButton(
                            onTap: () => controller.signInWithGoogle(),
                            icon: SvgPicture.asset(
                              AppIcons.googleIcon,
                              width: 20.w,
                              height: 20.h,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.g_mobiledata,
                                  size: 24.sp,
                                  color: const Color(0xFF222222),
                                );
                              },
                            ),
                            label: StaticString.continueWithGoogle.tr,
                            backgroundColor: Colors.white.withValues(alpha: 0.25),
                            borderColor: Colors.white.withValues(alpha: 0.40),
                            textColor: const Color(0xFF222222),
                          ),

                          SizedBox(height: 14.h),

                          // Continue with Apple Button (Dark charcoal/black)
                          _buildCustomButton(
                            onTap: () => controller.signInWithApple(),
                            icon: SvgPicture.asset(
                              AppIcons.appleIcon,
                              width: 20.w,
                              height: 20.h,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.apple,
                                  size: 22.sp,
                                  color: Colors.white,
                                );
                              },
                            ),
                            label: StaticString.continueWithApple.tr,
                            backgroundColor: const Color(0xFF222222),
                            borderColor: Colors.transparent,
                            textColor: Colors.white,
                          ),

                          SizedBox(height: 14.h),

                          // Continue with Email Button (Red-Orange Gradient)
                          CustomGradientButton(
                            onTap: () => controller.signInWithEmail(),
                            text: StaticString.continueWithEmail.tr,
                            height: 54.h,
                            borderRadius: BorderRadius.circular(25.r),
                            icon: SvgPicture.asset(
                              AppIcons.emailIcon,
                              width: 18.w,
                              height: 18.h,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.email_outlined,
                                  size: 18.sp,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 18.h),

                      // Divider with 'OR' Text
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
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4A3800),
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

                      SizedBox(height: 18.h),

                      // Continue as Guest Button (Solid Pure White)
                      _buildCustomButton(
                        onTap: () => controller.continueAsGuest(),
                        label: StaticString.continueAsGuest.tr,
                        backgroundColor: Colors.white,
                        borderColor: Colors.transparent,
                        textColor: const Color(0xFF1E1E1E),
                        isBold: true,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
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

  Widget _buildCustomButton({
    required VoidCallback onTap,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
    Widget? icon,
    bool isBold = false,
    List<BoxShadow>? boxShadow,
  }) {
    return Container(
      width: double.infinity,
      height: 54.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25.r),
        border: borderColor != null && borderColor != Colors.transparent
            ? Border.all(color: borderColor, width: 1.2.w)
            : null,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(25.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon,
                SizedBox(width: 12.w),
              ],
              Text(
                label,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 15.sp,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
