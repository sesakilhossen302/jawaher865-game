import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Utils/AppIcons/app_icons.dart';
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
                  final mediaSize = MediaQuery.of(context).size;
                  final isPortrait = orientation == Orientation.portrait &&
                      mediaSize.height >= mediaSize.width;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isPortrait
                        ? SizedBox(
                            key: const ValueKey('qs_portrait_dual'),
                            child: _buildPortraitLayout(context),
                          )
                        : SizedBox(
                            key: const ValueKey('qs_landscape_dual'),
                            child: _buildLandscapeLayout(context),
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

  // ==================== PORTRAIT LAYOUT ====================
  Widget _buildPortraitLayout(BuildContext context) {
    return _buildFigmaOfflinePortraitLayout(context);
  }

  // ==================== FIGMA OFFLINE PORTRAIT FLOW ====================
  Widget _buildFigmaOfflinePortraitLayout(BuildContext context) {
    return Obx(() {
      final state = controller.viewState.value;

      if (state == QuestionViewState.resultDistribution) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              // Top Bar with back button
              Row(
                children: [
                  GestureDetector(
                    onTap: controller.onResultDistributionBack,
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
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${controller.categoryTitle.value.toUpperCase()} QUESTION - ${controller.points.value} POINTS',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF6B4A00),
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'WHICH TEAM ANSWER CORRECTLY?',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2C2416),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 38.w), // Balance back button
                ],
              ),

              const Spacer(flex: 2),

              // 3 Big Red Action Buttons
              _buildFigmaAwardButton(
                title: controller.player1.value.name.toUpperCase(),
                onTap: controller.onAwardTeam1,
              ),
              SizedBox(height: 16.h),
              _buildFigmaAwardButton(
                title: controller.player2.value.name.toUpperCase(),
                onTap: controller.onAwardTeam2,
              ),
              SizedBox(height: 16.h),
              _buildFigmaAwardButton(
                title: 'NO ONE',
                onTap: controller.onAwardNoOne,
              ),

              const Spacer(flex: 3),

              // Challenge Your Melas illustration at bottom
              SvgPicture.asset(
                AppIcons.challengeYourMelasImg,
                height: 60.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }

      // Question or AnswerRevealed state
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            // Header: Left Back Button, Right Team Turn Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.onExit,
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B30),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    "${controller.activeTeamName}'s Turn",
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(flex: 1),

            // Question Text
            Text(
              controller.questionText.value.toUpperCase(),
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF2C2416),
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 18.h),

            // Question Image (Dynamic: supports API URLs, SVG, and local assets)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 290.w,
                height: 165.h,
                color: Colors.black12,
                child: _buildDynamicQuestionMedia(
                  controller.questionImage.value,
                  width: 290.w,
                  height: 165.h,
                ),
              ),
            ),

            SizedBox(height: 22.h),

            // Subtitle
            Text(
              '${controller.categoryTitle.value} Questions - ${controller.points.value} Points',
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF5A482A),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 6.h),

            // Cyan Timer
            Text(
              'TIME 1:42MIN',
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00B0FF),
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(flex: 2),

            // Bottom Buttons
            if (state == QuestionViewState.question) ...[
              GestureDetector(
                onTap: () => _showAnswerDialog(context, isLandscape: false),
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5252), Color(0xFFFF3B30)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Answer',
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ] else ...[
              // RESULT DISTRIBUTION BUTTON
              GestureDetector(
                onTap: controller.goToResultDistribution,
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5252), Color(0xFFFF3B30)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'RESULT DISTRIBUTION',
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // BACK TO QUESTION BUTTON
              GestureDetector(
                onTap: controller.onBackToQuestion,
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: const Color(0xFFF3C242).withValues(alpha: 0.3),
                    border: Border.all(
                      color: const Color(0xFFD49A00),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'BACK TO QUESTION',
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C2416),
                      ),
                    ),
                  ),
                ),
              ),
            ],

            SizedBox(height: 24.h),
          ],
        ),
      );
    });
  }

  Widget _buildFigmaAwardButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicQuestionMedia(
    String imgPath, {
    required double width,
    required double height,
  }) {
    if (imgPath.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.black12,
        child: const Center(
          child: Icon(Icons.help_outline_rounded, color: Colors.white70, size: 36),
        ),
      );
    }

    final isNetwork = imgPath.startsWith('http://') || imgPath.startsWith('https://');
    final isSvg = imgPath.toLowerCase().endsWith('.svg');

    if (isSvg) {
      if (isNetwork) {
        return SvgPicture.network(
          imgPath,
          width: width,
          height: height,
          fit: BoxFit.contain,
          placeholderBuilder: (ctx) => const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      } else {
        return SvgPicture.asset(
          imgPath,
          width: width,
          height: height,
          fit: BoxFit.contain,
        );
      }
    }

    if (isNetwork) {
      return Image.network(
        imgPath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (ctx, error, stackTrace) => Image.asset(
          AppImg.qBrazilFlag,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      imgPath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (ctx, error, stackTrace) => Image.asset(
        AppImg.qBrazilFlag,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  // ==================== ONLINE PORTRAIT LAYOUT ====================
  @pragma('vm:entry-point')
  Widget _buildOnlinePortraitLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 6.h),
          _buildTopActionBar(),
          SizedBox(height: 10.h),
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
          SizedBox(height: 10.h),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(() {
                if (controller.viewState.value ==
                    QuestionViewState.resultDistribution) {
                  return _buildResultDistributionContent(isLandscape: false);
                }
                return Column(
                  children: [
                    _buildQuestionBox(isLandscape: false),
                    SizedBox(height: 14.h),
                    _buildOnlineChatContainer(isLandscape: false),
                    SizedBox(height: 14.h),
                    _buildTimerPill(isLandscape: false),
                    SizedBox(height: 10.h),
                    _buildAnswerInputField(isLandscape: false),
                    SizedBox(height: 12.h),
                    _buildSubmitAnswerButton(isLandscape: false),
                    SizedBox(height: 14.h),
                  ],
                );
              }),
            ),
          ),
          Obx(
            () => Column(
              children: [
                _buildOnlinePlayerCard(
                  name: controller.player1.value.name,
                  score: controller.player1.value.score.toString(),
                  isTurn: controller.player1.value.isTurn,
                  avatarColor: const Color(0xFF275BEA),
                ),
                SizedBox(height: 6.h),
                _buildTeamTurnIndicatorPill(isLandscape: false),
                SizedBox(height: 6.h),
                _buildOnlinePlayerCard(
                  name: controller.player2.value.name,
                  score: controller.player2.value.score.toString(),
                  isTurn: controller.player2.value.isTurn,
                  avatarColor: const Color(0xFFE54124),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  // ==================== LANDSCAPE LAYOUT ====================
  Widget _buildLandscapeLayout(BuildContext context) {
    return _buildFigmaOfflineLandscapeLayout(context);
  }

  // ==================== FIGMA OFFLINE LANDSCAPE FLOW ====================
  Widget _buildFigmaOfflineLandscapeLayout(BuildContext context) {
    return Obx(() {
      final state = controller.viewState.value;

      if (state == QuestionViewState.resultDistribution) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              // Top Bar with back button & titles
              Row(
                children: [
                  GestureDetector(
                    onTap: controller.onResultDistributionBack,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_back, color: Colors.black87, size: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${controller.categoryTitle.value.toUpperCase()} QUESTION - ${controller.points.value} POINTS',
                          style: const TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B4A00),
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'WHICH TEAM ANSWER CORRECTLY?',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2C2416),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 36), // Balance
                ],
              ),

              const SizedBox(height: 12),

              // Content: Left = 3 Award Buttons, Right = Challenge Melas illustration
              Expanded(
                child: Row(
                  children: [
                    // Left Column: 3 Award Buttons
                    Expanded(
                      flex: 6,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildFigmaAwardButtonLandscape(
                              title: controller.player1.value.name.toUpperCase(),
                              onTap: controller.onAwardTeam1,
                            ),
                            const SizedBox(height: 10),
                            _buildFigmaAwardButtonLandscape(
                              title: controller.player2.value.name.toUpperCase(),
                              onTap: controller.onAwardTeam2,
                            ),
                            const SizedBox(height: 10),
                            _buildFigmaAwardButtonLandscape(
                              title: 'NO ONE',
                              onTap: controller.onAwardNoOne,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 24),

                    // Right: Challenge Your Melas SVG Illustration
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.challengeYourMelasImg,
                          height: 100,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const SizedBox(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      // Question or AnswerRevealed state
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Column(
          children: [
            // Top Header: Back Button + Team Turn Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: controller.onExit,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Icon(Icons.arrow_back, color: Colors.black87, size: 20),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF3B30),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "${controller.activeTeamName}'s Turn",
                    style: const TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Two-column layout in Landscape
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Side: Question Image + Subtitle + Timer
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            height: 140,
                            color: Colors.black12,
                            child: _buildDynamicQuestionMedia(
                              controller.questionImage.value,
                              width: double.infinity,
                              height: 140,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${controller.categoryTitle.value} Questions - ${controller.points.value} Points',
                          style: const TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5A482A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'TIME 1:42MIN',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00B0FF),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // Right Side: Question Text + Answer Box (if revealed) + Action Button
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Question Text
                        Text(
                          controller.questionText.value.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2C2416),
                            letterSpacing: 0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        if (state == QuestionViewState.answerRevealed) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF00C853),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'CORRECT ANSWER',
                                  style: TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF007E33),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  controller.answerText.value,
                                  style: const TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF2C2416),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 16),

                        // Action Button (Answer or Next)
                        if (state == QuestionViewState.question)
                          GestureDetector(
                            onTap: () => _showAnswerDialog(context, isLandscape: true),
                            child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF5252), Color(0xFFFF3B30)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Answer',
                                  style: TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: controller.goToResultDistribution,
                            child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF5252), Color(0xFFFF3B30)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFigmaAwardButtonLandscape({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF5252), Color(0xFFFF3B30)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: segoeFont,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  // ==================== ONLINE / LEGACY LANDSCAPE LAYOUT ====================
  @pragma('vm:entry-point')
  Widget _buildOnlineLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 4),

          // 1. TOP ACTION BAR
          Row(
            children: [
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

              Expanded(
                child: Obx(
                  () => Text(
                    '${controller.categoryTitle.value} Question – ${controller.points.value} Points',
                    style: const TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 15,
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

              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: controller.onGameOver,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3B30),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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

          // 2. MAIN DYNAMIC BODY (NON-OVERFLOWING LANDSCAPE WITH SCROLL SUPPORT)
          Expanded(
            child: Obx(() {
              final isOnline = controller.isOnlineMatch.value;

              if (controller.viewState.value ==
                  QuestionViewState.resultDistribution) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _buildResultDistributionContent(isLandscape: true),
                );
              }

              if (isOnline) {
                return Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _buildQuestionBox(isLandscape: true),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildOnlineChatContainer(isLandscape: true),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildTimerPill(isLandscape: true),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildAnswerInputField(isLandscape: true),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 140,
                          child: _buildSubmitAnswerButton(isLandscape: true),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildQuestionBox(isLandscape: true),
                    const SizedBox(height: 8),
                    _buildTimerPill(isLandscape: true),
                    const SizedBox(height: 8),
                    _buildActionButtons(isLandscape: true),
                  ],
                );
              }
            }),
          ),

          const SizedBox(height: 4),

          // 3. BOTTOM SCOREBOARD (ONLINE vs OFFLINE LANDSCAPE)
          Obx(() {
            final isOnline = controller.isOnlineMatch.value;

            if (isOnline) {
              return Row(
                children: [
                  Expanded(
                    child: _buildOnlinePlayerCard(
                      name: controller.player1.value.name,
                      score: controller.player1.value.score.toString(),
                      isTurn: controller.player1.value.isTurn,
                      avatarColor: const Color(0xFF275BEA),
                      isLandscape: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTeamTurnIndicatorPill(isLandscape: true),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildOnlinePlayerCard(
                      name: controller.player2.value.name,
                      score: controller.player2.value.score.toString(),
                      isTurn: controller.player2.value.isTurn,
                      avatarColor: const Color(0xFFE54124),
                      isLandscape: true,
                    ),
                  ),
                ],
              );
            } else {
              return Row(
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
              );
            }
          }),

          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // ==================== LIVE IN-GAME CHAT CONTAINER ====================
  Widget _buildOnlineChatContainer({required bool isLandscape}) {
    return Container(
      width: double.infinity,
      height: isLandscape ? double.infinity : 130.h,
      padding: EdgeInsets.all(isLandscape ? 8 : 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C3848).withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  final chat = controller.chatMessages[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      children: [
                        Container(
                          width: isLandscape ? 22.0 : 26.w,
                          height: isLandscape ? 22.0 : 26.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF064D5B),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: isLandscape ? 12.0 : 14.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isLandscape ? 10 : 14.w,
                            vertical: isLandscape ? 4 : 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C4556),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            chat['message'] ?? '',
                            style: TextStyle(
                              fontFamily: segoeFont,
                              fontSize: isLandscape ? 11.0 : 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          chat['time'] ?? '1:20 am',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: isLandscape ? 8.5 : 9.5.sp,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            height: isLandscape ? 30.0 : 40.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.mic_none_rounded,
                  color: Colors.grey.shade700,
                  size: isLandscape ? 14.0 : 18.sp,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: TextField(
                    controller: controller.chatInputController,
                    onSubmitted: controller.sendChatMessage,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 11.0 : 12.sp,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: StaticString.writeYourAnswer.tr,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: isLandscape ? 10.5 : 12.sp,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.sendChatMessage(
                      controller.chatInputController.text,
                    );
                  },
                  child: Container(
                    width: isLandscape ? 22.0 : 26.w,
                    height: isLandscape ? 22.0 : 26.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2979FF),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: isLandscape ? 11.0 : 13.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== TIMER PILL ====================
  Widget _buildTimerPill({required bool isLandscape}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 10 : 16.w,
        vertical: isLandscape ? 4 : 8.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF04142D),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time_rounded,
            color: Colors.white70,
            size: isLandscape ? 12 : 16.sp,
          ),
          SizedBox(width: 5.w),
          Obx(() {
            final secs = controller.remainingSeconds.value;
            final formattedSecs = secs.toString().padLeft(2, '0');
            return Text(
              '0:$formattedSecs',
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 11.5 : 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }),
        ],
      ),
    );
  }

  // ==================== ANSWER INPUT FIELD ====================
  Widget _buildAnswerInputField({required bool isLandscape}) {
    return Container(
      width: double.infinity,
      height: isLandscape ? 32.0 : 44.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C3848).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller.userAnswerController,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: isLandscape ? 11.5 : 14.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: StaticString.writeYourAnswer,
            hintStyle: TextStyle(
              fontFamily: segoeFont,
              fontSize: isLandscape ? 11.0 : 13.sp,
              color: Colors.white54,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  // ==================== SUBMIT ANSWER BUTTON ====================
  Widget _buildSubmitAnswerButton({required bool isLandscape}) {
    return GestureDetector(
      onTap: controller.submitUserAnswer,
      child: Container(
        width: double.infinity,
        height: isLandscape ? 32.0 : 46.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: const LinearGradient(
            colors: [Color(0xFF3D5AFE), Color(0xFF2979FF)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3D5AFE).withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            StaticString.submitAnswer.tr,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: isLandscape ? 12.5 : 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // ==================== TEAM TURN INDICATOR PILL ====================
  Widget _buildTeamTurnIndicatorPill({required bool isLandscape}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 12 : 20.w,
        vertical: isLandscape ? 4 : 8.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        StaticString.team2Turn.tr,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: isLandscape ? 11.0 : 13.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // ==================== ONLINE PLAYER CARD ====================
  Widget _buildOnlinePlayerCard({
    required String name,
    required String score,
    required bool isTurn,
    required Color avatarColor,
    bool isLandscape = false,
  }) {
    return Container(
      width: double.infinity,
      height: isLandscape ? 38.0 : 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2B4E),
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(
          color: isTurn ? const Color(0xFF38E5D8) : Colors.white24,
          width: isTurn ? 1.8 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: isLandscape ? 26.0 : 36.w,
            height: isLandscape ? 26.0 : 36.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarColor,
            ),
            child: Center(
              child: Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: isLandscape ? 14.0 : 18.sp,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 12.0 : 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (isTurn) ...[
                  Text(
                    StaticString.yourTurn.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 8.5 : 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF38E5D8),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: isLandscape ? 13.5 : 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== ORIGINAL OFFLINE PLAYER CARD ====================
  Widget _buildPlayerCard({
    required String name,
    required String score,
    required bool isTurn,
    required String avatarInitials,
    required Color avatarColor,
    bool isLandscape = false,
  }) {
    final double cardHeight = isLandscape ? 40.0 : 58.h;

    return Container(
      width: double.infinity,
      height: cardHeight,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: isTurn ? Colors.white : Colors.white24,
          width: isTurn ? 2.0 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: isLandscape ? 28.0 : 40.w,
            height: isLandscape ? 28.0 : 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarColor,
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
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 12.0 : 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (isTurn) ...[
                  Text(
                    StaticString.yourTurn.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 8.5 : 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF38E5D8),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            score,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: isLandscape ? 14.0 : 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== ORIGINAL OFFLINE TURN BUTTON ====================
  Widget _buildTurnButton({bool isLandscape = false}) {
    return Obx(() {
      final nextTurnName = controller.player1.value.isTurn
          ? controller.player2.value.name
          : controller.player1.value.name;

      return GestureDetector(
        onTap: controller.onTurnTap,
        child: Container(
          width: double.infinity,
          height: isLandscape ? 36 : 46.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFF3B30),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 1.w,
            ),
          ),
          child: Center(
            child: Text(
              '$nextTurnName Turn',
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 12 : 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    });
  }

  // ==================== TOP ACTION BAR ====================
  Widget _buildTopActionBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: controller.onExit,
              child: Row(
                children: [
                  const Icon(Icons.logout_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 4.w),
                  Text(
                    StaticString.exit.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: controller.onRestart,
              child: Row(
                children: [
                  const Icon(Icons.refresh_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 4.w),
                  Text(
                    StaticString.restart.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: controller.onGameOver,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3B30),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
              child: Text(
                StaticString.gameOver.tr,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // QUESTION BOX CONTAINER
  Widget _buildQuestionBox({bool isLandscape = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 10 : 16.w,
        vertical: isLandscape ? 8 : 14.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.45),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Obx(
            () => Text(
              controller.questionText.value,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 13 : 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF222222),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: isLandscape ? 4 : 10.h),

          // Question Image Graphic (Supports SVG, PNG, and Network)
          Obx(() {
            final imgPath = controller.questionImage.value;
            final isNetwork =
                imgPath.startsWith('http://') || imgPath.startsWith('https://');
            final isSvg = imgPath.endsWith('.svg');

            if (isSvg) {
              return SvgPicture.asset(
                imgPath,
                height: isLandscape ? 70 : 120.h,
                fit: BoxFit.contain,
                placeholderBuilder: (context) => Icon(
                  Icons.image_rounded,
                  size: isLandscape ? 35 : 50.sp,
                  color: Colors.white70,
                ),
              );
            } else if (isNetwork) {
              return Image.network(
                imgPath,
                height: isLandscape ? 70 : 120.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImg.flagsImg,
                    height: isLandscape ? 70 : 120.h,
                    fit: BoxFit.contain,
                  );
                },
              );
            } else {
              return Image.asset(
                imgPath,
                height: isLandscape ? 70 : 120.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.help_outline_rounded,
                    size: isLandscape ? 35 : 50.sp,
                    color: Colors.white70,
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }

  // ACTION BUTTONS FOR OFFLINE MODE
  Widget _buildActionButtons({required bool isLandscape}) {
    return Obx(() {
      final state = controller.viewState.value;

      if (state == QuestionViewState.question) {
        return SizedBox(
          width: isLandscape ? 200 : 280.w,
          height: isLandscape ? 36 : 48.h,
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
              StaticString.showAnswer.tr,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 13 : 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        );
      }

      if (isLandscape) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 190,
              height: 36,
              child: ElevatedButton.icon(
                onPressed: controller.onReturnToAnswer,
                icon: const Icon(
                  Icons.undo_rounded,
                  color: Colors.white,
                  size: 15,
                ),
                label: Text(
                  StaticString.returnToAnswer.tr,
                  style: const TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 12,
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
            SizedBox(
              width: 190,
              height: 36,
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
                  StaticString.resultDistribution.tr,
                  style: const TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return SizedBox(
          width: 280.w,
          child: Column(
            children: [
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
                    StaticString.returnToAnswer.tr,
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
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: controller.goToResultDistribution,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF3B30),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    StaticString.resultDistribution.tr,
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

  // RESULT DISTRIBUTION CONTENT (CLEAN & NON-OVERFLOWING)
  Widget _buildResultDistributionContent({required bool isLandscape}) {
    return Column(
      children: [
        SizedBox(height: isLandscape ? 4 : 6.h),

        Text(
          StaticString.whichTeamAnsweredCorrectly.tr,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: isLandscape ? 14 : 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF222222),
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: isLandscape ? 8 : 18.h),

        SizedBox(
          width: isLandscape ? 420 : double.infinity,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: controller.onAwardTeam1,
                  child: Container(
                    height: isLandscape ? 52 : 88.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
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
                          fontSize: isLandscape ? 14 : 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: isLandscape ? 10 : 16.w),
              Expanded(
                child: GestureDetector(
                  onTap: controller.onAwardTeam2,
                  child: Container(
                    height: isLandscape ? 52 : 88.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
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
                          fontSize: isLandscape ? 14 : 18.sp,
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

        SizedBox(height: isLandscape ? 8 : 18.h),

        GestureDetector(
          onTap: controller.onAwardNoOne,
          child: Container(
            width: isLandscape ? 180 : 220.w,
            height: isLandscape ? 40 : 60.h,
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B30),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                StaticString.noOne.tr,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 14 : 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: isLandscape ? 8 : 24.h),

        SizedBox(
          width: isLandscape ? 200 : 260.w,
          height: isLandscape ? 36 : 48.h,
          child: ElevatedButton.icon(
            onPressed: controller.onReturnToAnswer,
            icon: Icon(
              Icons.undo_rounded,
              color: Colors.white,
              size: isLandscape ? 15 : 18.sp,
            ),
            label: Text(
              StaticString.returnToAnswer.tr,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: isLandscape ? 12 : 14.sp,
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

        SizedBox(height: isLandscape ? 4 : 14.h),
      ],
    );
  }

  // ANSWER INPUT POPUP DIALOG MATCHING FIGMA SCREEN 6 (06_answer_dialog.png)
  void _showAnswerDialog(BuildContext context, {bool isLandscape = false}) {
    controller.userAnswerController.clear();
    controller.isSubmitting.value = false;
    controller.feedbackMessage.value = '';
    controller.isAnswerCorrect.value = null;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isLandscape ? 140 : 22.w,
            vertical: isLandscape ? 14 : 20.h,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isLandscape ? 440 : 350.w,
            ),
            padding: EdgeInsets.all(isLandscape ? 16 : 18.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFBBF24),
              borderRadius: BorderRadius.circular(isLandscape ? 18 : 22.r),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Row: Question Text + Close 'X' Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          controller.questionText.value.toUpperCase(),
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: isLandscape ? 13 : 15.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2C2416),
                            height: 1.25,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.of(dialogContext).pop(),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFF4848),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isLandscape ? 10 : 12.h),

                  // "Answer" Label
                  Text(
                    'Answer',
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 11.5 : 13.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF5A482A),
                    ),
                  ),

                  SizedBox(height: isLandscape ? 4 : 6.h),

                  // Pale Golden Input Container
                  Container(
                    height: isLandscape ? 38 : 46.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDE68A),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.6),
                        width: 1.2,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: controller.userAnswerController,
                      autofocus: true,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: isLandscape ? 13 : 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type answer here...',
                        hintStyle: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: isLandscape ? 11.5 : 13.sp,
                          color: const Color(0xFF8C7355),
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onSubmitted: (_) => controller.submitAnswerFromDialog(),
                    ),
                  ),

                  // Feedback Banner (If submitted)
                  Obx(() {
                    if (controller.feedbackMessage.value.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    final isCorrect = controller.isAnswerCorrect.value ?? false;
                    return Padding(
                      padding: EdgeInsets.only(top: isLandscape ? 6 : 8.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? const Color(0xFF00C853)
                              : const Color(0xFFE53935),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          controller.feedbackMessage.value,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: isLandscape ? 11 : 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: isLandscape ? 12 : 14.h),

                  // Submit Button (Matching Figma)
                  GestureDetector(
                    onTap: controller.submitAnswerFromDialog,
                    child: Container(
                      height: isLandscape ? 36 : 42.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF5252),
                            Color(0xFFFF3B30),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF3B30).withValues(alpha: 0.35),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: isLandscape ? 13 : 14.5.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
