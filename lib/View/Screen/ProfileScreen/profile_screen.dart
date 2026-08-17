import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Core/AppRoute/app_route.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

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

            // 2. MAIN PROFILE CONTENT (Scrollable & Non-overflowing)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),

                    // HEADER (Title + Settings Gear Icon)
                    _buildHeader(),

                    SizedBox(height: 16.h),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // HERO BLUE PROFILE CARD
                            _buildHeroProfileCard(controller),

                            SizedBox(height: 16.h),

                            // STATS ROW (Played, Won, Points)
                            _buildStatsRow(controller),

                            SizedBox(height: 18.h),

                            // RECENT GAMES SECTION HEADER
                            Text(
                              StaticString.recentGames.tr,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(height: 10.h),

                            // RECENT GAMES EMPTY CARD
                            _buildRecentGamesCard(),

                            SizedBox(height: 16.h),

                            // LANGUAGE TOGGLE ROW
                            _buildLanguageRow(controller),

                            SizedBox(height: 14.h),

                            // LOGOUT BUTTON CARD
                            _buildLogoutCard(controller),

                            SizedBox(height: 16.h),
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
        SizedBox(width: 24.w), // Spacer to balance gear icon
        Text(
          StaticString.profile.tr,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () => Get.toNamed(AppRoute.settingsScreen),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.settings_outlined,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
      ],
    );
  }

  // ==================== HERO PROFILE CARD ====================
  Widget _buildHeroProfileCard(ProfileController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF295AF5), Color(0xFF244CE3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2752E7).withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Decorative Subtle Circles
          Positioned(
            top: -20.h,
            right: -20.w,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -30.h,
            left: -20.w,
            child: Container(
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),

          // Main Profile Details Column
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar with Pencil Edit Badge
              Stack(
                children: [
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF7A00),
                        width: 1.8.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2E1A68), Color(0xFF0F4C81)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'ش',
                            style: TextStyle(
                              fontFamily: segoeFont,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Pencil Edit Icon Badge
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFF7A00),
                        border: Border.all(color: Colors.white, width: 1.w),
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              // Name
              Obx(
                () => Text(
                  controller.name.value,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              // Username
              Obx(
                () => Text(
                  controller.username.value,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 12.5.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Upgrade to Premium Button
              GestureDetector(
                onTap: controller.onUpgradePremium,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.landscape_rounded,
                        color: const Color(0xFFFFD700),
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        StaticString.upgradeToPremium.tr,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== STATS ROW ====================
  Widget _buildStatsRow(ProfileController controller) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => _buildStatBox(
              value: '${controller.gamesPlayed.value}',
              label: StaticString.played.tr,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Obx(
            () => _buildStatBox(
              value: '${controller.gamesWon.value}',
              label: StaticString.won.tr,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Obx(
            () => _buildStatBox(
              value: '${controller.totalPoints.value}',
              label: StaticString.points.tr,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox({required String value, required String label}) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== RECENT GAMES CARD ====================
  Widget _buildRecentGamesCard() {
    return Container(
      width: double.infinity,
      height: 140.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration Character Image
          Image.asset(
            AppImg.noGamesYetImg,
            height: 68.h,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.sports_esports_rounded,
                size: 48.sp,
                color: Colors.white.withValues(alpha: 0.5),
              );
            },
          ),
          SizedBox(height: 8.h),
          Text(
            StaticString.noGamesYetHitPlay.tr,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== LANGUAGE TOGGLE ROW ====================
  Widget _buildLanguageRow(ProfileController controller) {
    return Container(
      height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () {
              controller.currentLanguage.value;
              return Text(
                StaticString.language.tr,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            },
          ),

          // English / Arabic Toggle Pill
          Obx(
            () => Container(
              height: 36.h,
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                color: const Color(0xFF052A38),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // English Button
                  GestureDetector(
                    onTap: () => controller.toggleLanguage('English'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: controller.currentLanguage.value == 'English'
                            ? const Color(0xFF3358FE)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        StaticString.english.tr,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 12.5.sp,
                          fontWeight:
                              controller.currentLanguage.value == 'English'
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                          color: controller.currentLanguage.value == 'English'
                              ? Colors.white
                              : const Color(0xFF38E5D8),
                        ),
                      ),
                    ),
                  ),

                  // Arabic Button
                  GestureDetector(
                    onTap: () => controller.toggleLanguage('عربي'),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: controller.currentLanguage.value == 'عربي'
                            ? const Color(0xFF3358FE)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        StaticString.arabic.tr,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 12.5.sp,
                          fontWeight:
                              controller.currentLanguage.value == 'عربي'
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                          color: controller.currentLanguage.value == 'عربي'
                              ? Colors.white
                              : const Color(0xFF38E5D8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== LOGOUT CARD ====================
  Widget _buildLogoutCard(ProfileController controller) {
    return GestureDetector(
      onTap: controller.onLogout,
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A6372).withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.logoutIcon,
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFFE54124),
                BlendMode.srcIn,
              ),
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.logout_rounded,
                  color: const Color(0xFFE54124),
                  size: 20.sp,
                );
              },
            ),
            SizedBox(width: 12.w),
            Text(
              StaticString.logout.tr,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE54124),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
