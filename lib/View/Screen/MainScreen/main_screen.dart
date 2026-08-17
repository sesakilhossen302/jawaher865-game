import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../HomeScreen/home_screen.dart';
import '../LeaderboardScreen/leaderboard_screen.dart';
import '../PlayScreen/play_screen.dart';
import '../ProfileScreen/profile_screen.dart';
import 'Controller/main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MainController>()) {
      Get.put(MainController());
    }

    final List<Widget> pages = [
      const HomeScreen(),
      const PlayScreen(),
      const LeaderboardScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // PERSISETENT FULL PAGE BACKGROUND (NO WHITE FLASH ON TAB SWITCH)
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // TAB CONTENT + PERSISTENT BOTTOM NAVBAR
            SafeArea(
              child: Column(
                children: [
                  // INDEXED STACK PRESERVES TAB STATE & ELIMINATES ROUTE TRANSITION FLICKER
                  Expanded(
                    child: Obx(
                      () => IndexedStack(
                        index: controller.selectedIndex.value,
                        children: pages,
                      ),
                    ),
                  ),

                  // UNIFIED PERSISTENT BOTTOM NAVIGATION BAR
                  Obx(
                    () {
                      controller.currentLang.value;
                      return Container(
                        height: 70.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF065967).withValues(alpha: 0.95),
                          border: Border(
                            top: BorderSide(
                              color: const Color(0xFF38E5D8),
                              width: 1.5.w,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildNavItem(
                              index: 0,
                              label: StaticString.home.tr,
                              iconPath: AppIcons.homeNavbarIcon,
                              fallbackIcon: Icons.home_filled,
                            ),
                            _buildNavItem(
                              index: 1,
                              label: StaticString.play.tr,
                              iconPath: AppIcons.playNavbarIcon,
                              fallbackIcon: Icons.sports_esports,
                            ),
                            _buildNavItem(
                              index: 2,
                              label: StaticString.leaderboard.tr,
                              iconPath: AppIcons.leaderboardNavbarIcon,
                              fallbackIcon: Icons.leaderboard,
                            ),
                            _buildNavItem(
                              index: 3,
                              label: StaticString.profile.tr,
                              iconPath: AppIcons.profileNavbarIcon,
                              fallbackIcon: Icons.person,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String iconPath,
    required IconData fallbackIcon,
  }) {
    final isSelected = controller.selectedIndex.value == index;
    final activeColor = Colors.white;
    final inactiveColor = Colors.white.withValues(alpha: 0.45);

    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22.w,
              height: 22.h,
              colorFilter: ColorFilter.mode(
                isSelected ? activeColor : inactiveColor,
                BlendMode.srcIn,
              ),
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  fallbackIcon,
                  size: 22.sp,
                  color: isSelected ? activeColor : inactiveColor,
                );
              },
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
