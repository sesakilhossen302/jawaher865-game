import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/room_name_controller.dart';

class RoomNameScreen extends StatelessWidget {
  const RoomNameScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoomNameController());

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
    RoomNameController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),

          // 1. TOP HEADER
          _buildHeader(),

          SizedBox(height: 8.h),

          // 2. SUBTITLE
          _buildSubtitle(),

          SizedBox(height: 24.h),

          // 3. SECTION TITLE: Room matches
          Text(
            StaticString.roomMatches.tr,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // 4. PLAYER CARDS GRID / ROW
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: 16.w,
                runSpacing: 16.h,
                children: List.generate(
                  controller.roomMatchesList.length,
                  (index) => _buildPlayerCard(
                    controller,
                    index: index,
                    isLandscape: false,
                  ),
                ),
              ),
            ),
          ),

          // 5. SHARE MEELAS BUTTON
          Center(child: _buildShareButton(controller, isLandscape: false)),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ==================== LANDSCAPE LAYOUT ====================
  Widget _buildLandscapeLayout(
    BuildContext context,
    RoomNameController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  StaticString.roomName,
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

          const SizedBox(height: 12),

          // 3. SECTION TITLE: Room matches
          Text(
            StaticString.roomMatches,
            style: const TextStyle(
              fontFamily: segoeFont,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          // 4. HORIZONTAL PLAYER CARDS ROW
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                  controller.roomMatchesList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _buildPlayerCard(
                      controller,
                      index: index,
                      isLandscape: true,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 5. SHARE MEELAS BUTTON
          Center(child: _buildShareButton(controller, isLandscape: true)),

          const SizedBox(height: 10),
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
          StaticString.roomName.tr,
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

  // ==================== PLAYER CARD ====================
  Widget _buildPlayerCard(
    RoomNameController controller, {
    required int index,
    required bool isLandscape,
  }) {
    final item = controller.roomMatchesList[index];

    return Container(
      width: isLandscape ? 150 : 155.w,
      height: isLandscape ? 165 : 185.h,
      padding: EdgeInsets.all(isLandscape ? 10 : 12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF095264).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 3-DOT MENU BUTTON ON TOP RIGHT
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => controller.onCardOptionsTap(index),
              child: Container(
                width: isLandscape ? 24 : 28.w,
                height: isLandscape ? 24 : 28.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
                    width: 1.w,
                  ),
                ),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: isLandscape ? 14 : 16.sp,
                ),
              ),
            ),
          ),

          // MAIN AVATAR & NAME COLUMN
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: isLandscape ? 8 : 12.h),

                // CIRCULAR AVATAR WITH SKIN TONE
                Container(
                  width: isLandscape ? 70 : 84.w,
                  height: isLandscape ? 70 : 84.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF7E2C7), // Skin tone background
                    border: Border.all(
                      color: const Color(0xFF38E5D8).withValues(alpha: 0.5),
                      width: 1.5.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '🧔',
                      style: TextStyle(fontSize: isLandscape ? 36 : 46.sp),
                    ),
                  ),
                ),

                SizedBox(height: isLandscape ? 10 : 14.h),

                // PLAYER NAME
                Text(
                  item['name'] ?? StaticString.kadirAli,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 13.5 : 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SHARE BUTTON ====================
  Widget _buildShareButton(
    RoomNameController controller, {
    required bool isLandscape,
  }) {
    return SizedBox(
      width: isLandscape ? 300 : 260.w,
      height: isLandscape ? 42 : 50.h,
      child: ElevatedButton(
        onPressed: controller.onShareMeelas,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3358FE),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        child: Text(
          StaticString.shareMeelas.tr,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: isLandscape ? 14 : 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
