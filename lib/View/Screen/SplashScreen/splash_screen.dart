import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import 'Controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SplashController>()) {
      Get.put(SplashController());
    } else {
      Get.find<SplashController>();
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // FULL PAGE BACKGROUND
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // Center Splash Content (Scrollable & Non-overflowing)
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Welcome Splash Illustration & Logo Image
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: Get.width * 0.75,
                          maxHeight: Get.height * 0.5,
                        ),
                        child: Image.asset(
                          AppImg.welcomeSplashImg,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox();
                          },
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Animated Glowing Loading Dots
                      const SpinKitThreeBounce(
                        color: Color(0xFF70E7DE),
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
