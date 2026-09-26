import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/matchmaking_controller.dart';

class MatchmakingScreen extends StatefulWidget {
  const MatchmakingScreen({super.key});

  @override
  State<MatchmakingScreen> createState() => _MatchmakingScreenState();
}

class _MatchmakingScreenState extends State<MatchmakingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  static const String segoeFont = 'Segoe UI';

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MatchmakingController());

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

            // 2. BOTTOM CHARACTERS ILLUSTRATION (Snowboard girl + Binocular man matching 01_radar.png)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                top: false,
                child: SvgPicture.asset(
                  AppIcons.challengeOtherMelasesImg,
                  height: 155.h,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),

            // 3. MAIN INTERACTIVE CONTENT LAYER
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10.h),

                  // TOP APP BAR (Back Button & Centered "Play" Title)
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
                          StaticString.play.tr,
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

                  // 4. CENTER CONCENTRIC RADAR RINGS & TARGET ICON
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.skipToMatch,
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // RADAR CONCENTRIC RINGS
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return CustomPaint(
                                  size: Size(320.w, 320.w),
                                  painter: GoldenRadarPainter(
                                    progress: _pulseController.value,
                                  ),
                                );
                              },
                            ),

                            // CENTER TARGET BADGE & STATUS TEXT
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Golden Target Badge
                                Container(
                                  width: 74.w,
                                  height: 74.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFFB300),
                                        Color(0xFFFF8F00),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFF8F00)
                                            .withValues(alpha: 0.45),
                                        blurRadius: 18,
                                        spreadRadius: 3,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: CustomPaint(
                                      size: Size(38.w, 38.w),
                                      painter: RadarTargetPainter(),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 14.h),

                                // Status Text
                                Obx(
                                  () => Text(
                                    controller.statusText.value,
                                    style: TextStyle(
                                      fontFamily: segoeFont,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: -0.2,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.25),
                                          blurRadius: 4,
                                          offset: const Offset(0, 1.5),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                // Subtext
                                Obx(
                                  () => Text(
                                    controller.subText.value,
                                    style: TextStyle(
                                      fontFamily: segoeFont,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withValues(alpha: 0.9),
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.2),
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Space for bottom illustration
                  SizedBox(height: 120.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TARGET CROSSHAIR PAINTER MATCHING FIGMA SCREEN 1
class RadarTargetPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.36;

    // Pink/Coral Ring
    final ringPaint = Paint()
      ..color = const Color(0xFFFF4848)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(center, radius, ringPaint);

    // Cyan/Blue Center Dot
    final dotPaint = Paint()
      ..color = const Color(0xFF1E88E5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 4.0, dotPaint);

    // 4 Coral Crosshair Ticks
    const tickLen = 6.0;
    // Top
    canvas.drawLine(
      Offset(center.dx, center.dy - radius - tickLen),
      Offset(center.dx, center.dy - radius + 2),
      ringPaint,
    );
    // Bottom
    canvas.drawLine(
      Offset(center.dx, center.dy + radius - 2),
      Offset(center.dx, center.dy + radius + tickLen),
      ringPaint,
    );
    // Left
    canvas.drawLine(
      Offset(center.dx - radius - tickLen, center.dy),
      Offset(center.dx - radius + 2, center.dy),
      ringPaint,
    );
    // Right
    canvas.drawLine(
      Offset(center.dx + radius - 2, center.dy),
      Offset(center.dx + radius + tickLen, center.dy),
      ringPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RadarTargetPainter oldDelegate) => false;
}

// GOLDEN CONCENTRIC RADAR RINGS PAINTER
class GoldenRadarPainter extends CustomPainter {
  final double progress;

  GoldenRadarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 24.h);

    final ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    // Fixed rings
    canvas.drawCircle(center, 55.w, ringPaint);
    canvas.drawCircle(center, 105.w, ringPaint);
    canvas.drawCircle(center, 155.w, ringPaint);

    // Animated ripple wave expanding outwards
    final waveRadius = 55.w + (105.w * progress);
    final wavePaint = Paint()
      ..color = Colors.white.withValues(alpha: (1.0 - progress) * 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, waveRadius, wavePaint);
  }

  @override
  bool shouldRepaint(covariant GoldenRadarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
