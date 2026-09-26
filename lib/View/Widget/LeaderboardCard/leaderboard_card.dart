import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utils/AppImg/app_img.dart';

class LeaderboardWinnerCard extends StatelessWidget {
  final String username;
  final String score;
  final String avatarText;
  final String? avatarImagePath;
  final String? leftImagePath;
  final String? rightImagePath;
  final VoidCallback? onTap;

  const LeaderboardWinnerCard({
    super.key,
    this.username = 'demo_user',
    this.score = '0',
    this.avatarText = 'ش',
    this.avatarImagePath,
    this.leftImagePath,
    this.rightImagePath,
    this.onTap,
  });

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF4848),
              Color(0xFFFF7A00),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF4848).withValues(alpha: 0.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Left Character Illustration (Elderly Man with Phone - 7-Photoroom 2.png)
            Positioned(
              left: 2.w,
              bottom: 0,
              child: Image.asset(
                leftImagePath ?? AppImg.leaderboardLeftElderlyImg,
                height: 84.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),

            // Right Character Illustration (Young Man in Blue with Phone - 2-Photoroom 1.png)
            Positioned(
              right: 2.w,
              bottom: 0,
              child: Image.asset(
                rightImagePath ?? AppImg.leaderboardRightYoungManImg,
                height: 96.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),

            // Main Content Column
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Medal Image
                  Image.asset(
                    AppImg.middleMedalImg,
                    width: 22.w,
                    height: 28.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.military_tech,
                        color: const Color(0xFFFFD700),
                        size: 24.sp,
                      );
                    },
                  ),

                  SizedBox(height: 4.h),

                  // Avatar Circle with Golden/Yellow Border
                  Container(
                    width: 68.w,
                    height: 68.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFF5B800),
                      border: Border.all(
                        color: const Color(0xFFFFE57F),
                        width: 3.5.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: avatarImagePath != null
                          ? SvgPicture.asset(avatarImagePath!)
                          : Text(
                              avatarText,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Username
                  Text(
                    username,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  if (score != '0') ...[
                    SizedBox(height: 4.h),
                    // Score
                    Text(
                      score,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
