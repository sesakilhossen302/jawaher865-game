import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/question_controller.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<QuestionController>()) {
      Get.put(QuestionController());
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
                            key: const ValueKey('qs_portrait'),
                            child: _buildPortraitLayout(),
                          )
                        : SizedBox(
                            key: const ValueKey('qs_landscape'),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 8.h),

          // 1. TOP ACTION BAR
          _buildTopActionBar(),

          SizedBox(height: 16.h),

          // 2. TITLE HEADER
          Obx(
            () => Text(
              '${controller.categoryTitle.value} Question – ${controller.points.value} Points',
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 14.h),

          // 3. MAIN DYNAMIC BODY (Question Box OR Result Distribution Box)
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                if (controller.viewState.value ==
                    QuestionViewState.resultDistribution) {
                  return _buildResultDistributionContent(isLandscape: false);
                }
                return Column(
                  children: [
                    _buildQuestionBox(isLandscape: false),
                    SizedBox(height: 20.h),
                    _buildActionButtons(isLandscape: false),
                    SizedBox(height: 20.h),
                  ],
                );
              }),
            ),
          ),

          // 4. PLAYER SCOREBOARD (Portrait)
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
                SizedBox(height: 8.h),
                if (controller.viewState.value !=
                    QuestionViewState.resultDistribution) ...[
                  _buildTurnButton(),
                  SizedBox(height: 8.h),
                ],
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

          SizedBox(height: 12.h),
        ],
      ),
    );
  }

  // LANDSCAPE LAYOUT (NON-OVERFLOWING)
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 4),

          // 1. TOP ACTION BAR WITH INTEGRATED CENTER TITLE
          Row(
            children: [
              // Exit & Restart Buttons
              GestureDetector(
                onTap: controller.onExit,
                child: Row(
                  children: [
                    const Icon(Icons.logout_rounded, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      StaticString.exit,
                      style: const TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: controller.onRestart,
                child: Row(
                  children: [
                    const Icon(Icons.refresh_rounded, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      StaticString.restart,
                      style: const TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Title in Middle
              Expanded(
                child: Obx(
                  () => Text(
                    '${controller.categoryTitle.value} Question – ${controller.points.value} Points',
                    style: const TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Game Over Pill Button
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: controller.onGameOver,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3358FE),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                  child: Text(
                    StaticString.gameOver,
                    style: const TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 6),

              // Options Dots
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // 2. MAIN DYNAMIC BODY
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(() {
                if (controller.viewState.value ==
                    QuestionViewState.resultDistribution) {
                  return _buildResultDistributionContent(isLandscape: true);
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildQuestionBox(isLandscape: true),
                    const SizedBox(height: 8),
                    _buildActionButtons(isLandscape: true),
                  ],
                );
              }),
            ),
          ),

          const SizedBox(height: 6),

          // 3. BOTTOM PLAYER SCOREBOARD (Landscape)
          Obx(
            () => Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _buildPlayerCard(
                    name: controller.player1.value.name,
                    score: controller.player1.value.score.toString(),
                    isTurn: controller.player1.value.isTurn,
                    avatarInitials: controller.player1.value.avatarInitials,
                    avatarColor: const Color(0xFF275BEA),
                    isLandscape: true,
                  ),
                ),

                if (controller.viewState.value !=
                    QuestionViewState.resultDistribution) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: _buildTurnButton(isLandscape: true),
                  ),
                ],

                const SizedBox(width: 8),

                Expanded(
                  flex: 3,
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

          const SizedBox(height: 6),
        ],
      ),
    );
  }

  // RESULT DISTRIBUTION CONTENT (IMAGE 1 & IMAGE 2)
  Widget _buildResultDistributionContent({required bool isLandscape}) {
    return Column(
      children: [
        SizedBox(height: isLandscape ? 4 : 6.h),

        // Subheader Instruction: "Which team answered correctly"
        Text(
          StaticString.whichTeamAnsweredCorrectly,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: isLandscape ? 15 : 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: isLandscape ? 10 : 18.h),

        // Team 1 & Team 2 Selection Boxes
        SizedBox(
          width: isLandscape ? 440 : double.infinity,
          child: Row(
            children: [
              // Team 1 Selection Box
              Expanded(
                child: GestureDetector(
                  onTap: controller.onAwardTeam1,
                  child: Container(
                    height: isLandscape ? 70 : 88.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF065967).withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFF38E5D8).withValues(alpha: 0.4),
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
                    child: Center(
                      child: Text(
                        controller.player1.value.name.isNotEmpty
                            ? controller.player1.value.name
                            : 'Team 1',
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: isLandscape ? 16 : 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: isLandscape ? 12 : 16.w),

              // Team 2 Selection Box
              Expanded(
                child: GestureDetector(
                  onTap: controller.onAwardTeam2,
                  child: Container(
                    height: isLandscape ? 70 : 88.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF065967).withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xFF38E5D8).withValues(alpha: 0.4),
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
                    child: Center(
                      child: Text(
                        controller.player2.value.name.isNotEmpty
                            ? controller.player2.value.name
                            : 'Team 2',
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: isLandscape ? 16 : 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: isLandscape ? 12 : 18.h),

        // No-one Selection Box
        GestureDetector(
          onTap: controller.onAwardNoOne,
          child: Container(
            width: isLandscape ? 200 : 220.w,
            height: isLandscape ? 50 : 60.h,
            decoration: BoxDecoration(
              color: const Color(0xFF065967).withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF38E5D8).withValues(alpha: 0.4),
                width: 1.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                StaticString.noOne,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 16 : 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: isLandscape ? 12 : 24.h),

        // Return to the answer Blue Button
        SizedBox(
          width: isLandscape ? 220 : 260.w,
          height: isLandscape ? 40 : 48.h,
          child: ElevatedButton.icon(
            onPressed: controller.onReturnToAnswer,
            icon: Icon(
              Icons.undo_rounded,
              color: Colors.white,
              size: isLandscape ? 16 : 18.sp,
            ),
            label: Text(
              StaticString.returnToAnswer,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 13 : 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3358FE),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),

        SizedBox(height: isLandscape ? 6 : 14.h),
      ],
    );
  }

  // QUESTION BOX CONTAINER
  Widget _buildQuestionBox({bool isLandscape = false}) {
    return Container(
      width: isLandscape ? 440 : double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 14 : 20.w,
        vertical: isLandscape ? 10 : 16.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF065967).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(
            () => Text(
              controller.questionText.value,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 15 : 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: isLandscape ? 8 : 14.h),

          // Question Image Graphic (Network CDN or Local Asset)
          Obx(() {
            final imgPath = controller.questionImage.value;
            final isNetwork =
                imgPath.startsWith('http://') || imgPath.startsWith('https://');

            return isNetwork
                ? Image.network(
                    imgPath,
                    height: isLandscape ? 85 : 135.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        AppImg.flagsImg,
                        height: isLandscape ? 85 : 135.h,
                        fit: BoxFit.contain,
                      );
                    },
                  )
                : Image.asset(
                    imgPath,
                    height: isLandscape ? 85 : 135.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.help_outline_rounded,
                        size: isLandscape ? 45 : 60.sp,
                        color: Colors.white70,
                      );
                    },
                  );
          }),

          // Revealed Answer Text inside Question Box
          Obx(() {
            if (controller.viewState.value == QuestionViewState.question) {
              return const SizedBox();
            }
            return Padding(
              padding: EdgeInsets.only(top: isLandscape ? 8 : 14.h),
              child: Text(
                controller.answerText.value,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 16 : 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }),
        ],
      ),
    );
  }

  // ACTION BUTTONS (SHOW ANSWER / RETURN TO ANSWER + RESULT DISTRIBUTION)
  Widget _buildActionButtons({required bool isLandscape}) {
    return Obx(() {
      final state = controller.viewState.value;

      if (state == QuestionViewState.question) {
        // STATE 1: Single Show Answer Button
        return SizedBox(
          width: isLandscape ? 220 : 280.w,
          height: isLandscape ? 40 : 48.h,
          child: ElevatedButton(
            onPressed: controller.toggleShowAnswer,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3358FE),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Text(
              StaticString.showAnswer,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 14 : 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      }

      // STATE 2: Answer Revealed -> Show 'Return to the answer' & 'Result Distribution'
      if (isLandscape) {
        // LANDSCAPE: Side-by-Side Row
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Return to the answer Button
            SizedBox(
              width: 210,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: controller.onReturnToAnswer,
                icon: const Icon(
                  Icons.undo_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                label: Text(
                  StaticString.returnToAnswer,
                  style: const TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3358FE),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Result Distribution Button
            SizedBox(
              width: 210,
              height: 40,
              child: ElevatedButton(
                onPressed: controller.goToResultDistribution,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  StaticString.resultDistribution,
                  style: const TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        // PORTRAIT: Stacked Column
        return SizedBox(
          width: 280.w,
          child: Column(
            children: [
              // Return to the answer Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton.icon(
                  onPressed: controller.onReturnToAnswer,
                  icon: Icon(
                    Icons.undo_rounded,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  label: Text(
                    StaticString.returnToAnswer,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3358FE),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // Result Distribution Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: controller.goToResultDistribution,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    StaticString.resultDistribution,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  // TURN BUTTON PILL
  Widget _buildTurnButton({bool isLandscape = false}) {
    return Obx(() {
      final nextTurnName = controller.player1.value.isTurn
          ? controller.player2.value.name
          : controller.player1.value.name;

      return GestureDetector(
        onTap: controller.onTurnTap,
        child: Container(
          width: double.infinity,
          height: isLandscape ? 40 : 46.h,
          decoration: BoxDecoration(
            color: const Color(0xFF065967).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: const Color(0xFF38E5D8).withValues(alpha: 0.4),
              width: 1.w,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$nextTurnName ${StaticString.yourTurn}',
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 12 : 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: const Color(0xFF38E5D8),
                size: isLandscape ? 12 : 14.sp,
              ),
            ],
          ),
        ),
      );
    });
  }

  // TOP ACTION BAR WIDGET (PORTRAIT)
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
                Icons.refresh_rounded,
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
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
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
            width: isLandscape ? 28 : 34.w,
            height: isLandscape ? 28 : 34.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarColor,
            ),
            child: Center(
              child: Text(
                avatarInitials,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 12 : 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(width: isLandscape ? 6 : 10.w),

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
                    fontSize: isLandscape ? 12 : 14.sp,
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
                      fontSize: isLandscape ? 9 : 10.sp,
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
              fontSize: isLandscape ? 15 : 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
    );
  }
}
