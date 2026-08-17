import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import 'Controller/online_game_controller.dart';
import 'Model/online_game_model.dart';

class OnlineGameScreen extends StatelessWidget {
  const OnlineGameScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnlineGameController());

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

              // 2. MAIN CONTENT WITH ORIENTATION SWITCHER
              SafeArea(
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    final mediaSize = MediaQuery.of(context).size;
                    final isLandscape =
                        orientation == Orientation.landscape ||
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
    OnlineGameController controller,
  ) {
    return Column(
      key: const ValueKey('PortraitOnlineGameNew'),
      children: [
        SizedBox(height: 8.h),

        // TOP APP BAR
        _buildHeader(context),

        SizedBox(height: 6.h),

        // SUBTITLE
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            "Create your own championship and challenge them; it's time for a challenge with Freej Trivia.",
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Column(
                children: [
                  // TEAM 1 CARD CONTAINER
                  _buildTeamBoxContainer(
                    teamTitle: 'Team 1',
                    players: team1,
                    showActionRow: true,
                    controller: controller,
                  ),

                  SizedBox(height: 16.h),

                  // TEAM 2 CARD CONTAINER
                  _buildTeamBoxContainer(
                    teamTitle: 'Team 2',
                    players: team2,
                    showActionRow: false,
                    controller: controller,
                  ),

                  SizedBox(height: 24.h),

                  // CONTINUE BUTTON
                  _buildContinueButton(controller),

                  SizedBox(height: 10.h),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // ==================== COMPACT LANDSCAPE LAYOUT (SINGLE PAGE FIT) ====================
  Widget _buildLandscapeLayout(
    BuildContext context,
    OnlineGameController controller,
  ) {
    return Column(
      key: const ValueKey('LandscapeOnlineGameCompact'),
      children: [
        // COMPACT HEADER
        _buildHeader(context, isLandscape: true),

        // COMPACT SUBTITLE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Create your own championship and challenge them; it's time for a challenge with Freej Trivia.",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: segoeFont,
              fontSize: 9.5,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
              height: 1.1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        const SizedBox(height: 4),

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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // LEFT TEAM CONTAINER (TEAM 1)
                        Expanded(
                          child: _buildTeamBoxContainer(
                            teamTitle: 'Team 1',
                            players: team1,
                            showActionRow: true,
                            controller: controller,
                            isLandscape: true,
                          ),
                        ),

                        const SizedBox(width: 14),

                        // RIGHT TEAM CONTAINER (TEAM 2)
                        Expanded(
                          child: _buildTeamBoxContainer(
                            teamTitle: 'Team 2',
                            players: team2,
                            showActionRow: false,
                            controller: controller,
                            isLandscape: true,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  // CONTINUE BUTTON IN LANDSCAPE
                  _buildContinueButton(controller, isLandscape: true),

                  const SizedBox(height: 2),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  // ==================== HEADER ====================
  Widget _buildHeader(BuildContext context, {bool isLandscape = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLandscape ? 20.0 : 16.w,
        vertical: isLandscape ? 2.0 : 4.h,
      ),
      child: Center(
        child: Text(
          'Online Game',
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: isLandscape ? 16.0 : 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ==================== TEAM BOX CONTAINER ====================
  Widget _buildTeamBoxContainer({
    required String teamTitle,
    required List<OnlinePlayerModel> players,
    required bool showActionRow,
    required OnlineGameController controller,
    bool isLandscape = false,
  }) {
    return Container(
      width: double.infinity,
      padding: isLandscape
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
          : EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C3848).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(isLandscape ? 18 : 24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // HEADER ROW (Team Title & Edit Pencil)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                teamTitle,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 13.0 : 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.mode_edit_outline_rounded,
                color: Colors.white70,
                size: isLandscape ? 13.0 : 18.sp,
              ),
            ],
          ),

          SizedBox(height: isLandscape ? 6.0 : 12.h),

          // PLAYER CARDS LIST
          ...players.map(
            (player) => Padding(
              padding: EdgeInsets.only(bottom: isLandscape ? 5.0 : 10.h),
              child: _buildInnerPlayerCard(
                player: player,
                isLandscape: isLandscape,
              ),
            ),
          ),

          // ACTION ROW (Off & Chat buttons)
          if (showActionRow) ...[
            SizedBox(height: isLandscape ? 4.0 : 6.h),
            Row(
              children: [
                // OFF / MIC BUTTON
                Expanded(
                  child: Obx(
                    () => GestureDetector(
                      onTap: controller.toggleMic,
                      child: Container(
                        height: isLandscape ? 28.0 : 38.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2837),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white24, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              controller.isMicOn.value
                                  ? Icons.mic_rounded
                                  : Icons.mic_off_rounded,
                              color: controller.isMicOn.value
                                  ? const Color(0xFF38E5D8)
                                  : Colors.redAccent,
                              size: isLandscape ? 13.0 : 16.sp,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              controller.isMicOn.value ? 'On' : 'Off',
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: isLandscape ? 11.0 : 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // CHAT BUTTON
                Expanded(
                  child: Container(
                    height: isLandscape ? 28.0 : 38.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D5AFE),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3D5AFE).withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Colors.white,
                          size: isLandscape ? 12.0 : 15.sp,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Chat',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: isLandscape ? 11.0 : 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ==================== INNER PLAYER CARD ====================
  Widget _buildInnerPlayerCard({
    required OnlinePlayerModel player,
    bool isLandscape = false,
  }) {
    final double cardHeight = isLandscape ? 37.0 : 48.h;

    return Container(
      width: double.infinity,
      height: cardHeight,
      padding: EdgeInsets.symmetric(horizontal: isLandscape ? 8.0 : 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2B4E),
        borderRadius: BorderRadius.circular(isLandscape ? 18 : 24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          // Circular Avatar (Network Image or First Letter)
          Builder(
            builder: (context) {
              final firstLetter = player.name.isNotEmpty
                  ? player.name[0].toUpperCase()
                  : '?';

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
                        fontSize: isLandscape ? 12.0 : 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }

              return Container(
                width: isLandscape ? 26.0 : 36.w,
                height: isLandscape ? 26.0 : 36.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF38E5D8),
                    width: 1.0,
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

          SizedBox(width: isLandscape ? 8.0 : 12.w),

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
                    fontSize: isLandscape ? 11.0 : 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (player.isYourTeam) ...[
                  Text(
                    'Your',
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 8.0 : 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF38E5D8),
                      height: 1.0,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Edit Pencil Icon on right side of card
          Icon(
            Icons.mode_edit_outline_rounded,
            color: Colors.white54,
            size: isLandscape ? 12.0 : 16.sp,
          ),
        ],
      ),
    );
  }

  // ==================== CONTINUE BUTTON ====================
  Widget _buildContinueButton(
    OnlineGameController controller, {
    bool isLandscape = false,
  }) {
    return GestureDetector(
      onTap: controller.onContinueTap,
      child: Container(
        width: isLandscape ? 260.0 : double.infinity,
        height: isLandscape ? 36.0 : 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isLandscape ? 20 : 28.r),
          gradient: const LinearGradient(
            colors: [Color(0xFF3D5AFE), Color(0xFF2979FF)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3D5AFE).withValues(alpha: 0.45),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Continue',
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: isLandscape ? 13.5 : 17.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
