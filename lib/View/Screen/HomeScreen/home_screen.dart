import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../../Widget/CustomPlayCard/custom_play_card.dart';
import '../../Widget/LeaderboardCard/leaderboard_card.dart';
import 'Controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<HomeController>()) {
      Get.put(HomeController());
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),

          // 1. TOP HEADER BAR (User Info + Language Switcher)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // User Profile Badge Card
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF065967).withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: const Color(0xFF38E5D8),
                    width: 1.5.w,
                  ),
                ),
                child: Row(
                  children: [
                    // Circle Avatar Initials
                    Container(
                      width: 38.w,
                      height: 38.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF009EA0),
                      ),
                      child: Center(
                        child: Text(
                          'ش',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    // Username & Tag
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Jhon',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '@Jhon_Do',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 11.sp,
                            color: const Color(0xFFB4ECE7),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ),

              // Language Selector Badge Pill
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF065967).withValues(alpha: 0.85),
                  border: Border.all(
                    color: const Color(0xFF38E5D8),
                    width: 1.5.w,
                  ),
                ),
                child: Center(
                  child: Text(
                    'EN',
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // 2. BRANDING LOGO & SUBTITLE (AOF)
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  AppIcons.nameIconsInHomePage,
                  width: 180.w,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(height: 60.h);
                  },
                ),
                SizedBox(height: 6.h),
                Text(
                  StaticString.aofText,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // 3. REUSABLE CUSTOM PLAY GAME CARD BANNER
          CustomPlayCard(
            title: StaticString.play,
            onTap: controller.onPlayTap,
            leftSvgPath: AppIcons.singleMaleImg,
            rightSvgPath: AppIcons.singleFemaleImg,
          ),

          SizedBox(height: 24.h),

          // 4. LEADERBOARD HEADER ROW (Title + View All)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.leaderboardCupIcon,
                    width: 32.w,
                    height: 32.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.emoji_events,
                        color: const Color(0xFFFF7A00),
                        size: 28.sp,
                      );
                    },
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    StaticString.leaderboard,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // View All Button Pill
              GestureDetector(
                onTap: controller.onViewAllLeaderboardTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF065967).withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFF38E5D8).withValues(alpha: 0.4),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        StaticString.viewAll,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 10.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // 5. LEADERBOARD WINNER CARD WIDGET
          LeaderboardWinnerCard(
            username: 'demo_user',
            score: '0',
            avatarText: 'ش',
            onTap: controller.onViewAllLeaderboardTap,
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
