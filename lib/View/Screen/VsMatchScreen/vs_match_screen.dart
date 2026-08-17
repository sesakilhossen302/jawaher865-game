import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

    return PopScope(
      canPop: false,
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

              // 2. MAIN CONTENT LAYER WITH ORIENTATION SWITCHER
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
      ),
    );
  }

  // ==================== PORTRAIT LAYOUT ====================
  Widget _buildPortraitLayout(
    BuildContext context,
    VsMatchController controller,
  ) {
    return Column(
      key: const ValueKey('PortraitVsMatch'),
      children: [
        SizedBox(height: 10.h),

        // TOP APP BAR
        _buildHeader(context),

        SizedBox(height: 8.h),

        // SUBTITLE
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            StaticString.createChampionshipTagline,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.3,
            ),
          ),
        ),

        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF38E5D8)),
              );
            }

            final team1 = controller.matchData.value?.team1 ?? [];
            final team2 = controller.matchData.value?.team2 ?? [];

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  SizedBox(height: 10.h),

                  // TEAM 1 PLAYER CARDS (TOP SECTION)
                  ...team1.map((player) => Padding(
                        padding: EdgeInsets.only(bottom: 14.h),
                        child: _buildVsPlayerCard(player: player),
                      )),

                  SizedBox(height: 20.h),

                  // HORIZONTAL VS DIVIDER
                  _buildHorizontalVsDivider(),

                  SizedBox(height: 20.h),

                  // TEAM 2 PLAYER CARDS (BOTTOM SECTION)
                  ...team2.map((player) => Padding(
                        padding: EdgeInsets.only(bottom: 14.h),
                        child: _buildVsPlayerCard(player: player),
                      )),

                  SizedBox(height: 20.h),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // ==================== LANDSCAPE LAYOUT ====================
  Widget _buildLandscapeLayout(
    BuildContext context,
    VsMatchController controller,
  ) {
    return Column(
      key: const ValueKey('LandscapeVsMatch'),
      children: [
        SizedBox(height: 6),

        // TOP APP BAR
        _buildHeader(context),

        SizedBox(height: 4),

        // SUBTITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            StaticString.createChampionshipTagline,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: segoeFont,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
          ),
        ),

        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF38E5D8)),
              );
            }

            final team1 = controller.matchData.value?.team1 ?? [];
            final team2 = controller.matchData.value?.team2 ?? [];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  // LEFT COLUMN (TEAM 1)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: team1
                            .map((player) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildVsPlayerCard(
                                    player: player,
                                    isLandscape: true,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),

                  // CENTER VERTICAL VS DIVIDER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildVerticalVsDivider(),
                  ),

                  // RIGHT COLUMN (TEAM 2)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: team2
                            .map((player) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildVsPlayerCard(
                                    player: player,
                                    isLandscape: true,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // ==================== HEADER ====================
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Center(
        child: Text(
          StaticString.onlineGame.tr,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ==================== VS PLAYER CARD ====================
  Widget _buildVsPlayerCard({
    required OnlinePlayerModel player,
    bool isLandscape = false,
  }) {
    final double cardHeight = isLandscape ? 56.0 : 60.h;

    return Container(
      width: double.infinity,
      height: cardHeight,
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 8.0 : 10.w,
        vertical: isLandscape ? 2.0 : 4.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0C3058),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF062343).withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular Avatar (Network Image or First Letter)
          Builder(
            builder: (context) {
              final firstLetter =
                  player.name.isNotEmpty ? player.name[0].toUpperCase() : '?';

              Widget buildLetterAvatar() {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF38E5D8), Color(0xFF0D5363)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      firstLetter,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: isLandscape ? 14.0 : 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }

              return Container(
                width: isLandscape ? 34.0 : 44.w,
                height: isLandscape ? 34.0 : 44.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF38E5D8),
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: player.avatarUrl.isNotEmpty
                      ? Image.network(
                          player.avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              buildLetterAvatar(),
                        )
                      : buildLetterAvatar(),
                ),
              );
            },
          ),
          SizedBox(width: isLandscape ? 8.0 : 14.w),

          // Name and Subtitle
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 12.5 : 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (player.isYourTeam) ...[
                  Text(
                    StaticString.your.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 9.5 : 10.5.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF38E5D8),
                      height: 1.0,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HORIZONTAL VS DIVIDER ====================
  Widget _buildHorizontalVsDivider() {
    return Row(
      children: [
        Expanded(
          child: CustomPaint(
            size: Size(double.infinity, 2.h),
            painter: DashedLinePainter(isVertical: false),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            StaticString.vsText,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 28.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: CustomPaint(
            size: Size(double.infinity, 2.h),
            painter: DashedLinePainter(isVertical: false),
          ),
        ),
      ],
    );
  }

  // ==================== VERTICAL VS DIVIDER ====================
  Widget _buildVerticalVsDivider() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomPaint(
            size: const Size(2, double.infinity),
            painter: DashedLinePainter(isVertical: true),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            StaticString.vsText,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: CustomPaint(
            size: const Size(2, double.infinity),
            painter: DashedLinePainter(isVertical: true),
          ),
        ),
      ],
    );
  }
}

// DASHED LINE PAINTER FOR VS DIVIDER
class DashedLinePainter extends CustomPainter {
  final bool isVertical;

  DashedLinePainter({this.isVertical = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF38E5D8).withValues(alpha: 0.6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;

    if (isVertical) {
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashWidth),
          paint,
        );
        startY += dashWidth + dashSpace;
      }
    } else {
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
  }

  @override
  bool shouldRepaint(covariant DashedLinePainter oldDelegate) => false;
}
