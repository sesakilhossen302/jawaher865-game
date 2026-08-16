import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Model/game_board_model.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/game_board_controller.dart';

class GameBoardScreen extends GetView<GameBoardController> {
  const GameBoardScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<GameBoardController>()) {
      Get.put(GameBoardController());
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // PERSISTENT FULL PAGE BACKGROUND
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // MAIN CONTENT LAYER WITH SMOOTH ROTATION ANIMATION
            SafeArea(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  final isPortrait = orientation == Orientation.portrait;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isPortrait
                        ? SizedBox(
                            key: const ValueKey('gb_portrait'),
                            child: _buildPortraitLayout(),
                          )
                        : SizedBox(
                            key: const ValueKey('gb_landscape'),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 8.h),

          // 1. TOP ACTION BAR
          _buildTopActionBar(),

          SizedBox(height: 14.h),

          // 2. PLAYER SCOREBOARD STACK (Player 1 & Player 2)
          Obx(
            () => Column(
              children: [
                _buildPlayerCard(
                  name: controller.player1.value.name,
                  score: controller.player1.value.score.toString(),
                  isTurn: controller.player1.value.isTurn,
                  avatarInitials: controller.player1.value.avatarInitials,
                  avatarColor: const Color(0xFF275BEA),
                ),
                SizedBox(height: 10.h),
                _buildPlayerCard(
                  name: controller.player2.value.name,
                  score: controller.player2.value.score.toString(),
                  isTurn: controller.player2.value.isTurn,
                  avatarInitials: controller.player2.value.avatarInitials,
                  avatarColor: const Color(0xFFE54124),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // 3. CATEGORY BLOCKS VERTICAL LIST
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () => Column(
                  children: controller.categoryBlocks.map((block) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: _buildCategoryRow(block),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LANDSCAPE LAYOUT (0.0 OVERFLOW GUARANTEED)
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 4),

          // 1. TOP ACTION BAR (Exit, Restart on left | Game Over, dots on right)
          _buildTopActionBar(isLandscape: true),

          const SizedBox(height: 8),

          // 2. PLAYER SCOREBOARD ROW (Player 1 on Left | Player 2 on Right)
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: _buildPlayerCard(
                    name: controller.player1.value.name,
                    score: controller.player1.value.score.toString(),
                    isTurn: controller.player1.value.isTurn,
                    avatarInitials: controller.player1.value.avatarInitials,
                    avatarColor: const Color(0xFF275BEA),
                    isLandscape: true,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildPlayerCard(
                    name: controller.player2.value.name,
                    score: controller.player2.value.score.toString(),
                    isTurn: controller.player2.value.isTurn,
                    avatarInitials: controller.player2.value.avatarInitials,
                    avatarColor: const Color(0xFFE54124),
                    isLandscape: true,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 3. CATEGORY BOARD GRID (3 Categories across per row)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(() {
                final blocks = controller.categoryBlocks;
                List<Widget> rows = [];
                for (int i = 0; i < blocks.length; i += 3) {
                  final rowBlocks = blocks.sublist(
                    i,
                    (i + 3 < blocks.length) ? i + 3 : blocks.length,
                  );
                  rows.add(
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          for (int j = 0; j < rowBlocks.length; j++) ...[
                            if (j > 0) const SizedBox(width: 8),
                            Expanded(
                              child: _buildCategoryRow(rowBlocks[j], isCompact: true),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }
                return Column(children: rows);
              }),
            ),
          ),
        ],
      ),
    );
  }

  // TOP ACTION BAR WIDGET
  Widget _buildTopActionBar({bool isLandscape = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Exit & Restart Buttons
        Row(
          children: [
            GestureDetector(
              onTap: controller.onExit,
              child: Row(
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: isLandscape ? 18 : 18.sp,
                  ),
                  SizedBox(width: isLandscape ? 4 : 4.w),
                  Text(
                    StaticString.exit,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 13 : 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: isLandscape ? 16 : 16.w),
            GestureDetector(
              onTap: controller.onRestart,
              child: Row(
                children: [
                  Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                    size: isLandscape ? 18 : 18.sp,
                  ),
                  SizedBox(width: isLandscape ? 4 : 4.w),
                  Text(
                    StaticString.restart,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 13 : 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Game Over & Options Dots
        Row(
          children: [
            SizedBox(
              height: isLandscape ? 34 : 36.h,
              child: ElevatedButton(
                onPressed: controller.onGameOver,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3358FE),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: isLandscape ? 16 : 20.w),
                ),
                child: Text(
                  StaticString.gameOver,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 12 : 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: isLandscape ? 8 : 8.w),
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: isLandscape ? 20 : 22.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // PLAYER CARD WIDGET
  Widget _buildPlayerCard({
    required String name,
    required String score,
    required bool isTurn,
    required String avatarInitials,
    required Color avatarColor,
    bool isLandscape = false,
  }) {
    return Container(
      height: isLandscape ? 52 : null,
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 10 : 14.w,
        vertical: isLandscape ? 4 : 8.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF003366).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isTurn
              ? const Color(0xFF38E5D8)
              : const Color(0xFF38E5D8).withValues(alpha: 0.25),
          width: isTurn ? 2.w : 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: isTurn
                ? const Color(0xFF38E5D8).withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar Circle
          Container(
            width: isLandscape ? 30 : 36.w,
            height: isLandscape ? 30 : 36.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarColor,
            ),
            child: Center(
              child: Text(
                avatarInitials,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 13 : 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: isLandscape ? 8 : 12.w),

          // Player Name & Turn Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 12 : 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isTurn)
                  Text(
                    StaticString.yourTurn,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 9 : 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF22C55E),
                    ),
                    maxLines: 1,
                  ),
              ],
            ),
          ),

          // Score
          Text(
            score,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: isLandscape ? 16 : 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
    );
  }

  // CATEGORY ROW WITH LEFT & RIGHT POINT BUTTONS
  Widget _buildCategoryRow(GameBoardBlockModel block, {bool isCompact = false}) {
    return Row(
      children: [
        // Left Column of Point Buttons (200, 400, 600)
        Column(
          children: block.pointValues.map((pts) {
            return Padding(
              padding: EdgeInsets.only(bottom: isCompact ? 3 : 8.h),
              child: _buildPointButton(block.id, 'left', pts, isCompact: isCompact),
            );
          }).toList(),
        ),

        SizedBox(width: isCompact ? 3 : 10.w),

        // Center Category Card (Flexible Container)
        Expanded(
          child: Container(
            height: isCompact ? 102 : 146.h,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF065967).withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  block.imagePath,
                  height: isCompact ? 34 : 52.h,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.category_rounded,
                      size: isCompact ? 26 : 38.sp,
                      color: Colors.amber,
                    );
                  },
                ),
                SizedBox(height: isCompact ? 2 : 8.h),
                Text(
                  block.title,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isCompact ? 11 : 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: isCompact ? 3 : 10.w),

        // Right Column of Point Buttons (200, 400, 600)
        Column(
          children: block.pointValues.map((pts) {
            return Padding(
              padding: EdgeInsets.only(bottom: isCompact ? 3 : 8.h),
              child: _buildPointButton(block.id, 'right', pts, isCompact: isCompact),
            );
          }).toList(),
        ),
      ],
    );
  }

  // POINT BUTTON WIDGET (200, 400, 600)
  Widget _buildPointButton(int categoryId, String side, int points, {bool isCompact = false}) {
    return Obx(() {
      final key = '$categoryId-$side-$points';
      final isUsed = controller.usedPointButtons.contains(key);

      return GestureDetector(
        onTap: () => controller.onPointTap(categoryId, side, points),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isCompact ? 34 : 58.w,
          height: isCompact ? 30 : 42.h,
          decoration: BoxDecoration(
            color: isUsed
                ? Colors.white.withValues(alpha: 0.15)
                : const Color(0xFF065967).withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(isCompact ? 10 : 14.r),
            border: Border.all(
              color: isUsed
                  ? Colors.white.withValues(alpha: 0.2)
                  : const Color(0xFF38E5D8).withValues(alpha: 0.4),
              width: 1.w,
            ),
          ),
          child: Center(
            child: Text(
              points.toString(),
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isCompact ? 10 : 13.sp,
                fontWeight: FontWeight.bold,
                color: isUsed
                    ? Colors.white.withValues(alpha: 0.4)
                    : Colors.white,
              ),
            ),
          ),
        ),
      );
    });
  }
}
