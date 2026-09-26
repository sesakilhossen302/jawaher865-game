import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Model/category_model.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../../Widget/CustomGradientButton/custom_gradient_button.dart';
import 'Controller/choose_category_controller.dart';

class ChooseCategoryScreen extends GetView<ChooseCategoryController> {
  const ChooseCategoryScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ChooseCategoryController>()) {
      Get.put(ChooseCategoryController());
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.h),

                      // 1. TOP HEADER BAR (Centered Title)
                      Center(
                        child: Text(
                          StaticString.localGame.tr,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    SizedBox(height: 14.h),

                    // 2. ACTIVE TEAM BADGE (Red-Coral Pill matching screenshot)
                    Obx(
                      () => Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF3B30),
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF3B30).withValues(alpha: 0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            controller.activeTeamName.value,
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

                    SizedBox(height: 8.h),

                    // 3. SUBTITLE
                    Center(
                      child: Text(
                        StaticString.choose3Categories.tr,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 13.sp,
                          color: const Color(0xFF222222),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // 4. SEARCH BAR (Glassmorphism)
                    Container(
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.45),
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: const Color(0xFF555555),
                            size: 20.sp,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TextField(
                              controller: controller.searchController,
                              onChanged: controller.onSearchChanged,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 14.sp,
                                color: const Color(0xFF222222),
                              ),
                              decoration: InputDecoration(
                                hintText: StaticString.searchCategoriesHint.tr,
                                hintStyle: TextStyle(
                                  fontFamily: segoeFont,
                                  fontSize: 14.sp,
                                  color: const Color(0xFF666666),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14.h),

                    // 5. SELECTED CHIPS SECTION (Only visible when 1+ items selected)
                    Obx(() {
                      final selectedItems = controller.selectedCategoryModels;
                      if (selectedItems.isEmpty) return const SizedBox();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${StaticString.selected.tr} (${selectedItems.length}/3)',
                                style: TextStyle(
                                  fontFamily: segoeFont,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: controller.clearAll,
                                child: Text(
                                  StaticString.clearAll.tr,
                                  style: TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: selectedItems.map((cat) {
                                return Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 7.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF3B30),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.4),
                                      width: 1.w,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        cat.title,
                                        style: TextStyle(
                                          fontFamily: segoeFont,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      GestureDetector(
                                        onTap: () => controller.removeCategory(cat.id),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          SizedBox(height: 14.h),
                        ],
                      );
                    }),

                    // 6. SECTION TITLE (All Categories)
                    Text(
                      StaticString.allCategories.tr,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF222222),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // 7. CATEGORIES GRID
                    Expanded(
                      child: Obx(() {
                        final items = controller.filteredCategories;
                        return GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14.h,
                            crossAxisSpacing: 14.w,
                            childAspectRatio: 1.25,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final category = items[index];
                            return Obx(() {
                              final isSelected = controller.selectedCategoryIds
                                  .contains(category.id);
                              return _buildCategoryCard(
                                category: category,
                                isSelected: isSelected,
                                onTap: () =>
                                    controller.toggleCategory(category.id),
                              );
                            });
                          },
                        );
                      }),
                    ),

                    SizedBox(height: 12.h),

                    // 8. BOTTOM ACTION BUTTON
                    Obx(() {
                      final count = controller.selectedCategoryIds.length;
                      final isReady = count == 3;

                      if (isReady) {
                        return CustomGradientButton(
                          text: StaticString.startGame.tr,
                          onTap: controller.onActionTap,
                        );
                      }

                      return Container(
                        width: double.infinity,
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 1.2.w,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${StaticString.choose3Categories.tr} ($count/3)',
                            style: TextStyle(
                              fontFamily: segoeFont,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF222222),
                            ),
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildCategoryCard({
    required CategoryModel category,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: const Color(0xFFFF3B30),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
            width: isSelected ? 2.5.w : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.55)
                  : const Color(0xFFFF3B30).withValues(alpha: 0.35),
              blurRadius: isSelected ? 12 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Top Right Selection Indicator Circle
            Positioned(
              top: 10.h,
              right: 10.w,
              child: Container(
                width: 22.w,
                height: 22.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? Colors.white
                      : Colors.transparent,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5.w,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 13.sp,
                        color: const Color(0xFFFF3B30),
                      )
                    : null,
              ),
            ),

            // Card Content (Center Graphic + Title)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Category Image Graphic
                  if (category.imagePath != null)
                    Image.asset(
                      category.imagePath!,
                      height: 46.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          category.iconData ?? Icons.category_rounded,
                          size: 32.sp,
                          color: category.iconColor ?? Colors.amber,
                        );
                      },
                    )
                  else
                    Icon(
                      category.iconData ?? Icons.category_rounded,
                      size: 32.sp,
                      color: category.iconColor ?? Colors.amber,
                    ),

                  SizedBox(height: 8.h),

                  // Title Text
                  Text(
                    category.title,
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
          ],
        ),
      ),
    );
  }
}
