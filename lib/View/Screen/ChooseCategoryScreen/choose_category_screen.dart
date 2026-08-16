import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Model/category_model.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
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

                    // 1. TOP HEADER BAR (Back Button + Centered Title)
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.25),
                              ),
                              child: SvgPicture.asset(
                                AppIcons.backIcon,
                                width: 16.w,
                                height: 16.h,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 16.sp,
                                    color: Colors.white,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            StaticString.localGame,
                            style: TextStyle(
                              fontFamily: segoeFont,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 14.h),

                    // 2. ACTIVE TEAM BADGE (Blue Team / Red Team)
                    Obx(
                      () => Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 8.h,
                          ),
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
                        StaticString.choose3Categories,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 13.sp,
                          color: const Color(0xFFB4ECE7),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // 4. SEARCH BAR
                    Container(
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF065967).withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: const Color(0xFF38E5D8).withValues(alpha: 0.3),
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: const Color(0xFFB4ECE7),
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
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: StaticString.searchCategoriesHint,
                                hintStyle: TextStyle(
                                  fontFamily: segoeFont,
                                  fontSize: 14.sp,
                                  color: const Color(0xFFB4ECE7).withValues(alpha: 0.6),
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
                                'Selected (${selectedItems.length}/3)',
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
                                  'Clear All',
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
                                    color: const Color(0xFF065967).withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: const Color(0xFF38E5D8).withValues(alpha: 0.5),
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
                      StaticString.allCategories,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

                    // 8. BOTTOM ACTION BUTTON (Dynamic Green when 3 selected)
                    Obx(() {
                      final count = controller.selectedCategoryIds.length;
                      final isReady = count == 3;

                      return SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: controller.onActionTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isReady
                                ? const Color(0xFF22C55E)
                                : const Color(0xFF065967).withValues(alpha: 0.85),
                            elevation: isReady ? 6 : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                              side: BorderSide(
                                color: isReady
                                    ? const Color(0xFF4ADE80)
                                    : const Color(0xFF38E5D8),
                                width: 1.5.w,
                              ),
                            ),
                          ),
                          child: isReady
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Start Game',
                                      style: TextStyle(
                                        fontFamily: segoeFont,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '3 Categories Selected',
                                      style: TextStyle(
                                        fontFamily: segoeFont,
                                        fontSize: 11.sp,
                                        color: Colors.white.withValues(alpha: 0.9),
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Choose 3 Categories ($count/3)',
                                  style: TextStyle(
                                    fontFamily: segoeFont,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
          color: const Color(0xFF065967).withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF38E5D8)
                : const Color(0xFF38E5D8).withValues(alpha: 0.25),
            width: isSelected ? 2.w : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFF38E5D8).withValues(alpha: 0.3)
                  : Colors.transparent,
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                      ? const Color(0xFF3358FE)
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3358FE)
                        : Colors.white.withValues(alpha: 0.35),
                    width: 1.5.w,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 13.sp,
                        color: Colors.white,
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
