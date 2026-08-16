import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/winning_controller.dart';

class WinningScreen extends GetView<WinningController> {
  const WinningScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WinningController>()) {
      Get.put(WinningController());
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. GLOBAL BACKGROUND IMAGE
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // 2. CONFETTI OVERLAY SVG (Portrait vs Landscape)
            Positioned.fill(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  final isPortrait = orientation == Orientation.portrait;
                  return SvgPicture.asset(
                    isPortrait
                        ? AppIcons.normalWinningImg
                        : AppIcons.rautetWinningImg,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox();
                    },
                  );
                },
              ),
            ),

            // 3. MAIN WINNER CONTENT LAYER WITH SMOOTH ROTATION
            SafeArea(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  final isPortrait = orientation == Orientation.portrait;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isPortrait
                        ? SizedBox(
                            key: const ValueKey('win_portrait'),
                            child: _buildPortraitLayout(),
                          )
                        : SizedBox(
                            key: const ValueKey('win_landscape'),
                            child: _buildLandscapeLayout(),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PORTRAIT LAYOUT
  Widget _buildPortraitLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),

          // Congratulations Text
          Text(
            StaticString.congratulationsOnTheWin,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 6.h),

          // Winner Name
          Obx(
            () => Text(
              controller.winnerName.value,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 26.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 24.h),

          // Winner Card Box
          _buildWinnerCard(isLandscape: false),

          const Spacer(flex: 3),

          // Play Again Button
          _buildPlayAgainButton(isLandscape: false),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // LANDSCAPE LAYOUT (PERFECT SCALING)
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8),

          // Congratulations Text
          Text(
            StaticString.congratulationsOnTheWin,
            style: const TextStyle(
              fontFamily: segoeFont,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          // Winner Name
          Obx(
            () => Text(
              controller.winnerName.value,
              style: const TextStyle(
                fontFamily: segoeFont,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10),

          // Winner Card Box
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: _buildWinnerCard(isLandscape: true),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Play Again Button
          _buildPlayAgainButton(isLandscape: true),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // WINNER CARD WIDGET
  Widget _buildWinnerCard({required bool isLandscape}) {
    return Container(
      width: isLandscape ? 300 : 260.w,
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 20 : 20.w,
        vertical: isLandscape ? 12 : 24.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF065967).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(isLandscape ? 20 : 28.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar Circle Container (Square logical pixels ensure PERFECT ROUND CIRCLE)
          Container(
            width: isLandscape ? 64 : 110.w,
            height: isLandscape ? 64 : 110.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF003875),
              border: Border.all(
                color: const Color(0xFF38E5D8),
                width: 2.w,
              ),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.winnerAvatarInitials.value,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 26 : 42.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: isLandscape ? 10 : 20.h),

          // Star Icon & Score Display
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gold Star Badge
              Container(
                width: isLandscape ? 24 : 28.w,
                height: isLandscape ? 24 : 28.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFBBF24),
                ),
                child: Center(
                  child: Icon(
                    Icons.star_rounded,
                    color: Colors.white,
                    size: isLandscape ? 16 : 20.sp,
                  ),
                ),
              ),

              SizedBox(width: isLandscape ? 8 : 8.w),

              // Score Text
              Obx(
                () => Text(
                  controller.winnerScore.value.toString(),
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 20 : 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // PLAY AGAIN BUTTON PILL
  Widget _buildPlayAgainButton({bool isLandscape = false}) {
    return SizedBox(
      width: isLandscape ? 260 : 280.w,
      height: isLandscape ? 42 : 50.h,
      child: ElevatedButton(
        onPressed: controller.onPlayAgain,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3358FE),
          elevation: 6,
          shadowColor: const Color(0xFF3358FE).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: Text(
          StaticString.playAgain,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: isLandscape ? 14 : 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
