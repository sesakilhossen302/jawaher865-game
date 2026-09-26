import 'package:flutter/material.dart';

class AppColors {
  // Theme Primary & Brand Colors
  static const Color primaryColor = Color(0xFFFF5252);
  static const Color primaryOrange = Color(0xFFFF7A00);
  static const Color secondaryColor = Color(0xFF26A69A);
  static const Color backgroundColor = Color(0xFFF7D646);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);

  // Gradient Colors for Primary CTA Buttons (Matching Provided Designs)
  static const List<Color> primaryGradient = [
    Color(0xFFFF4848),
    Color(0xFFFF7A00),
  ];

  // Auth & Form Field Theme Colors
  static Color fieldBackground = Colors.white.withValues(alpha: 0.22);
  static Color fieldBorder = Colors.white.withValues(alpha: 0.40);
  static const Color fieldHintText = Color(0x995A4400);
  static const Color textDark = Color(0xFF222222);
  static const Color textSubDark = Color(0xFF4A3800);
  static const Color linkBlue = Color(0xFF007AFF);
  static const Color guestButtonBg = Color(0xFFFFFFFF);
  static const Color appleButtonBg = Color(0xFF222222);

  // General Text and Feedback Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);
  static const Color border = Color(0xFFE0E0E0);
}

