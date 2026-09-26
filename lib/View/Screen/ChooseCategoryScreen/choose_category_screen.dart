import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Model/category_model.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import 'Controller/choose_category_controller.dart';

class ChooseCategoryScreen extends GetView<ChooseCategoryController> {
  const ChooseCategoryScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ChooseCategoryController>()) {
      Get.put(ChooseCategoryController());
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

            // MAIN CONTENT LAYER
            SafeArea(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  final isLandscape = orientation == Orientation.landscape;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isLandscape ? 20 : 20.w,
                      vertical: isLandscape ? 8 : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: isLandscape ? 6 : 12.h),

                        // 1. TOP HEADER BAR (Back Button + Dynamic Title)
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                padding: EdgeInsets.all(isLandscape ? 8 : 10.r),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.25),
                                ),
                                child: SvgPicture.asset(
                                  AppIcons.backIcon,
                                  width: isLandscape ? 14 : 16.w,
                                  height: isLandscape ? 14 : 16.h,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.arrow_back_ios_new,
                                      size: isLandscape ? 14 : 16.sp,
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: isLandscape ? 10 : 14.w),
                            Obx(
                              () => Text(
                                'Choose ${controller.selectedCategoryIds.isNotEmpty ? "${controller.selectedCategoryIds.length} " : "6 "}categories',
                                style: TextStyle(
                                  fontFamily: segoeFont,
                                  fontSize: isLandscape ? 16 : 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: isLandscape ? 8 : 16.h),

                        // 2. CATEGORIES GRID (4 columns in landscape, 2 in portrait)
                        Expanded(
                          child: Obx(() {
                            final items = controller.categories;
                            return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isLandscape ? 4 : 2,
                                mainAxisSpacing: isLandscape ? 10 : 16.h,
                                crossAxisSpacing: isLandscape ? 12 : 16.w,
                                childAspectRatio: isLandscape ? 1.15 : 0.82,
                              ),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final category = items[index];
                                return Obx(() {
                                  final isSelected = controller
                                      .selectedCategoryIds
                                      .contains(category.id);
                                  return _buildCategoryCard(
                                    category: category,
                                    isSelected: isSelected,
                                    isLandscape: isLandscape,
                                    onTap: () =>
                                        controller.toggleCategory(category.id),
                                  );
                                });
                              },
                            );
                          }),
                        ),

                        SizedBox(height: isLandscape ? 8 : 14.h),

                        // 3. BOTTOM START GAME ACTION BUTTON WITH SELECTION COUNT
                        Obx(() {
                          final count = controller.selectedCategoryIds.length;
                          return GestureDetector(
                            onTap: controller.onActionTap,
                            child: Container(
                              width: double.infinity,
                              height: isLandscape ? 44 : 58.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    isLandscape ? 14 : 22.r),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF4848),
                                    Color(0xFFFF7A00),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF4848)
                                        .withValues(alpha: 0.4),
                                    blurRadius: isLandscape ? 8 : 12,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Start Game',
                                    style: TextStyle(
                                      fontFamily: segoeFont,
                                      fontSize: isLandscape ? 15 : 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    count == 0
                                        ? '(Select Categories)'
                                        : '($count Selected)',
                                    style: TextStyle(
                                      fontFamily: segoeFont,
                                      fontSize: isLandscape ? 12 : 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),

                        SizedBox(height: isLandscape ? 6 : 20.h),
                      ],
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

  Widget _buildCategoryCard({
    required CategoryModel category,
    required bool isSelected,
    required VoidCallback onTap,
    bool isLandscape = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30),
          borderRadius: BorderRadius.circular(isLandscape ? 14 : 20.r),
          border: Border.all(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.25),
            width: isSelected ? (isLandscape ? 2.5 : 3.w) : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.7)
                  : const Color(0xFFFF3B30).withValues(alpha: 0.35),
              blurRadius: isSelected ? 10 : 5,
              spreadRadius: isSelected ? 1.5 : 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Top Artwork Area (Supports Network URLs, SVGs, and Local Assets)
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: _buildDynamicImage(category.imagePath ?? category.iconUrl),
              ),
            ),

            // Bottom Red Title Banner
            Container(
              height: isLandscape ? 26 : 38.h,
              width: double.infinity,
              color: const Color(0xFFFF3B30),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                category.title.toUpperCase(),
                style: TextStyle(
                  fontFamily: segoeFont,
                  fontSize: isLandscape ? 11 : 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicImage(String? path) {
    if (path == null || path.isEmpty) {
      return Container(
        color: const Color(0xFF1E293B),
        child: const Center(
          child: Icon(Icons.category, color: Colors.white70, size: 36),
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
            child: Icon(Icons.category, color: Colors.white70, size: 36),
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
          child: Icon(Icons.category, color: Colors.white70, size: 36),
        ),
      ),
    );
  }
}
