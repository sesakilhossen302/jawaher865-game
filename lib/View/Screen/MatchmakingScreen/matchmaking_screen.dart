import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    // Continuous pulse wave animation
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

            // 2. MAIN CONTENT LAYER
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 8.h),

                  // TOP APP BAR (Back Button & Play Title)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF38E5D8).withValues(alpha: 0.25),
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
                          ),
                        ),
                        SizedBox(width: 36.w),
                      ],
                    ),
                  ),

                  // 3. CENTER DYNAMIC MATCHMAKING AREA (PERFECT TARGET-CENTERED CONCENTRIC RINGS)
                  Expanded(
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // CONCENTRIC RADAR RINGS PAINTER
                          AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return CustomPaint(
                                size: Size(540.w, 540.w),
                                painter: DynamicConcentricRadarPainter(
                                  progress: _pulseController.value,
                                ),
                              );
                            },
                          ),

                          // CENTER CONTENT COLUMN (TARGET ICON + STATUS TEXT)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Center Target Circle Container (85.w x 85.w)
                              Container(
                                width: 85.w,
                                height: 85.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF064D5B),
                                  border: Border.all(
                                    color: const Color(0xFF38E5D8)
                                        .withValues(alpha: 0.5),
                                    width: 2.w,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF38E5D8)
                                          .withValues(alpha: 0.35),
                                      blurRadius: 22,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: CustomPaint(
                                    size: Size(44.w, 44.w),
                                    painter: TargetCrosshairPainter(),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10.h),

                              // Opponent Found / Searching Status Text
                              Obx(
                                () => Text(
                                  controller.statusText.value,
                                  style: TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              SizedBox(height: 3.h),

                              // Connecting Subtitle
                              Obx(
                                () => Text(
                                  controller.subText.value,
                                  style: TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withValues(alpha: 0.85),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// EXACT TARGET CROSSHAIR PAINTER MATCHING SCREENSHOT DESIGN
class TargetCrosshairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.36;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    // Outer Circle
    canvas.drawCircle(center, radius, paint);

    // Center Solid Dot
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 4.0, dotPaint);

    // 4 Ticks at top, bottom, left, right
    const tickLen = 6.0;
    // Top tick
    canvas.drawLine(
      Offset(center.dx, center.dy - radius - tickLen),
      Offset(center.dx, center.dy - radius + 2),
      paint,
    );
    // Bottom tick
    canvas.drawLine(
      Offset(center.dx, center.dy + radius - 2),
      Offset(center.dx, center.dy + radius + tickLen),
      paint,
    );
    // Left tick
    canvas.drawLine(
      Offset(center.dx - radius - tickLen, center.dy),
      Offset(center.dx - radius + 2, center.dy),
      paint,
    );
    // Right tick
    canvas.drawLine(
      Offset(center.dx + radius - 2, center.dy),
      Offset(center.dx + radius + tickLen, center.dy),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant TargetCrosshairPainter oldDelegate) => false;
}

// PERFECTLY CENTERED CONCENTRIC RADAR PAINTER
class DynamicConcentricRadarPainter extends CustomPainter {
  final double progress;

  DynamicConcentricRadarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Exact center point of the Target Icon Circle
    final center = Offset(size.width / 2, size.height / 2 - 27.5.h);

    final ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Ring 1 (Inner ring perfectly centered around 85.w target circle): radius = 50.w
    canvas.drawCircle(center, 50.w, ringPaint);

    // Ring 2 (Middle ring ENCLOSING target icon AND text group): radius = 140.w
    canvas.drawCircle(center, 140.w, ringPaint);

    // Ring 3 (Outer ring reaching outer screen area): radius = 240.w
    canvas.drawCircle(center, 240.w, ringPaint);

    // Animated Pulsing Ripple Wave starting from target circle outwards
    final waveRadius = 50.w + (170.w * progress);
    final wavePaint = Paint()
      ..color = const Color(0xFF38E5D8).withValues(alpha: (1.0 - progress) * 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, waveRadius, wavePaint);

    // DYNAMIC FLOATING QUESTION MARKS ALONG CONCENTRIC RINGS USING TRIGONOMETRY
    void drawQuestionMark(
      double radius,
      double angleDegrees,
      double opacity,
      double fontSize,
    ) {
      final rad = angleDegrees * math.pi / 180;
      final pos = Offset(
        center.dx + radius * math.cos(rad),
        center.dy + radius * math.sin(rad),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: '?',
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: opacity),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(pos.dx - textPainter.width / 2, pos.dy - textPainter.height / 2),
      );
    }

    // Draw floating question marks dynamically placed along concentric radar rings
    drawQuestionMark(210.w, 225, 0.35, 18.sp); // Top-Left
    drawQuestionMark(195.w, 310, 0.35, 17.sp); // Top-Right
    drawQuestionMark(160.w, 15, 0.40, 18.sp);  // Mid-Right
    drawQuestionMark(230.w, 125, 0.35, 17.sp); // Bottom-Right
    drawQuestionMark(215.w, 200, 0.30, 16.sp); // Mid-Left
    drawQuestionMark(250.w, 145, 0.25, 15.sp); // Bottom-Left
  }

  @override
  bool shouldRepaint(covariant DynamicConcentricRadarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
