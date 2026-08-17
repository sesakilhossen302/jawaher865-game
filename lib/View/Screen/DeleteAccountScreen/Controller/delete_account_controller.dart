import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';

class DeleteAccountController extends GetxController {
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  final RxBool isPasswordVisible = false.obs;

  static const String segoeFont = 'Segoe UI';

  @override
  void onInit() {
    super.onInit();
    // Lock DeleteAccountScreen strictly to Portrait mode ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void onContinue() {
    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your password to confirm deletion',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    // Show custom OTP Modal matching UI screenshot
    showOtpModal();
  }

  void showOtpModal() {
    final defaultPinTheme = PinTheme(
      width: 42.w,
      height: 46.h,
      textStyle: TextStyle(
        fontFamily: segoeFont,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF076372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.6),
          width: 1.w,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Colors.white, width: 1.8.w),
      ),
    );

    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00BFA5), Color(0xFF076372)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: const Color(0xFF38E5D8).withValues(alpha: 0.6),
              width: 1.2.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TOP ACCOUNT DELETION SVG ICON
              SvgPicture.asset(
                AppIcons.accountDeletionRequestIcon,
                height: 64.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.smartphone_rounded,
                    size: 64.sp,
                    color: Colors.white,
                  );
                },
              ),

              SizedBox(height: 16.h),

              // Title: Account Deletion Request
              Text(
                StaticString.accountDeletionRequest.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 6.h),

              // Subtitle: We've Sent a Code to exa...@email.com
              Text(
                StaticString.codeSentToEmailSub.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),

              SizedBox(height: 20.h),

              // 6-DIGIT PINPUT FIELD
              Pinput(
                length: 6,
                controller: otpController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                separatorBuilder: (index) => SizedBox(width: 6.w),
                showCursor: true,
              ),

              SizedBox(height: 24.h),

              // Delete Account Blue Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: confirmAccountDeletion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3358FE),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  child: Text(
                    StaticString.deleteAccountBtn.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // Cancel Dark Cyan Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF076372).withValues(alpha: 0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      side: BorderSide(
                        color: const Color(0xFF38E5D8).withValues(alpha: 0.6),
                        width: 1.w,
                      ),
                    ),
                  ),
                  child: Text(
                    StaticString.cancel.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void confirmAccountDeletion() {
    if (otpController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Please enter 6-digit OTP code',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFE54124),
        colorText: Colors.white,
      );
      return;
    }

    Get.back(); // close dialog
    Get.offAllNamed(AppRoute.signScreen);
  }

  @override
  void onClose() {
    passwordController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
