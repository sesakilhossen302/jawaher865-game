import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../OnlineGameScreen/Model/online_game_model.dart';
import 'Controller/vs_match_controller.dart';

class VsMatchScreen extends StatelessWidget {
  const VsMatchScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VsMatchController());

    return Scaffold(
      backgroundColor: const Color(0xFFFBBF24),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. GLOBAL BACKGROUND IMAGE (Warm Yellow Theme)
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // 2. BOTTOM 3 CHARACTERS ILLUSTRATION (Matching Figma Screen 2)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                child: SvgPicture.asset(
                  AppIcons.challengeYourMelasImg,
                  height: 115.h,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),

            // 3. MAIN CONTENT LAYER
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10.h),

                  // TOP APP BAR (Back Button & Centered "Online Game" Title)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 38.w,
                            height: 38.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.3),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.4),
                                width: 1.2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          StaticString.onlineGame.tr,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(width: 38.w), // Balance back button
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // SUBTITLE MATCHING SCREENSHOT
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      StaticString.createChampionshipTagline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                        height: 1.35,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // TEAMS & VS MATCH SECTION
                  Expanded(
                    child: Obx(() {
                      final team1 = controller.matchData.value?.team1 ?? [];
                      final team2 = controller.matchData.value?.team2 ?? [];

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            // TEAM GREEN PLAYERS (TOP)
                            ...team1.map(
                              (player) => Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: _buildPlayerPill(
                                  player: player,
                                  gradientColors: const [
                                    Color(0xFF00C853),
                                    Color(0xFF10B981),
                                  ],
                                  borderColor: const Color(0xFF69F0AE),
                                  shadowColor: const Color(0xFF00C853),
                                ),
                              ),
                            ),

                            SizedBox(height: 8.h),

                            // VS DIVIDER WITH DASHED LINES
                            _buildVsDivider(),

                            SizedBox(height: 8.h),

                            // TEAM RED PLAYERS (BOTTOM)
                            ...team2.map(
                              (player) => Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: _buildPlayerPill(
                                  player: player,
                                  gradientColors: const [
                                    Color(0xFFFF4848),
                                    Color(0xFFFF7A00),
                                  ],
                                  borderColor: const Color(0xFFFF8B74),
                                  shadowColor: const Color(0xFFFF4848),
                                ),
                              ),
                            ),

                            SizedBox(height: 14.h),

                            // TAP ANYWHERE / CONTINUE HINT
                            GestureDetector(
                              onTap: controller.navigateToNextScreen,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.35),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Starting Match...',
                                      style: TextStyle(
                                        fontFamily: segoeFont,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 100.h), // Space for bottom illustration
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PLAYER PILL (GREEN OR RED GRADIENT)
  Widget _buildPlayerPill({
    required OnlinePlayerModel player,
    required List<Color> gradientColors,
    required Color borderColor,
    required Color shadowColor,
  }) {
    final firstLetter = player.name.isNotEmpty
        ? player.name[0].toUpperCase()
        : '?';

    return Container(
      width: double.infinity,
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular Avatar (Image or First Letter Initial)
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: player.avatarUrl.isNotEmpty
                  ? Image.network(
                      player.avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(
                          firstLetter,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: gradientColors.first,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        firstLetter,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: gradientColors.first,
                        ),
                      ),
                    ),
            ),
          ),

          SizedBox(width: 12.w),

          // Player Name
          Expanded(
            child: Text(
              player.name,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Subtle Active Dot
          Container(
            width: 10.w,
            height: 10.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 6.w),
        ],
      ),
    );
  }

  // VS DIVIDER WITH DASHED LINES
  Widget _buildVsDivider() {
    return Row(
      children: [
        Expanded(
          child: CustomPaint(
            size: Size(double.infinity, 2.h),
            painter: WhiteDashedLinePainter(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Text(
            StaticString.vsText,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 26.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 1.5),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: CustomPaint(
            size: Size(double.infinity, 2.h),
            painter: WhiteDashedLinePainter(),
          ),
        ),
      ],
    );
  }
}

// WHITE DASHED LINE PAINTER
class WhiteDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const dashWidth = 7.0;
    const dashSpace = 5.0;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
