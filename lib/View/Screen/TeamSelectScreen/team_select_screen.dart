import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import '../../Widget/CustomGradientButton/custom_gradient_button.dart';
import 'Controller/team_select_controller.dart';

class TeamSelectScreen extends GetView<TeamSelectController> {
  const TeamSelectScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<TeamSelectController>()) {
      Get.put(TeamSelectController());
    } else {
      Get.find<TeamSelectController>().ensureControllersInitialized();
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // FULL PAGE BACKGROUND
            Positioned.fill(
              child: Image.asset(AppImg.globalBackground, fit: BoxFit.cover),
            ),

            // MAIN CONTENT LAYER
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),

                          // TOP HEADER BAR (Back Button + Centered Title)
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
                                  StaticString.play.tr,
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

                          SizedBox(height: 30.h),

                          // TEAM CARDS WITH OVERLAPPING VS BADGE
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Column(
                                children: [
                                  // 1. GREEN TEAM CARD (matching screenshot)
                                  _buildTeamCard(
                                    sectionTitle: StaticString.blueTeamCaps.tr,
                                    controller: controller.blueTeamController,
                                    gradientColors: const [
                                      Color(0xFF00C853),
                                      Color(0xFF10B981),
                                    ],
                                    borderColor: const Color(0xFF69F0AE).withValues(alpha: 0.6),
                                    inputBgColor: const Color(0xFF00C853).withValues(alpha: 0.25),
                                    circleColor: const Color(0xFF00E676).withValues(alpha: 0.35),
                                    labelColor: const Color(0xFFE8F5E9),
                                    illustrationSvgPath: AppIcons.blueTeamImg,
                                    illustrationHeight: 85.h,
                                    illustrationRight: 10.w,
                                    iconPreviewPath: AppImg.leaderboardRightYoungManImg,
                                  ),

                                  SizedBox(height: 16.h),

                                  // 2. RED TEAM CARD (matching screenshot)
                                  _buildTeamCard(
                                    sectionTitle: StaticString.redTeamCaps.tr,
                                    controller: controller.redTeamController,
                                    gradientColors: const [
                                      Color(0xFFFF4848),
                                      Color(0xFFFF7A00),
                                    ],
                                    borderColor: const Color(0xFFFF8B74).withValues(alpha: 0.6),
                                    inputBgColor: const Color(0xFFFF4848).withValues(alpha: 0.25),
                                    circleColor: const Color(0xFFFF7A00).withValues(alpha: 0.35),
                                    labelColor: const Color(0xFFFFEBE6),
                                    illustrationSvgPath: AppIcons.redTeamImg,
                                    illustrationHeight: 85.h,
                                    illustrationRight: 10.w,
                                    iconPreviewPath: AppImg.playRightFemaleImg,
                                  ),
                                ],
                              ),

                              // OVERLAPPING VS BADGE IN THE MIDDLE
                              Container(
                                width: 44.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFFF7A00),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.25),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    StaticString.vsText.tr,
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
                        ],
                      ),

                      SizedBox(height: 30.h),

                      // BOTTOM NEXT ACTION BUTTON (CustomGradientButton)
                      CustomGradientButton(
                        text: StaticString.next.tr,
                        onTap: controller.onNextTap,
                      ),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard({
    required String sectionTitle,
    required TextEditingController controller,
    required List<Color> gradientColors,
    required Color borderColor,
    required Color inputBgColor,
    required Color circleColor,
    required Color labelColor,
    required String illustrationSvgPath,
    required double illustrationHeight,
    required double illustrationRight,
    String? iconPreviewPath,
  }) {
    return Container(
      height: 195.h,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: borderColor, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Translucent Background Decorative Circle Matching Figma Screenshot
          Positioned(
            right: -20.w,
            bottom: -60.h,
            child: Container(
              width: 240.w,
              height: 240.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
            ),
          ),

          // Card Foreground Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title (e.g. BLUE TEAM)
                Text(
                  sectionTitle,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: labelColor,
                    letterSpacing: 1.1,
                  ),
                ),

                SizedBox(height: 8.h),

                // Editable Team Name Pill Container (Full Width)
                Container(
                  width: double.infinity,
                  height: 42.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          style: TextStyle(
                            fontFamily: segoeFont,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),

                // CHOOSE ICON Title
                Text(
                  'CHOOSE ICON',
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: labelColor,
                    letterSpacing: 1.1,
                  ),
                ),

                SizedBox(height: 6.h),

                // Choose Icon Selector Pill
                Container(
                  width: 170.w,
                  height: 38.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select icon',
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          if (iconPreviewPath != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: Image.asset(
                                iconPreviewPath,
                                width: 22.w,
                                height: 22.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const SizedBox(),
                              ),
                            ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Right Illustration SVG
          Positioned(
            right: illustrationRight,
            bottom: 0,
            child: SvgPicture.asset(
              illustrationSvgPath,
              height: illustrationHeight,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
