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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.onBackToLobby();
        }
      },
      child: Scaffold(
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
    ),
    );
  }

  // PORTRAIT LAYOUT
  Widget _buildPortraitLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 10.h),

          // Top Back circular button
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: controller.onBackToLobby,
              child: Container(
                width: 38.w,
                height: 38.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Center(
                  child: Icon(Icons.arrow_back, color: Colors.black87, size: 20),
                ),
              ),
            ),
          ),

          const Spacer(flex: 1),

          // Challenge Your Melas illustration matching Figma Screen 4
          SvgPicture.asset(
            AppIcons.challengeYourMelasImg,
            height: 72.h,
            fit: BoxFit.contain,
          ),

          SizedBox(height: 20.h),

          // Clapping Hands Graphic 👏
          Text(
            '👏',
            style: TextStyle(
              fontSize: 60.sp,
            ),
          ),

          SizedBox(height: 24.h),

          // Congratulations Text
          Text(
            StaticString.congratulationsOnTheWin.tr.toUpperCase(),
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF222222),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          // Winner Name
          Obx(
            () => Text(
              controller.winnerName.value.toUpperCase(),
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(flex: 2),

          // Play Again & Back to Lobby Buttons
          _buildPlayAgainButton(isLandscape: false),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // LANDSCAPE LAYOUT (PERFECT SCALING MATCHING FIGMA)
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Side: Back button + Avatars illustration + Clapping 👏
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: controller.onBackToLobby,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back, color: Colors.black87, size: 18),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppIcons.challengeYourMelasImg,
                  height: 56,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                const Text('👏', style: TextStyle(fontSize: 42)),
                const Spacer(),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Right Side: Congratulations + Winner Name + Play Again + Back to Lobby
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StaticString.congratulationsOnTheWin.tr.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF222222),
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Obx(
                  () => Text(
                    controller.winnerName.value.toUpperCase(),
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.0,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPlayAgainButton(isLandscape: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PLAY AGAIN BUTTON PILL (Vibrant Green matching screenshot + Back to Lobby)
  Widget _buildPlayAgainButton({bool isLandscape = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: isLandscape ? 260 : double.infinity,
          height: isLandscape ? 42 : 50.h,
          child: ElevatedButton(
            onPressed: controller.onPlayAgain,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C853), // Vibrant Green matching screenshot
              elevation: 6,
              shadowColor: const Color(0xFF00C853).withValues(alpha: 0.45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26.r),
              ),
            ),
            child: Text(
              StaticString.playAgain.tr.toUpperCase(),
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 14 : 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        GestureDetector(
          onTap: controller.onBackToLobby,
          child: Text(
            'BACK TO LOBBY',
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF2C2416),
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
