import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.onExit();
        }
      },
      child: Scaffold(
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
                    final mediaSize = MediaQuery.of(context).size;
                    final isPortrait = orientation == Orientation.portrait &&
                        mediaSize.height >= mediaSize.width;
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
                  avatarColor: const Color(0xFF007E33),
                  gradientColors: const [
                    Color(0xFF00C853),
                    Color(0xFF10B981),
                  ],
                  borderColor: const Color(0xFF69F0AE),
                ),
                SizedBox(height: 10.h),
                _buildPlayerCard(
                  name: controller.player2.value.name,
                  score: controller.player2.value.score.toString(),
                  isTurn: controller.player2.value.isTurn,
                  avatarInitials: controller.player2.value.avatarInitials,
                  avatarColor: const Color(0xFFC62828),
                  gradientColors: const [
                    Color(0xFFFF4848),
                    Color(0xFFFF7A00),
                  ],
                  borderColor: const Color(0xFFFF8B74),
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

  // COMPACT LANDSCAPE LAYOUT (CONSOLE / ARENA STYLE FIT)
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          // 1. TOP ACTION BAR (Exit, Restart on left | Game Over, dots on right)
          _buildTopActionBar(isLandscape: true),

          const SizedBox(height: 6),

          // 2. PLAYER SCOREBOARD ROW (Green Team on Left | Red Team on Right)
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: _buildPlayerCard(
                    name: controller.player1.value.name,
                    score: controller.player1.value.score.toString(),
                    isTurn: controller.player1.value.isTurn,
                    avatarInitials: controller.player1.value.avatarInitials,
                    avatarColor: const Color(0xFF007E33),
                    gradientColors: const [
                      Color(0xFF00C853),
                      Color(0xFF10B981),
                    ],
                    borderColor: const Color(0xFF69F0AE),
                    isLandscape: true,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildPlayerCard(
                    name: controller.player2.value.name,
                    score: controller.player2.value.score.toString(),
                    isTurn: controller.player2.value.isTurn,
                    avatarInitials: controller.player2.value.avatarInitials,
                    avatarColor: const Color(0xFFC62828),
                    gradientColors: const [
                      Color(0xFFFF4848),
                      Color(0xFFFF7A00),
                    ],
                    borderColor: const Color(0xFFFF8B74),
                    isLandscape: true,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 3. CATEGORY BOARD ROWS (Player 1 Points on Left | Category Card Center | Player 2 Points on Right)
          Expanded(
            child: Obx(
              () => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: controller.categoryBlocks.map((block) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildLandscapeCategoryRow(block),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          const SizedBox(height: 2),
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
                    size: isLandscape ? 15 : 18.sp,
                  ),
                  SizedBox(width: isLandscape ? 3 : 4.w),
                  Text(
                    StaticString.exit.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 12 : 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: isLandscape ? 12 : 16.w),
            GestureDetector(
              onTap: controller.onRestart,
              child: Row(
                children: [
                  Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                    size: isLandscape ? 15 : 18.sp,
                  ),
                  SizedBox(width: isLandscape ? 3 : 4.w),
                  Text(
                    StaticString.restart.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 12 : 14.sp,
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
              height: isLandscape ? 28 : 36.h,
              child: ElevatedButton(
                onPressed: controller.onGameOver,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF3B30),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: isLandscape ? 12 : 20.w),
                ),
                child: Text(
                  StaticString.gameOver.tr,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 11 : 13.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: isLandscape ? 6 : 8.w),
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: isLandscape ? 18 : 22.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // COMPACT PLAYER CARD WIDGET
  Widget _buildPlayerCard({
    required String name,
    required String score,
    required bool isTurn,
    required String avatarInitials,
    required Color avatarColor,
    List<Color>? gradientColors,
    Color? borderColor,
    bool isLandscape = false,
  }) {
    final colors = gradientColors ?? const [Color(0xFFFF4848), Color(0xFFFF7A00)];
    final activeBorder = borderColor ?? Colors.white;

    return Container(
      height: isLandscape ? 38.0 : null,
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 10.0 : 14.w,
        vertical: isLandscape ? 3.0 : 8.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(isLandscape ? 18 : 24.r),
        border: Border.all(
          color: isTurn ? activeBorder : Colors.white.withValues(alpha: 0.4),
          width: isTurn ? 2.0 : 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: isTurn
                ? colors.first.withValues(alpha: 0.5)
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
            width: isLandscape ? 28.0 : 36.w,
            height: isLandscape ? 28.0 : 36.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Text(
                avatarInitials,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 12.0 : 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: isLandscape ? 8.0 : 12.w),

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
                    fontSize: isLandscape ? 12.0 : 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isTurn)
                  Text(
                    StaticString.yourTurn.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 8.5 : 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.0,
                    ),
                    maxLines: 1,
                  ),
              ],
            ),
          ),

          // Score Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 10 : 12.w,
              vertical: isLandscape ? 2 : 4.h,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              score,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 13.0 : 18.sp,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(width: isLandscape ? 2.0 : 4.w),
        ],
      ),
    );
  }

  // LANDSCAPE CATEGORY ROW (Player 1 Points | Artwork Card | Player 2 Points)
  Widget _buildLandscapeCategoryRow(GameBoardBlockModel block) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 820),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Player Point Buttons (Green Team - 200, 400, 600)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: block.pointValues.map((pts) {
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: _buildPointButton(
                  block.id,
                  'left',
                  pts,
                  width: 58,
                  height: 44,
                  fontSize: 13,
                  customGradient: const [Color(0xFF00C853), Color(0xFF10B981)],
                ),
              );
            }).toList(),
          ),

          const SizedBox(width: 10),

          // Center Category Card (Artwork + Title Banner)
          Expanded(
            child: Container(
              height: 72,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B30),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Full Background Artwork
                  _buildDynamicBlockImage(block.imagePath),

                  // Bottom Gradient Title Banner
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 24,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFFF3B30).withValues(alpha: 0.85),
                            const Color(0xFFFF2D55).withValues(alpha: 0.98),
                          ],
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        block.title.toUpperCase(),
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Right Player Point Buttons (Red Team - 200, 400, 600)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: block.pointValues.map((pts) {
              return Padding(
                padding: const EdgeInsets.only(left: 6),
                child: _buildPointButton(
                  block.id,
                  'right',
                  pts,
                  width: 58,
                  height: 44,
                  fontSize: 13,
                  customGradient: const [Color(0xFFFF4848), Color(0xFFFF7A00)],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // CATEGORY ROW WITH LEFT & RIGHT POINT BUTTONS (PORTRAIT)
  Widget _buildCategoryRow(GameBoardBlockModel block, {bool isCompact = false}) {
    return Row(
      children: [
        // Left Column of Point Buttons (200, 400, 600)
        Column(
          children: block.pointValues.map((pts) {
            return Padding(
              padding: EdgeInsets.only(bottom: isCompact ? 2 : 8.h),
              child: _buildPointButton(
                block.id,
                'left',
                pts,
                isCompact: isCompact,
                customGradient: const [Color(0xFF00C853), Color(0xFF10B981)],
              ),
            );
          }).toList(),
        ),

        SizedBox(width: isCompact ? 3 : 10.w),

        // Center Category Card (Flexible Container matching Figma Screen 5)
        Expanded(
          child: Container(
            height: isCompact ? 86.0 : 136.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B30),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.2.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Top Artwork (Supports Network URLs, SVGs, and Local Assets)
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: _buildDynamicBlockImage(block.imagePath),
                  ),
                ),

                // Bottom Red Title Banner
                Container(
                  height: isCompact ? 22.0 : 30.h,
                  width: double.infinity,
                  color: const Color(0xFFFF3B30),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    block.title.toUpperCase(),
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isCompact ? 9.5 : 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
              padding: EdgeInsets.only(bottom: isCompact ? 2 : 8.h),
              child: _buildPointButton(
                block.id,
                'right',
                pts,
                isCompact: isCompact,
                customGradient: const [Color(0xFFFF4848), Color(0xFFFF7A00)],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // POINT BUTTON WIDGET (200, 400, 600)
  Widget _buildPointButton(
    int categoryId,
    String side,
    int points, {
    bool isCompact = false,
    double? width,
    double? height,
    double? fontSize,
    List<Color>? customGradient,
  }) {
    return Obx(() {
      final key = '$categoryId-$side-$points';
      final isUsed = controller.usedPointButtons.contains(key);
      final gradientColors = customGradient ?? const [Color(0xFFFF4848), Color(0xFFFF7A00)];

      return GestureDetector(
        onTap: () => controller.onPointTap(categoryId, side, points),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width ?? (isCompact ? 30.0 : 58.w),
          height: height ?? (isCompact ? 26.0 : 42.h),
          decoration: BoxDecoration(
            color: isUsed ? Colors.white.withValues(alpha: 0.2) : null,
            gradient: isUsed
                ? null
                : LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(
              width != null ? 10 : (isCompact ? 8 : 14.r),
            ),
            border: Border.all(
              color: isUsed
                  ? Colors.white.withValues(alpha: 0.25)
                  : Colors.white.withValues(alpha: 0.5),
              width: 1.w,
            ),
            boxShadow: isUsed
                ? []
                : [
                    BoxShadow(
                      color: gradientColors.first.withValues(alpha: 0.35),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Center(
            child: Text(
              points.toString(),
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: fontSize ?? (isCompact ? 9.5 : 13.sp),
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

  Widget _buildDynamicBlockImage(String path) {
    if (path.isEmpty) {
      return Container(
        color: const Color(0xFF1E293B),
        child: const Center(
          child: Icon(Icons.category_rounded, color: Colors.white70, size: 28),
        ),
      );
    }

    final isNetwork = path.startsWith('http://') || path.startsWith('https://');
    final isSvg = path.toLowerCase().endsWith('.svg');

    if (isSvg) {
      if (isNetwork) {
        return SvgPicture.network(
          path,
          fit: BoxFit.cover,
          placeholderBuilder: (ctx) => const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      } else {
        return SvgPicture.asset(
          path,
          fit: BoxFit.cover,
        );
      }
    }

    if (isNetwork) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: const Color(0xFF1E293B),
          child: const Center(
            child: Icon(Icons.category_rounded, color: Colors.white70, size: 28),
          ),
        ),
      );
    }

    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: const Color(0xFF1E293B),
        child: const Center(
          child: Icon(Icons.category_rounded, color: Colors.white70, size: 28),
        ),
      ),
    );
  }
}
