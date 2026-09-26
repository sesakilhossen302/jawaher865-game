import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/play_controller.dart';

class PlayScreen extends GetView<PlayController> {
  const PlayScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<PlayController>()) {
      Get.put(PlayController());
    }

    return Column(
      children: [
        SizedBox(height: 14.h),

        // TOP HEADER TITLE (Play)
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

        SizedBox(height: 16.h),

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // 1. CARD 1: Challenge Your Melas (Green Card matching screenshot)
                _buildChallengeCard(
                  title: StaticString.challengeYourMelas.tr,
                  subtitle: StaticString.playTogetherOnOneDevice.tr,
                  buttonText: StaticString.startNow.tr,
                  badgeIcon: Icons.people_outline_rounded,
                  illustrationSvgPath: AppIcons.challengeYourMelasImg,
                  illustrationHeight: 90.h,
                  gradientColors: const [
                    Color(0xFF00C853),
                    Color(0xFF10B981),
                  ],
                  borderColor: const Color(0xFF69F0AE).withValues(alpha: 0.6),
                  buttonColor: const Color(0xFF00E676),
                  badgeColor: const Color(0xFF00C853).withValues(alpha: 0.9),
                  circleColor: const Color(0xFF00E676).withValues(alpha: 0.35),
                  subtitleColor: const Color(0xFFE8F5E9),
                  onTap: controller.onStartNowTap,
                ),

                SizedBox(height: 16.h),

                // 2. CARD 2: Challenge Other Melases (Orange-Coral Card matching screenshot)
                _buildChallengeCard(
                  title: StaticString.challengeOtherMelases.tr,
                  subtitle: StaticString.challengePlayersOnline.tr,
                  buttonText: StaticString.playOnline.tr,
                  badgeIcon: Icons.language_rounded,
                  illustrationSvgPath: AppIcons.challengeOtherMelasesImg,
                  gradientColors: const [
                    Color(0xFFFF4848),
                    Color(0xFFFF7A00),
                  ],
                  borderColor: const Color(0xFFFF8B74).withValues(alpha: 0.6),
                  buttonColor: const Color(0xFFFF5722),
                  badgeColor: const Color(0xFFFF4848).withValues(alpha: 0.9),
                  circleColor: const Color(0xFFFF7A00).withValues(alpha: 0.35),
                  subtitleColor: const Color(0xFFFFEBE6),
                  onTap: controller.onPlayOnlineTap,
                ),

                SizedBox(height: 16.h),

                // 3. CARD 3: My Community (Warm Deep Coral Card)
                _buildChallengeCard(
                  title: StaticString.myCommunity.tr,
                  subtitle: StaticString.myCommunityTagline.tr,
                  buttonText: '${StaticString.view.tr} ↗',
                  badgeIcon: Icons.groups_rounded,
                  illustrationSvgPath: AppIcons.challengeYourMelasImg,
                  gradientColors: const [
                    Color(0xFFFF5252),
                    Color(0xFFFF7043),
                  ],
                  borderColor: const Color(0xFFFFAB91).withValues(alpha: 0.6),
                  buttonColor: const Color(0xFFFF5722),
                  badgeColor: const Color(0xFFFF7043).withValues(alpha: 0.9),
                  circleColor: const Color(0xFFFF8A65).withValues(alpha: 0.35),
                  subtitleColor: const Color(0xFFFBE9E7),
                  onTap: controller.onCommunityTap,
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String subtitle,
    required String buttonText,
    required IconData badgeIcon,
    required String illustrationSvgPath,
    double? illustrationHeight,
    required List<Color> gradientColors,
    required Color borderColor,
    required Color buttonColor,
    required Color badgeColor,
    required Color circleColor,
    required Color subtitleColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 190.h,
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
            // Background Decorative Circles (Gol Gol Bubbles)
            Positioned(
              right: -30.w,
              top: -30.h,
              child: Container(
                width: 170.w,
                height: 170.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleColor,
                ),
              ),
            ),

            Positioned(
              left: -40.w,
              bottom: -40.h,
              child: Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleColor,
                ),
              ),
            ),

            // Card Foreground Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Section (Badge + Title + Subtitle)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top Badge Icon
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Icon(
                          badgeIcon,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Title Text
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 4.h),

                      // Subtitle Text
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: segoeFont,
                          fontSize: 11.sp,
                          color: subtitleColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // Action Button Pill
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontFamily: segoeFont,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right Illustration SVG
            Positioned(
              right: 8.w,
              bottom: 0,
              child: SvgPicture.asset(
                illustrationSvgPath,
                height: illustrationHeight ?? 90.h,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
