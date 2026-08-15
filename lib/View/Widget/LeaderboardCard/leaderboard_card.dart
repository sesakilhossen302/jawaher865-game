import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utils/AppImg/app_img.dart';

class LeaderboardWinnerCard extends StatelessWidget {
  final String username;
  final String score;
  final String avatarText;
  final String? avatarImagePath;
  final VoidCallback? onTap;

  const LeaderboardWinnerCard({
    super.key,
    this.username = 'demo_user',
    this.score = '0',
    this.avatarText = 'ش',
    this.avatarImagePath,
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
          color: const Color(0xFF065967).withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: const Color(0xFF38E5D8), width: 1.5.w),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF38E5D8).withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // // Question mark ? watermark top right
            // Positioned(
            //   right: 12.w,
            //   top: 8.h,
            //   child: Text(
            //     '?',
            //     style: TextStyle(
            //       fontFamily: segoeFont,
            //       fontSize: 20.sp,
            //       fontWeight: FontWeight.bold,
            //       color: const Color(0xFF38E5D8).withValues(alpha: 0.30),
            //     ),
            //   ),
            // ),

            // // Question mark ? watermark bottom left
            // Positioned(
            //   left: 12.w,
            //   bottom: 8.h,
            //   child: Text(
            //     '?',
            //     style: TextStyle(
            //       fontFamily: segoeFont,
            //       fontSize: 20.sp,
            //       fontWeight: FontWeight.bold,
            //       color: const Color(0xFF38E5D8).withValues(alpha: 0.30),
            //     ),
            //   ),
            // ),

            // Main Content Column
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Medal Image
                  Image.asset(
                    AppImg.middleMedalImg,
                    width: 20.w,
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

                  SizedBox(height: 6.h),

                  // Avatar Circle with Cyan Border
                  Container(
                    width: 72.w,
                    height: 72.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF35B3E6),
                      border: Border.all(
                        color: const Color(0xFF5EE8F7),
                        width: 3.5.w,
                      ),
                    ),
                    child: Center(
                      child: avatarImagePath != null
                          ? SvgPicture.asset(avatarImagePath!)
                          : Text(
                              avatarText,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 10.h),

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

                  SizedBox(height: 4.h),

                  // Score
                  Text(
                    score,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF7A00),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
