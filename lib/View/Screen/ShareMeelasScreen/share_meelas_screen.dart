import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/share_meelas_controller.dart';

class ShareMeelasScreen extends StatelessWidget {
  const ShareMeelasScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShareMeelasController());

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. PERSISTENT GLOBAL BACKGROUND
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // 2. MAIN CONTENT WITH ORIENTATION SWITCHER
            SafeArea(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  final mediaSize = MediaQuery.of(context).size;
                  final isLandscape = orientation == Orientation.landscape ||
                      mediaSize.width > mediaSize.height;

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isLandscape
                        ? _buildLandscapeLayout(context, controller)
                        : _buildPortraitLayout(context, controller),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== PORTRAIT LAYOUT ====================
  Widget _buildPortraitLayout(
    BuildContext context,
    ShareMeelasController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 10.h),

          // 1. TOP HEADER
          _buildHeader(),

          SizedBox(height: 8.h),

          // 2. SUBTITLE
          _buildSubtitle(),

          SizedBox(height: 36.h),

          // 3. QR CODE CARD BOX
          _buildQrCodeCard(isLandscape: false),

          SizedBox(height: 32.h),

          // 4. SHAREABLE LINK CONTAINER WITH COPY BUTTON
          _buildShareLinkBox(controller, isLandscape: false),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // ==================== LANDSCAPE LAYOUT ====================
  Widget _buildLandscapeLayout(
    BuildContext context,
    ShareMeelasController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // 1. TOP HEADER
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  StaticString.shareMeelas,
                  style: const TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // 2. SUBTITLE
          Text(
            StaticString.myCommunityTagline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 14),

          // 3. CENTER CONTENT IN LANDSCAPE (QR Code & Share Box)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildQrCodeCard(isLandscape: true),
                  const SizedBox(height: 16),
                  _buildShareLinkBox(controller, isLandscape: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HEADER ====================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 16.sp,
              ),
            ),
          ),
        ),
        Text(
          StaticString.shareMeelas.tr,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 36.w), // Balance back button
      ],
    );
  }

  // ==================== SUBTITLE ====================
  Widget _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        StaticString.myCommunityTagline,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 12.sp,
          color: Colors.white.withValues(alpha: 0.8),
          height: 1.3,
        ),
      ),
    );
  }

  // ==================== QR CODE CARD ====================
  Widget _buildQrCodeCard({required bool isLandscape}) {
    final double boxSize = isLandscape ? 160.0 : 220.w;

    return Container(
      width: boxSize,
      height: boxSize,
      padding: EdgeInsets.all(isLandscape ? 14 : 20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF095264).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.4),
          width: 1.5.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: CustomPaint(
          size: Size(boxSize * 0.8, boxSize * 0.8),
          painter: QrCodePainter(),
        ),
      ),
    );
  }

  // ==================== SHARE LINK BOX WITH COPY BUTTON ====================
  Widget _buildShareLinkBox(
    ShareMeelasController controller, {
    required bool isLandscape,
  }) {
    return Container(
      width: isLandscape ? 360 : double.infinity,
      padding: EdgeInsets.all(isLandscape ? 10 : 12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF084156).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
      ),
      child: Container(
        height: isLandscape ? 40 : 48.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0C4D5D),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Obx(
                () => Text(
                  controller.shareLink.value,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 12 : 14.sp,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: controller.copyLinkToClipboard,
              child: Icon(
                Icons.copy_rounded,
                color: Colors.white.withValues(alpha: 0.85),
                size: isLandscape ? 18 : 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== CUSTOM QR CODE PAINTER ====================
class QrCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final double width = size.width;
    final double height = size.height;

    // Draw Corner Position Detection Squares
    void drawPositionSquare(double x, double y, double sqSize) {
      // Outer square
      canvas.drawRect(Rect.fromLTWH(x, y, sqSize, sqSize), paint);
      // Inner clear space
      final clearPaint = Paint()..color = const Color(0xFF095264);
      canvas.drawRect(
        Rect.fromLTWH(
          x + sqSize * 0.15,
          y + sqSize * 0.15,
          sqSize * 0.7,
          sqSize * 0.7,
        ),
        clearPaint,
      );
      // Center solid square
      canvas.drawRect(
        Rect.fromLTWH(
          x + sqSize * 0.3,
          y + sqSize * 0.3,
          sqSize * 0.4,
          sqSize * 0.4,
        ),
        paint,
      );
    }

    final double posSize = width * 0.28;

    // Top-Left Position Square
    drawPositionSquare(0, 0, posSize);
    // Top-Right Position Square
    drawPositionSquare(width - posSize, 0, posSize);
    // Bottom-Left Position Square
    drawPositionSquare(0, height - posSize, posSize);

    // Draw Random Decorative Data Dots (Pattern matching QR)
    final double dotSize = width * 0.055;
    for (int r = 0; r < 14; r++) {
      for (int c = 0; c < 14; c++) {
        final double x = c * (width / 14);
        final double y = r * (height / 14);

        // Skip corners where position squares exist
        if ((r < 4 && c < 4) ||
            (r < 4 && c > 9) ||
            (r > 9 && c < 4)) {
          continue;
        }

        // Pseudo-random pattern for QR code fill
        if ((r + c * 3) % 2 == 0 || (r * 2 + c) % 3 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(x + 1, y + 1, dotSize, dotSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
