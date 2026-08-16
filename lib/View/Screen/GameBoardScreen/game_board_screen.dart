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
            // PERSISETENT FULL PAGE BACKGROUND
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // MAIN CONTENT LAYER
            SafeArea(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  final isPortrait = orientation == Orientation.portrait;
                  return isPortrait
                      ? _buildPortraitLayout()
                      : _buildLandscapeLayout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PORTRAIT LAYOUT (IMAGE 1)
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

  // LANDSCAPE LAYOUT (IMAGE 1)
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 10.h),

          // 1. TOP ACTION BAR (Exit, Restart on left | Game Over, dots on right)
          _buildTopActionBar(),

          SizedBox(height: 14.h),

          // 2. PLAYER SCOREBOARD ROW (Player 1 on Left | Player 2 on Right)
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 280.w,
                  child: _buildPlayerCard(
                    name: controller.player1.value.name,
                    score: controller.player1.value.score.toString(),
                    isTurn: controller.player1.value.isTurn,
                    avatarInitials: controller.player1.value.avatarInitials,
                    avatarColor: const Color(0xFF275BEA),
                  ),
                ),
                SizedBox(
                  width: 280.w,
                  child: _buildPlayerCard(
                    name: controller.player2.value.name,
                    score: controller.player2.value.score.toString(),
                    isTurn: controller.player2.value.isTurn,
                    avatarInitials: controller.player2.value.avatarInitials,
                    avatarColor: const Color(0xFFE54124),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // 3. CATEGORY BOARD GRID (3 Categories across in a row)
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
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: rowBlocks.map((block) {
                          return SizedBox(
                            width: 210.w,
                            child: _buildCategoryRow(block, isCompact: true),
                          );
                        }).toList(),
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
  Widget _buildTopActionBar() {
    return Row(
      children: [
        // Exit Action Button
        GestureDetector(
          onTap: controller.onExit,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                StaticString.exit,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 16.w),

        // Restart Action Button
        GestureDetector(
          onTap: controller.onRestart,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Icon(
                Icons.restart_alt_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                StaticString.restart,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // Game Over Pill Button
        GestureDetector(
          onTap: controller.onGameOver,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF3358FE),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3358FE).withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              StaticString.gameOver,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        SizedBox(width: 10.w),

        // More Options Icon
        Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 22.sp,
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
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
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
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarColor,
            ),
            child: Center(
              child: Text(
                avatarInitials,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Player Name & Turn Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (isTurn)
                  Text(
                    StaticString.yourTurn,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF22C55E),
                    ),
                  ),
              ],
            ),
          ),

          // Score
          Text(
            score,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 6.w),
        ],
      ),
    );
  }

  // CATEGORY ROW WITH LEFT & RIGHT POINT BUTTONS
  Widget _buildCategoryRow(GameBoardBlockModel block, {bool isCompact = false}) {
    return Row(
      mainAxisSize: isCompact ? MainAxisSize.min : MainAxisSize.max,
      children: [
        // Left Column of Point Buttons (200, 400, 600)
        Column(
          children: block.pointValues.map((pts) {
            return Padding(
              padding: EdgeInsets.only(bottom: isCompact ? 4.h : 8.h),
              child: _buildPointButton(block.id, 'left', pts, isCompact: isCompact),
            );
          }).toList(),
        ),

        SizedBox(width: isCompact ? 6.w : 10.w),

        // Center Category Card
        isCompact
            ? Container(
                width: 100.w,
                height: 140.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF065967).withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
                    width: 1.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      block.imagePath,
                      height: 44.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.category_rounded,
                          size: 32.sp,
                          color: Colors.amber,
                        );
                      },
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      block.title,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: Container(
                  height: 146.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF065967).withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
                      width: 1.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        block.imagePath,
                        height: 52.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.category_rounded,
                            size: 38.sp,
                            color: Colors.amber,
                          );
                        },
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        block.title,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

        SizedBox(width: isCompact ? 6.w : 10.w),

        // Right Column of Point Buttons (200, 400, 600)
        Column(
          children: block.pointValues.map((pts) {
            return Padding(
              padding: EdgeInsets.only(bottom: isCompact ? 4.h : 8.h),
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
          width: isCompact ? 44.w : 58.w,
          height: isCompact ? 40.h : 42.h,
          decoration: BoxDecoration(
            color: isUsed
                ? Colors.white.withValues(alpha: 0.15)
                : const Color(0xFF065967).withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(14.r),
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
                fontSize: isCompact ? 11.sp : 13.sp,
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
