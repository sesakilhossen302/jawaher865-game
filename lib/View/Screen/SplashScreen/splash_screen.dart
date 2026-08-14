import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/AppColors/app_colors.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flash_on,
              size: 80.0,
              color: AppColors.whiteColor,
            ),
            SizedBox(height: 16.0),
            Text(
              StaticString.appName,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              StaticString.splashTagline,
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
