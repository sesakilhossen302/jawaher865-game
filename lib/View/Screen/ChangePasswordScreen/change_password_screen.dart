import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

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

                    SizedBox(height: 12.h),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            // HERO ILLUSTRATION IMAGE
                            _buildHeroIllustration(),

                            SizedBox(height: 16.h),

                            // FORM BOX CARD
                            _buildFormCard(controller),

                            SizedBox(height: 24.h),

                            // SAVE & CHANGE BUTTON
                            _buildSaveButton(controller),

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
          StaticString.changePassword.tr,
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

  // ==================== HERO ILLUSTRATION ====================
  Widget _buildHeroIllustration() {
    return Container(
      height: 160.h,
      width: double.infinity,
      alignment: Alignment.center,
      child: Image.asset(
        AppImg.changePasswordImg,
        height: 150.h,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.lock_reset_rounded,
            size: 80.sp,
            color: Colors.white.withValues(alpha: 0.8),
          );
        },
      ),
    );
  }

  // ==================== FORM CARD ====================
  Widget _buildFormCard(ChangePasswordController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Title
          Text(
            StaticString.changePassword.tr,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // 1. Old Password Field
          _buildFieldLabel(StaticString.oldPassword.tr),
          SizedBox(height: 6.h),
          Obx(
            () => _buildPasswordField(
              textController: controller.oldPasswordController,
              hintText: StaticString.oldPassword.tr,
              isVisible: controller.isOldPasswordVisible.value,
              onToggleVisibility: controller.toggleOldPasswordVisibility,
            ),
          ),

          SizedBox(height: 14.h),

          // 2. New Password Field
          _buildFieldLabel(StaticString.newPassword.tr),
          SizedBox(height: 6.h),
          Obx(
            () => _buildPasswordField(
              textController: controller.newPasswordController,
              hintText: StaticString.password.tr,
              isVisible: controller.isNewPasswordVisible.value,
              onToggleVisibility: controller.toggleNewPasswordVisibility,
            ),
          ),

          SizedBox(height: 14.h),

          // 3. Confirm Password Field
          _buildFieldLabel(StaticString.confirmPassword.tr),
          SizedBox(height: 6.h),
          Obx(
            () => _buildPasswordField(
              textController: controller.confirmPasswordController,
              hintText: StaticString.confirmPassword.tr,
              isVisible: controller.isConfirmPasswordVisible.value,
              onToggleVisibility: controller.toggleConfirmPasswordVisibility,
            ),
          ),
        ],
      ),
    );
  }

  // FIELD LABEL WIDGET
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: segoeFont,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white.withValues(alpha: 0.9),
      ),
    );
  }

  // PASSWORD INPUT FIELD WIDGET
  Widget _buildPasswordField({
    required TextEditingController textController,
    required String hintText,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
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
        controller: textController,
        obscureText: !isVisible,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 14.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          prefixIcon: Icon(
            Icons.lock_outline_rounded,
            color: Colors.white.withValues(alpha: 0.8),
            size: 18.sp,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: segoeFont,
            fontSize: 13.5.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
          suffixIcon: IconButton(
            onPressed: onToggleVisibility,
            icon: Icon(
              isVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.white.withValues(alpha: 0.7),
              size: 18.sp,
            ),
          ),
        ),
      ),
    );
  }

  // ==================== SAVE BUTTON ====================
  Widget _buildSaveButton(ChangePasswordController controller) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: controller.onSaveAndChange,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3358FE),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        child: Text(
          StaticString.saveAndChange.tr,
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
