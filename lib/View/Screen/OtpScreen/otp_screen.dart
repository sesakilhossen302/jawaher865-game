import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    // Custom Pinput Theme matching UI design
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 54.h,
      textStyle: TextStyle(
        fontFamily: segoeFont,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF065967).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF38E5D8), width: 1.5.w),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.white, width: 2.w),
      ),
    );

    final submittedPinTheme = defaultPinTheme;

    return Scaffold(
      // backgroundColor: const Color(0xFF00C9A7),
      body: Stack(
        children: [
          // Global Background Image (AppImg.globalBackground with BoxFit.fill)
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
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

                          // Title Text: Verify Your Email
                          Center(
                            child: Text(
                              StaticString.verifyYourEmail,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 28.h),

                          // Pinput 6-Digit OTP Field
                          Center(
                            child: Pinput(
                              length: 6,
                              controller: controller.pinController,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              separatorBuilder: (index) => SizedBox(width: 8.w),
                              showCursor: true,
                              onCompleted: (pin) => controller.verifyOtp(),
                            ),
                          ),

                          const Spacer(),

                          // Verify and Continue Button
                          SizedBox(
                            width: double.infinity,
                            height: 54.h,
                            child: ElevatedButton(
                              onPressed: controller.verifyOtp,
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
                                StaticString.verifyAndContinue,
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

                          // Resend Code Option
                          Center(
                            child: GestureDetector(
                              onTap: controller.resendCode,
                              child: Text(
                                StaticString.resendCode,
                                style: TextStyle(
                                  fontFamily: segoeFont,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFB4ECE7),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
