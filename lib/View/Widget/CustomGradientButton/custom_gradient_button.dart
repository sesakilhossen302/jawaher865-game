import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Utils/AppColors/app_colors.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final Widget? icon;
  final List<Color>? gradientColors;
  final Color textColor;
  final bool isBold;
  final double? fontSize;
  final String fontFamily;

  const CustomGradientButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height,
    this.width,
    this.borderRadius,
    this.icon,
    this.gradientColors,
    this.textColor = Colors.white,
    this.isBold = true,
    this.fontSize,
    this.fontFamily = 'Segoe UI',
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(25.r);
    final effectiveColors = gradientColors ?? AppColors.primaryGradient;

    return Container(
      width: width ?? double.infinity,
      height: height ?? 52.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: effectiveColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: effectiveRadius,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF5252).withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveRadius,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  icon!,
                  SizedBox(width: 10.w),
                ],
                Text(
                  text,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: fontSize ?? 16.sp,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                    color: textColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
