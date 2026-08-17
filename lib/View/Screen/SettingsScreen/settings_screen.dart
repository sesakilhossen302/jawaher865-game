import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

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

            // 2. MAIN SETTINGS CONTENT
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),

                    // TOP APP BAR (Back Button + Centered Title)
                    _buildHeader(),

                    SizedBox(height: 24.h),

                    // UNIFIED SETTINGS MENU CONTAINER CARD
                    _buildSettingsCard(controller),
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
          StaticString.settings.tr,
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

  // ==================== SETTINGS CARD ====================
  Widget _buildSettingsCard(SettingsController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20.r),
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
          _buildMenuItem(
            svgIcon: AppIcons.passwordIcon,
            title: StaticString.changePassword.tr,
            onTap: controller.onChangePassword,
          ),
          _buildDivider(),
          _buildMenuItem(
            svgIcon: AppIcons.contactSupportIcon,
            title: StaticString.contactSupport.tr,
            onTap: controller.onContactSupport,
          ),
          _buildDivider(),
          _buildMenuItem(
            svgIcon: AppIcons.termsConditionsIcon,
            title: StaticString.termsAndConditions.tr,
            onTap: controller.onTermsAndConditions,
          ),
          _buildDivider(),
          _buildMenuItem(
            svgIcon: AppIcons.privacyPolicyIcon,
            title: StaticString.privacyPolicy.tr,
            onTap: controller.onPrivacyPolicy,
          ),
          _buildDivider(),
          _buildMenuItem(
            svgIcon: AppIcons.deleteAccountIcon,
            title: StaticString.deleteAccount.tr,
            onTap: controller.onDeleteAccount,
          ),
          _buildDivider(),
          _buildMenuItem(
            svgIcon: AppIcons.logoutIcon,
            title: StaticString.logOutCaps.tr,
            onTap: controller.onLogout,
          ),
        ],
      ),
    );
  }

  // ==================== MENU ITEM TILE ====================
  Widget _buildMenuItem({
    required String svgIcon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        child: Row(
          children: [
            // Left SVG Icon
            SvgPicture.asset(
              svgIcon,
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20.sp,
                );
              },
            ),
            SizedBox(width: 16.w),

            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 14.5.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            // Right Chevron Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF38E5D8).withValues(alpha: 0.9),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== DIVIDER ====================
  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: const Color(0xFF38E5D8).withValues(alpha: 0.25),
    );
  }
}
