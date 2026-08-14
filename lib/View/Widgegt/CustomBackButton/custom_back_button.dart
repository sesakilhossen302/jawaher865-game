import 'package:flutter/material.dart';
import '../../../Utils/AppColors/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color color;

  const CustomBackButton({
    super.key,
    this.onTap,
    this.color = AppColors.blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.of(context).pop(),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: color,
          size: 18.0,
        ),
      ),
    );
  }
}
