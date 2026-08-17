import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Core/AppRoute/app_route.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/my_community_controller.dart';

class MyCommunityScreen extends StatelessWidget {
  const MyCommunityScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyCommunityController());

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
    MyCommunityController controller,
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

          SizedBox(height: 16.h),

          // 3. SEGMENTED TABS BAR
          _buildTabsBar(controller),

          SizedBox(height: 16.h),

          // 4. ACTION BUTTONS (Join Meelas & Create Meelas)
          _buildActionButtonsRow(controller),

          SizedBox(height: 16.h),

          // 5. SCROLLABLE COMMUNITY CARDS & CHAT BOX
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildMeelasCard(controller, title: StaticString.familyNight),
                  SizedBox(height: 12.h),
                  _buildMeelasCard(controller, title: StaticString.familyNight),
                  SizedBox(height: 16.h),
                  _buildLiveChatContainer(controller, isLandscape: false),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== LANDSCAPE LAYOUT (SPLIT VIEW) ====================
  Widget _buildLandscapeLayout(
    BuildContext context,
    MyCommunityController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        children: [
          // COMPACT HEADER & SUBTITLE
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
                  StaticString.myCommunity,
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

          // SUBTITLE
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

          const SizedBox(height: 8),

          // TABS AND ACTION BUTTONS ROW IN LANDSCAPE
          Row(
            children: [
              Expanded(flex: 3, child: _buildTabsBar(controller, isLandscape: true)),
              const SizedBox(width: 12),
              Expanded(flex: 2, child: _buildActionButtonsRow(controller, isLandscape: true)),
            ],
          ),

          const SizedBox(height: 10),

          // SPLIT VIEW: MEELAS CARDS ON LEFT, LIVE CHAT ON RIGHT
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // LEFT SIDE: MEELAS CARDS LIST
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildMeelasCard(controller, title: StaticString.familyNight, isLandscape: true),
                        const SizedBox(height: 10),
                        _buildMeelasCard(controller, title: StaticString.familyNight, isLandscape: true),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // RIGHT SIDE: LIVE CHAT CONTAINER
                Expanded(
                  flex: 2,
                  child: _buildLiveChatContainer(controller, isLandscape: true),
                ),
              ],
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
          StaticString.myCommunity.tr,
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
        StaticString.myCommunityTagline.tr,
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

  // ==================== TABS BAR ====================
  Widget _buildTabsBar(MyCommunityController controller, {bool isLandscape = false}) {
    final tabs = [
      {'icon': Icons.person_outline_rounded, 'label': StaticString.myMeelas},
      {'icon': Icons.favorite_border_rounded, 'label': StaticString.friends},
      {'icon': Icons.emoji_events_outlined, 'label': StaticString.featuredMeelas},
    ];

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tabs.length, (index) {
            final isSelected = controller.selectedTabIndex.value == index;
            final item = tabs[index];

            return GestureDetector(
              onTap: () => controller.changeTab(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        size: isLandscape ? 13 : 16.sp,
                        color: isSelected ? Colors.white : Colors.white60,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: isLandscape ? 11 : 13.5.sp,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.white60,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 3.h,
                    width: isLandscape ? 70 : 80.w,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // ==================== ACTION BUTTONS ROW ====================
  Widget _buildActionButtonsRow(MyCommunityController controller, {bool isLandscape = false}) {
    return Row(
      children: [
        // Join Meelas Blue Button
        Expanded(
          child: SizedBox(
            height: isLandscape ? 36 : 46.h,
            child: ElevatedButton(
              onPressed: controller.onJoinMeelas,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3358FE),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.r),
                ),
              ),
              child: Text(
                StaticString.joinMeelas.tr,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 12 : 14.5.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // Create Meelas Dark Button
        Expanded(
          child: SizedBox(
            height: isLandscape ? 36 : 46.h,
            child: ElevatedButton(
              onPressed: controller.onCreateMeelas,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF076372).withValues(alpha: 0.5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.r),
                  side: BorderSide(
                    color: const Color(0xFF38E5D8).withValues(alpha: 0.4),
                    width: 1.2.w,
                  ),
                ),
              ),
              child: Text(
                StaticString.createMeelas.tr,
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 12 : 14.5.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==================== MEELAS COMMUNITY CARD ====================
  Widget _buildMeelasCard(
    MyCommunityController controller, {
    required String title,
    bool isLandscape = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left: Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 13 : 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  StaticString.playersOnlineNow,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 10 : 11.5.sp,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),

          // Center: Overlapping Avatars Stack + Badge
          SizedBox(
            width: isLandscape ? 100 : 120.w,
            height: isLandscape ? 32 : 36.h,
            child: Stack(
              children: [
                for (int i = 0; i < 4; i++)
                  Positioned(
                    left: (i * 18).toDouble(),
                    child: CircleAvatar(
                      radius: isLandscape ? 14 : 17.r,
                      backgroundColor: const Color(0xFF38E5D8),
                      child: CircleAvatar(
                        radius: isLandscape ? 13 : 16.r,
                        backgroundColor: const Color(0xFF075E6C),
                        child: Text(
                          '👤',
                          style: TextStyle(fontSize: isLandscape ? 10 : 12.sp),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: (4 * 18).toDouble(),
                  child: CircleAvatar(
                    radius: isLandscape ? 14 : 17.r,
                    backgroundColor: const Color(0xFF0A2E44),
                    child: Text(
                      '5/6',
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: isLandscape ? 9 : 11.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Right: View & Chat Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // View Button
              GestureDetector(
                onTap: () => Get.toNamed(AppRoute.roomNameScreen),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF076372).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
                      width: 1.w,
                    ),
                  ),
                  child: Text(
                    StaticString.viewArrow.tr,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 10.5 : 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 6.w),

              // Chat Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF3358FE),
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3358FE).withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  StaticString.chat.tr,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 10.5 : 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== LIVE CHAT CONTAINER ====================
  Widget _buildLiveChatContainer(
    MyCommunityController controller, {
    required bool isLandscape,
  }) {
    return Container(
      width: double.infinity,
      height: isLandscape ? double.infinity : 240.h,
      padding: EdgeInsets.all(isLandscape ? 10 : 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // MESSAGES LIST
          Expanded(
            child: Obx(
              () => ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  final chat = controller.chatMessages[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: isLandscape ? 12 : 15.r,
                          backgroundColor: const Color(0xFF38E5D8),
                          child: CircleAvatar(
                            radius: isLandscape ? 11 : 14.r,
                            backgroundColor: const Color(0xFF075E6C),
                            child: Text(
                              '👦',
                              style: TextStyle(fontSize: isLandscape ? 9 : 11.sp),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF076372).withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
                              width: 1.w,
                            ),
                          ),
                          child: Text(
                            chat['message'] ?? '',
                            style: TextStyle(
                              fontFamily: segoeFont,
                              fontSize: isLandscape ? 11 : 13.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          chat['time'] ?? '1:20 am',
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: isLandscape ? 9 : 10.sp,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // BOTTOM CHAT INPUT BAR (Mic on Left + Send Paper Plane on Right)
          Container(
            height: isLandscape ? 36 : 46.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.mic_none_rounded,
                  color: Colors.grey.shade700,
                  size: isLandscape ? 16 : 20.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    controller: controller.chatInputController,
                    onSubmitted: controller.sendChatMessage,
                    style: TextStyle(
                      fontFamily: segoeFont,
                      fontSize: isLandscape ? 11 : 13.sp,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: StaticString.writeYourAnswer,
                      hintStyle: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: isLandscape ? 11 : 12.5.sp,
                        color: Colors.grey,
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
                    width: isLandscape ? 24 : 30.w,
                    height: isLandscape ? 24 : 30.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2979FF),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: isLandscape ? 12 : 14.sp,
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
}
