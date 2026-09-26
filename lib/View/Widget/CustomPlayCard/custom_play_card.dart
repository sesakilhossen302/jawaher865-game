import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';

class CustomPlayCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String? leftSvgPath;
  final String? rightSvgPath;
  final String? leftImagePath;
  final String? rightImagePath;
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
    this.leftImagePath,
    this.rightImagePath,
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
        gradientColors ?? const [Color(0xFFFF4848), Color(0xFFFF7A00)];
    final effectiveBorderColor = borderColor ?? Colors.transparent;

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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: effectiveBorderColor != Colors.transparent
              ? Border.all(color: effectiveBorderColor, width: 1.5.w)
              : null,
          boxShadow: [
            BoxShadow(
              color: effectiveGradient.first.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ============================================
            // 1. TRANSLUCENT DECORATIVE CIRCLES
            // ============================================

            // Circle 1: Top-Left Bubble
            Positioned(
              left: -35.w,
              top: -35.h,
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
            ),

            // Circle 2: Top-Right Bubble
            Positioned(
              right: 40.w,
              top: -25.h,
              child: Container(
                width: 125.w,
                height: 125.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
            ),

            // Circle 3: Bottom-Right Bubble
            Positioned(
              right: -45.w,
              bottom: -45.h,
              child: Container(
                width: 180.w,
                height: 180.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
            ),

            // ============================================
            // 2. FOREGROUND ILLUSTRATIONS & PLAY BUTTON
            // ============================================

            // Left Character (Male)
            Positioned(
              left: 5.w,
              bottom: 0,
              child: _buildCharacter(
                imagePath: leftImagePath,
                svgPath: leftSvgPath ?? AppIcons.singleMaleImg,
                height: 130.h,
              ),
            ),

            // Right Character (Female - 9-Photoroom 1.png)
            Positioned(
              right: 6.w,
              bottom: 0,
              child: _buildCharacter(
                imagePath: rightImagePath ??
                    (rightSvgPath == null ? AppImg.playRightFemaleImg : null),
                svgPath: rightSvgPath,
                height: 140.h,
              ),
            ),

            // Center Play Button & Title (Green Circular Play Button)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56.w,
                    height: 56.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF00C853),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00C853).withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
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

  Widget _buildCharacter({
    String? imagePath,
    String? svgPath,
    required double height,
  }) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.asset(
        imagePath,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const SizedBox(),
      );
    }
    if (svgPath != null && svgPath.isNotEmpty) {
      return SvgPicture.asset(
        svgPath,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const SizedBox(),
      );
    }
    return const SizedBox();
  }
}
