import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import 'Controller/leaderboard_controller.dart';
import 'Model/leaderboard_model.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderboardController());

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

            // 2. MAIN LEADERBOARD CONTENT
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),

                    // HEADER TITLE
                    Center(
                      child: Text(
                        'Leaderboard',
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // SEGMENTED TAB SELECTOR (Weekly, Monthly, All Time)
                    _buildTabSelector(controller),

                    SizedBox(height: 16.h),

                    // LEADERBOARD CARDS LIST
                    Expanded(
                      child: Obx(() {
                        List<LeaderboardUserModel> currentList = [];
                        if (controller.selectedTabIndex.value == 0) {
                          currentList = controller.weeklyList;
                        } else if (controller.selectedTabIndex.value == 1) {
                          currentList = controller.monthlyList;
                        } else {
                          currentList = controller.allTimeList;
                        }

                        if (currentList.isEmpty) {
                          return Center(
                            child: Text(
                              'No players found',
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 14.sp,
                                color: Colors.white.withValues(alpha: 0.6),
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: currentList.length,
                          itemBuilder: (context, index) {
                            final user = currentList[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: _buildUserLeaderboardCard(user),
                            );
                          },
                        );
                      }),
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

  // ==================== SEGMENTED TAB SELECTOR ====================
  Widget _buildTabSelector(LeaderboardController controller) {
    final tabs = ['Weekly', 'Monthly', 'All Time'];

    return Container(
      height: 48.h,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFF094358).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Obx(
        () => Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = controller.selectedTabIndex.value == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF3358FE)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFF3358FE).withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            )
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 13.5.sp,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // ==================== USER LEADERBOARD CARD ====================
  Widget _buildUserLeaderboardCard(LeaderboardUserModel user) {
    return Container(
      height: 72.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF084156).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. RANK MEDAL / BADGE
          _buildRankBadge(user.rank),

          SizedBox(width: 10.w),

          // 2. AVATAR CIRCLE
          _buildAvatarCircle(user),

          SizedBox(width: 12.w),

          // 3. USER NAME & HANDLE
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  user.username,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF38E5D8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // 4. SCORE & POINTS LABEL
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${user.points}',
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF9E1B),
                ),
              ),
              Text(
                'POINTS',
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.55),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== RANK MEDAL BADGE ====================
  Widget _buildRankBadge(int rank) {
    if (rank == 1) {
      return Container(
        width: 24.w,
        height: 24.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFFD700), // Gold
        ),
        child: const Center(
          child: Text(
            '🥇',
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    } else if (rank == 2) {
      return Container(
        width: 24.w,
        height: 24.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFC0C0C0), // Silver
        ),
        child: const Center(
          child: Text(
            '🥈',
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    } else if (rank == 3) {
      return Container(
        width: 24.w,
        height: 24.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFCD7F32), // Bronze
        ),
        child: const Center(
          child: Text(
            '🥉',
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    }

    return SizedBox(
      width: 24.w,
      child: Center(
        child: Text(
          '#$rank',
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }

  // ==================== AVATAR CIRCLE ====================
  Widget _buildAvatarCircle(LeaderboardUserModel user) {
    final firstLetter = user.name.isNotEmpty ? user.name[0].toUpperCase() : 'ش';

    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFFF7A00),
          width: 1.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7A00).withValues(alpha: 0.3),
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: user.avatarUrl.isNotEmpty
            ? Image.network(
                user.avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildLetterAvatar(firstLetter),
              )
            : _buildLetterAvatar('ش'),
      ),
    );
  }

  Widget _buildLetterAvatar(String letter) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E1A68), Color(0xFF0F4C81)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
