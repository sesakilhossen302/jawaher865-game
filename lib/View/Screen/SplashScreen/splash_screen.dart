import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import 'Controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppImg.welcomeBackground,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback gradient if background image fails to load
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00C9A7), Color(0xFF008080)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                );
              },
            ),
          ),

          // Center Splash Content (Character Images + Arabic Text + Indicator Dots)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome Splash Illustration & Logo Image
                Image.asset(
                  AppImg.welcomeSplashImg,
                  width: Get.width * 0.7,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 20.0),

                // Indicator Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDot(isLight: true),
                    const SizedBox(width: 8.0),
                    _buildDot(isActive: true),
                    const SizedBox(width: 8.0),
                    _buildDot(isLight: true),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({bool isActive = false, bool isLight = false}) {
    return Container(
      width: isActive ? 10.0 : 8.0,
      height: isActive ? 10.0 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? const Color(0xFF70E7DE)
            : (isLight ? const Color(0xFFBBEFEA).withValues(alpha: 0.7) : Colors.white70),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF70E7DE).withValues(alpha: 0.5),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
    );
  }
}
