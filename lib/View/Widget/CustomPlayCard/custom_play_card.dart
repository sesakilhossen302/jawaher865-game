import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utils/AppIcons/app_icons.dart';

class CustomPlayCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String? leftSvgPath;
  final String? rightSvgPath;
  final double? height;
  final double? width;
  final List<Color>? gradientColors;
  final Color? borderColor;

  const CustomPlayCard({
    super.key,
    this.title = 'Play',
    required this.onTap,
    this.leftSvgPath,
    this.rightSvgPath,
    this.height,
    this.width,
    this.gradientColors,
    this.borderColor,
  });

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 180.h;
    final effectiveWidth = width ?? double.infinity;
    final effectiveGradient =
        gradientColors ?? const [Color(0xFF009EA0), Color(0xFF38E5D8)];
    final effectiveBorderColor = borderColor ?? const Color(0xFF38E5D8);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: effectiveHeight,
        width: effectiveWidth,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            colors: effectiveGradient,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          border: Border.all(color: effectiveBorderColor, width: 1.5.w),
          boxShadow: [
            BoxShadow(
              color: effectiveBorderColor.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ============================================
            // 1. TRANSLUCENT DECORATIVE CIRCLES (GOL GOL BUBBLES)
            // ============================================

            // Circle 1: Top-Left Overflow Bubble
            Positioned(
              left: -35.w,
              top: -35.h,
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF4A7FFF).withValues(alpha: 0.40),
                ),
              ),
            ),

            // Circle 2: Top-Right Bubble (Previous white color)
            Positioned(
              right: 40.w,
              top: -25.h,
              child: Container(
                width: 125.w,
                height: 125.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.14),
                ),
              ),
            ),

            // Circle 3: Bottom-Right Overflow Bubble
            Positioned(
              right: -45.w,
              bottom: -45.h,
              child: Container(
                width: 180.w,
                height: 180.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF4A7FFF).withValues(alpha: 0.35),
                ),
              ),
            ),

            // // Question mark ? watermark top right
            // Positioned(
            //   right: 14.w,
            //   top: 10.h,
            //   child: Text(
            //     '?',
            //     style: TextStyle(
            //       fontFamily: segoeFont,
            //       fontSize: 20.sp,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white.withValues(alpha: 0.25),
            //     ),
            //   ),
            // ),

            // Question mark ? watermark bottom left
            // Positioned(
            //   left: 14.w,
            //   bottom: 10.h,
            //   child: Text(
            //     '?',
            //     style: TextStyle(
            //       fontFamily: segoeFont,
            //       fontSize: 18.sp,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.white.withValues(alpha: 0.20),
            //     ),
            //   ),
            // ),

            // ============================================
            // 2. FOREGROUND ILLUSTRATIONS & PLAY BUTTON
            // ============================================

            // Left Character SVG
            Positioned(
              left: 5.w,
              bottom: 0,
              child: SvgPicture.asset(
                leftSvgPath ?? AppIcons.singleMaleImg,
                height: 130.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),

            // Right Character SVG
            Positioned(
              right: 10.w,
              bottom: 0,
              child: SvgPicture.asset(
                rightSvgPath ?? AppIcons.singleFemaleImg,
                height: 130.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),

            // Center Play Button & Title
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.2),
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
