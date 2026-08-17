import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/delete_account_controller.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeleteAccountController());

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. PERSISTENT GLOBAL BACKGROUND
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // 2. MAIN CONTENT (Scrollable)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),

                    // TOP APP BAR
                    _buildHeader(),

                    SizedBox(height: 20.h),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            // FORM CARD BOX (With Image Inside)
                            _buildFormCard(controller),

                            SizedBox(height: 24.h),

                            // CONTINUE BUTTON
                            _buildContinueButton(controller),

                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== HEADER ====================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
        ),
        Text(
          StaticString.deleteAccount.tr,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 36.w), // Balance back button
      ],
    );
  }

  // ==================== FORM CARD ====================
  Widget _buildFormCard(DeleteAccountController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 8.h),

          // Illustration Image inside Card (Matching Figma)
          Image.asset(
            AppImg.wantToDeleteAccountImg,
            height: 150.h,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.delete_forever_rounded,
                size: 80.sp,
                color: Colors.white.withValues(alpha: 0.85),
              );
            },
          ),

          SizedBox(height: 16.h),

          // Main Warning Title
          Text(
            StaticString.wantToDeleteAccount.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 8.h),

          // Subtitle Explanation
          Text(
            StaticString.confirmPasswordToRemoveAccount.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.3,
            ),
          ),

          SizedBox(height: 20.h),

          // Form Label (Enter password)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StaticString.enterPassword.tr,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Password Input Field
          Obx(
            () => Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF0A6372).withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
                  width: 1.w,
                ),
              ),
              child: TextField(
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible.value,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 14.w,
                  ),
                  hintText: StaticString.password.tr,
                  hintStyle: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 13.5.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  suffixIcon: IconButton(
                    onPressed: controller.togglePasswordVisibility,
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 6.h),
        ],
      ),
    );
  }

  // ==================== CONTINUE BUTTON ====================
  Widget _buildContinueButton(DeleteAccountController controller) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: controller.onContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3358FE),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        child: Text(
          StaticString.continueBtn.tr,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
