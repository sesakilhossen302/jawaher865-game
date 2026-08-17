import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
import '../../../../Utils/StaticString/static_string.dart';
import '../../MainScreen/Controller/main_controller.dart';

class ProfileController extends GetxController {
  final RxString name = 'demo_user'.obs;
  final RxString username = '@demo_user'.obs;
  final RxInt gamesPlayed = 0.obs;
  final RxInt gamesWon = 0.obs;
  final RxInt totalPoints = 0.obs;
  final RxString currentLanguage = 'English'.obs; // 'English' or 'عربي'

  static const String segoeFont = 'Segoe UI';

  @override
  void onInit() {
    super.onInit();
    // Lock Profile Screen to Portrait mode ONLY
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void toggleLanguage(String lang) {
    currentLanguage.value = lang;
    if (Get.isRegistered<MainController>()) {
      Get.find<MainController>().currentLang.value = lang;
    }
    if (lang == 'عربي') {
      Get.updateLocale(const Locale('ar', 'SA'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }

  void onUpgradePremium() {
    Get.snackbar(
      'Premium Upgrade',
      'Upgrade to Premium feature coming soon!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF3358FE),
      colorText: Colors.white,
    );
  }

  void onLogout() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00BFA5), Color(0xFF076372)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: const Color(0xFF38E5D8).withValues(alpha: 0.6),
              width: 1.2.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TOP LOGOUT SVG ICON
              SvgPicture.asset(
                AppIcons.logoutIcon,
                height: 64.h,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.exit_to_app_rounded,
                    color: Colors.white,
                    size: 64.sp,
                  );
                },
              ),

              SizedBox(height: 20.h),

              // Title: Do you want to log out of your profile?
              Text(
                StaticString.doYouWantToLogOut.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 24.h),

              // Log Out Blue Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                    ]);
                    Get.offAllNamed(AppRoute.signScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3358FE),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                  child: Text(
                    StaticString.logOutBtn.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // Cancel Dark Cyan Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF076372,
                    ).withValues(alpha: 0.5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      side: BorderSide(
                        color: const Color(0xFF38E5D8).withValues(alpha: 0.6),
                        width: 1.w,
                      ),
                    ),
                  ),
                  child: Text(
                    StaticString.cancel.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
