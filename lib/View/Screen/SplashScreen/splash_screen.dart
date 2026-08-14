import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import 'Controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure SplashController is initialized and timer starts
    if (!Get.isRegistered<SplashController>()) {
      Get.put(SplashController());
    } else {
      Get.find<SplashController>();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF00C9A7),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: ClipRect(
              child: Transform.scale(
                scale: 1.4,
                alignment: Alignment.topCenter,
                child: Image.asset(
                  AppImg.welcomeBackground,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
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
            ),
          ),

          // Center Splash Content (Character Images + Arabic Text + Animated Loading Dots)
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
                const SizedBox(height: 24.0),

                // Animated Glowing Loading Dots
                const SpinKitThreeBounce(
                  color: Color(0xFF70E7DE),
                  size: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
