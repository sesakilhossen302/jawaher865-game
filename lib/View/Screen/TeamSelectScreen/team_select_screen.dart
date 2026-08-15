import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/team_select_controller.dart';

class TeamSelectScreen extends GetView<TeamSelectController> {
  const TeamSelectScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
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
                                  StaticString.play,
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
                                  // 1. BLUE TEAM CARD
                                  _buildTeamCard(
                                    sectionTitle: StaticString.blueTeamCaps,
                                    controller: controller.blueTeamController,
                                    gradientColors: const [
                                      Color(0xFF275BEA),
                                      Color(0xFF3B72FE),
                                    ],
                                    borderColor: const Color(0xFF67B0FF).withValues(alpha: 0.6),
                                    inputBgColor: const Color(0xFF4A7FFF).withValues(alpha: 0.35),
                                    circleColor: const Color(0xFF4A7FFF).withValues(alpha: 0.35),
                                    labelColor: const Color(0xFFD4E3FF),
                                    illustrationSvgPath: AppIcons.blueTeamImg,
                                    illustrationHeight: 85.h,
                                    illustrationRight: 22.w,
                                  ),

                                  SizedBox(height: 16.h),

                                  // 2. RED TEAM CARD
                                  _buildTeamCard(
                                    sectionTitle: StaticString.redTeamCaps,
                                    controller: controller.redTeamController,
                                    gradientColors: const [
                                      Color(0xFFE54124),
                                      Color(0xFFF15934),
                                    ],
                                    borderColor: const Color(0xFFFF8B74).withValues(alpha: 0.6),
                                    inputBgColor: const Color(0xFFF86649).withValues(alpha: 0.35),
                                    circleColor: const Color(0xFFFF7256).withValues(alpha: 0.35),
                                    labelColor: const Color(0xFFFFDCD5),
                                    illustrationSvgPath: AppIcons.redTeamImg,
                                    illustrationHeight: 85.h,
                                    illustrationRight: 14.w,
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
                                    StaticString.vsText,
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

                      // BOTTOM NEXT ACTION BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 54.h,
                        child: ElevatedButton(
                          onPressed: controller.onNextTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3358FE),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                              side: BorderSide(
                                color: const Color(0xFF38E5D8),
                                width: 1.5.w,
                              ),
                            ),
                          ),
                          child: Text(
                            StaticString.next,
                            style: TextStyle(
                              fontFamily: segoeFont,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
  }) {
    return Container(
      height: 180.h,
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
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
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

                SizedBox(height: 10.h),

                // Editable Team Name Pill Container (Full Width)
                Container(
                  width: double.infinity,
                  height: 48.h,
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
                            fontSize: 16.sp,
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
