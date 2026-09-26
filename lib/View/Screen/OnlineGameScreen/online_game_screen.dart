import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/online_game_controller.dart';

class OnlineGameScreen extends StatelessWidget {
  const OnlineGameScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnlineGameController());

    return Scaffold(
      backgroundColor: const Color(0xFFFBBF24),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. GLOBAL BACKGROUND IMAGE (Warm Yellow Theme)
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // 2. MAIN CONTENT LAYER
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 10.h),

                  // TOP APP BAR (Back Button & Centered "Online Game" Title)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 38.w,
                            height: 38.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.3),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.4),
                                width: 1.2,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          StaticString.onlineGame.tr,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(width: 38.w), // Balance back button
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // TEAM 1 PILL BADGE (Matching Figma Screen 3)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF5722),
                          Color(0xFFFF7A00),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF5722).withValues(alpha: 0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Team 1',
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // SUBTITLE: "Choose X categories"
                  Obx(
                    () => Text(
                      'Choose ${controller.selectedCategoryIds.length} categories',
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // 2-COLUMN CATEGORIES GRID
                  Expanded(
                    child: Obx(() {
                      final categories = controller.categories;

                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14.w,
                          mainAxisSpacing: 14.h,
                          childAspectRatio: 0.95,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final item = categories[index];
                          final isSelected = controller.isSelected(item.id);

                          return GestureDetector(
                            onTap: () => controller.toggleCategory(item.id),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF3B30),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.35),
                                  width: isSelected ? 2.5.w : 1.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected
                                        ? Colors.white.withValues(alpha: 0.5)
                                        : const Color(0xFFFF3B30).withValues(alpha: 0.3),
                                    blurRadius: isSelected ? 12 : 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      // Artwork Image
                                      Expanded(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Image.asset(
                                            item.imagePath,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Container(
                                              color: const Color(0xFF1E293B),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.image_outlined,
                                                  color: Colors.white54,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Red Title Banner at Bottom
                                      Container(
                                        height: 32.h,
                                        width: double.infinity,
                                        color: const Color(0xFFFF3B30),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                                        child: Text(
                                          item.title.toUpperCase(),
                                          style: TextStyle(
                                            fontFamily: segoeFont,
                                            fontSize: 12.sp,
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

                                  // Selected Checkmark Badge (Top Right)
                                  if (isSelected)
                                    Positioned(
                                      top: 8.h,
                                      right: 8.w,
                                      child: Container(
                                        padding: EdgeInsets.all(4.r),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF00C853),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  // 3. BOTTOM "START GAME" BUTTON
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                    child: Obx(
                      () => GestureDetector(
                        onTap: controller.onStartGame,
                        child: Container(
                          width: double.infinity,
                          height: 54.h,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF4848),
                                Color(0xFFFF7A00),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(27.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF4848).withValues(alpha: 0.45),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                StaticString.startGame.tr,
                                style: TextStyle(
                                  fontFamily: segoeFont,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                '(${controller.selectedCategoryIds.length} categories Selected)',
                                style: TextStyle(
                                  fontFamily: segoeFont,
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                              ),
                            ],
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
    );
  }
}
