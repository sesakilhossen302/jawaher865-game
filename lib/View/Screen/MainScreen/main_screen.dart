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
            Column(
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

                // UNIFIED PERSISTENT BOTTOM NAVIGATION BAR (EXTENDS FLUSH TO BOTTOM EDGE)
                Obx(
                  () {
                    controller.currentLang.value;
                    final bottomPadding = MediaQuery.of(context).padding.bottom;
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: bottomPadding),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0BB02),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.35),
                            width: 1.w,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 10,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 72.h,
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
                      ),
                    );
                  },
                ),
              ],
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

    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 75.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular 3D Glossy Badge with Active White Glowing Ring
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 2.2.w,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.65),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isSelected ? 1.0 : 0.55,
                  child: SvgPicture.asset(
                    iconPath,
                    width: 38.w,
                    height: 38.w,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        fallbackIcon,
                        size: 24.sp,
                        color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
                      );
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: 3.h),

            // Tab Text Label
            Text(
              label,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
