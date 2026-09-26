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

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.onBackTap();
        }
      },
      child: Scaffold(
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
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    final isLandscape = orientation == Orientation.landscape;
                    if (isLandscape) {
                      return _buildLandscapeContent(context);
                    }
                    return _buildPortraitContent(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLandscapeContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          // TOP HEADER BAR (Back Button + Centered Title)
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: controller.onBackTap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.backIcon,
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.arrow_back_ios_new,
                          size: 16,
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
                  style: const TextStyle(
                    fontFamily: segoeFont,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // TEAM CARDS SIDE-BY-SIDE WITH VS BADGE
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildTeamCard(
                      sectionTitle: 'GREEN TEAM',
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
                      illustrationHeight: 85,
                      illustrationRight: 8,
                      iconPreviewPath: AppImg.leaderboardRightYoungManImg,
                      isLandscape: true,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: _buildTeamCard(
                      sectionTitle: 'RED TEAM',
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
                      illustrationHeight: 85,
                      illustrationRight: 8,
                      iconPreviewPath: AppImg.playRightFemaleImg,
                      isLandscape: true,
                    ),
                  ),
                ],
              ),

              // OVERLAPPING VS BADGE IN THE MIDDLE
              Container(
                width: 44,
                height: 44,
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
                    style: const TextStyle(
                      fontFamily: segoeFont,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // BOTTOM NEXT ACTION BUTTON
          SizedBox(
            width: 320,
            child: CustomGradientButton(
              text: StaticString.next.tr,
              onTap: controller.onNextTap,
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildPortraitContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
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
                        onTap: controller.onBackTap,
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
                          isLandscape: false,
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
                          isLandscape: false,
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
    bool isLandscape = false,
  }) {
    return Container(
      height: isLandscape ? 180 : 195.h,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isLandscape ? 18 : 24.r),
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
            right: isLandscape ? -10 : -20.w,
            bottom: isLandscape ? -30 : -60.h,
            child: Container(
              width: isLandscape ? 180 : 240.w,
              height: isLandscape ? 180 : 240.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: circleColor,
              ),
            ),
          ),

          // Card Foreground Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 14 : 18.w,
              vertical: isLandscape ? 10 : 14.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Title (e.g. BLUE TEAM)
                Text(
                  sectionTitle,
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 11 : 11.sp,
                    fontWeight: FontWeight.bold,
                    color: labelColor,
                    letterSpacing: 1.1,
                  ),
                ),

                SizedBox(height: isLandscape ? 6 : 8.h),

                // Editable Team Name Pill Container (Full Width)
                Container(
                  width: double.infinity,
                  height: isLandscape ? 36 : 42.h,
                  padding: EdgeInsets.symmetric(horizontal: isLandscape ? 10 : 14.w),
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
                            fontSize: isLandscape ? 14 : 15.sp,
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
                        size: isLandscape ? 15 : 16.sp,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isLandscape ? 6 : 10.h),

                // CHOOSE ICON Title
                Text(
                  'CHOOSE ICON',
                  style: TextStyle(
                    fontFamily: segoeFont,
                    fontSize: isLandscape ? 10 : 10.sp,
                    fontWeight: FontWeight.bold,
                    color: labelColor,
                    letterSpacing: 1.1,
                  ),
                ),

                SizedBox(height: isLandscape ? 4 : 6.h),

                // Choose Icon Selector Pill (Responsive, no overflow)
                Container(
                  height: isLandscape ? 36 : 38.h,
                  padding: EdgeInsets.symmetric(horizontal: isLandscape ? 10 : 12.w),
                  decoration: BoxDecoration(
                    color: inputBgColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Select icon',
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: isLandscape ? 11 : 12.sp,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: isLandscape ? 8 : 8.w),
                      if (iconPreviewPath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: Image.asset(
                            iconPreviewPath,
                            width: isLandscape ? 20 : 22.w,
                            height: isLandscape ? 20 : 22.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const SizedBox(),
                          ),
                        ),
                      SizedBox(width: isLandscape ? 4 : 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: isLandscape ? 16 : 18.sp,
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
