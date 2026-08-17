import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/terms_conditions_controller.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    Get.put(TermsConditionsController());

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

            // 2. MAIN CONTENT (Scrollable Text Body)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),

                    // TOP APP BAR
                    _buildHeader(),

                    SizedBox(height: 16.h),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 8.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTitle(StaticString.termsAndConditions),
                              SizedBox(height: 4.h),
                              _buildSubTitle(StaticString.lastUpdated),
                              SizedBox(height: 12.h),
                              _buildParagraph(
                                'By accessing or using the application, you agree to the following Terms & Conditions.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('1. Use of the App'),
                              _buildBulletPoint(
                                'You must be at least 18 years old or have parental permission.',
                              ),
                              _buildBulletPoint(
                                'You agree to provide accurate and complete information.',
                              ),
                              _buildBulletPoint(
                                'You are responsible for maintaining the confidentiality of your account.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('2. Orders & Payments'),
                              _buildBulletPoint(
                                'All prices are displayed before checkout.',
                              ),
                              _buildBulletPoint(
                                'Orders cannot be modified once confirmed.',
                              ),
                              _buildBulletPoint(
                                'Payment must be completed before order processing.',
                              ),
                              _buildBulletPoint(
                                'Delivery times are estimates and may vary.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('3. Cancellations & Refunds'),
                              _buildBulletPoint(
                                'Orders may not be canceled once preparation has started.',
                              ),
                              _buildBulletPoint(
                                'Refunds, if applicable, will be processed according to our refund policy.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('4. Availability'),
                              _buildBulletPoint(
                                'Menu items are subject to availability.',
                              ),
                              _buildBulletPoint(
                                'If an item is unavailable, it may be disabled or removed from the menu.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('5. User Conduct'),
                              _buildParagraph('You agree not to:'),
                              _buildBulletPoint('Misuse the app'),
                              _buildBulletPoint('Attempt unauthorized access'),
                              _buildBulletPoint(
                                'Provide false or misleading information',
                              ),
                              _buildBulletPoint(
                                'Disrupt or interfere with app functionality',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('6. Intellectual Property'),
                              _buildParagraph(
                                'All content, logos, designs, and trademarks used in the application are owned by us and may not be used without permission.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('7. Limitation of Liability'),
                              _buildParagraph('We are not responsible for:'),
                              _buildBulletPoint(
                                'Delays due to technical issues',
                              ),
                              _buildBulletPoint(
                                'Incorrect estimated delivery times',
                              ),
                              _buildBulletPoint(
                                'Service interruptions beyond our control',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('8. Termination'),
                              _buildParagraph(
                                'We reserve the right to suspend or terminate accounts that violate these Terms & Conditions.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('9. Changes to Terms'),
                              _buildParagraph(
                                'We may update these Terms & Conditions at any time. Continued use of the app indicates acceptance of the updated terms.',
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
            ),
          ],
        ),
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
          StaticString.termsAndConditions,
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

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: segoeFont,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSubTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: segoeFont,
        fontSize: 12.5.sp,
        color: Colors.white.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 14.5.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 13.sp,
          height: 1.4,
          color: Colors.white.withValues(alpha: 0.85),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF38E5D8),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 13.sp,
                height: 1.4,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
