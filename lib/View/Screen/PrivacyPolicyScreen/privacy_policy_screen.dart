import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/privacy_policy_controller.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    Get.put(PrivacyPolicyController());

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
                              _buildTitle(StaticString.privacyPolicy),
                              SizedBox(height: 4.h),
                              _buildSubTitle(StaticString.lastUpdated),
                              SizedBox(height: 12.h),
                              _buildParagraph(
                                'Welcome to our app. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile application and related services.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('1. Information We Collect'),
                              _buildParagraph(
                                'We may collect the following types of information:',
                              ),
                              _buildSubSectionHeader('a. Personal Information'),
                              _buildBulletPoint('Name'),
                              _buildBulletPoint('Email address'),
                              _buildBulletPoint('Phone number'),
                              _buildBulletPoint('Account login details'),
                              SizedBox(height: 6.h),
                              _buildSubSectionHeader(
                                'b. Order & Usage Information',
                              ),
                              _buildBulletPoint('Order history'),
                              _buildBulletPoint('Delivery address'),
                              _buildBulletPoint('Favorite items and preferences'),
                              _buildBulletPoint('App usage activity'),
                              SizedBox(height: 6.h),
                              _buildSubSectionHeader('c. Device Information'),
                              _buildBulletPoint('Device type'),
                              _buildBulletPoint('Operating system'),
                              _buildBulletPoint('App version'),

                              SizedBox(height: 14.h),
                              _buildSectionHeader(
                                '2. How We Use Your Information',
                              ),
                              _buildParagraph('We use your information to:'),
                              _buildBulletPoint('Process and manage orders'),
                              _buildBulletPoint(
                                'Send order status updates and notifications',
                              ),
                              _buildBulletPoint(
                                'Improve app performance and user experience',
                              ),
                              _buildBulletPoint(
                                'Send promotional emails or offers (only if you subscribe)',
                              ),
                              _buildBulletPoint('Provide customer support'),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('3. Email Subscription'),
                              _buildParagraph(
                                'If you choose to subscribe to our emails, we may send daily deals, new product announcements, and exclusive offers. You may unsubscribe at any time from the app or through the email link.',
                              ),

                              SizedBox(height: 14.h),
                              _buildSectionHeader('4. Data Sharing'),
                              _buildParagraph(
                                'We do not sell or rent your personal information. We may share information only with trusted payment service providers and service partners to operate the application securely.',
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
          StaticString.privacyPolicy,
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

  Widget _buildSubSectionHeader(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 2.h),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF38E5D8),
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
      padding: EdgeInsets.only(left: 12.w, bottom: 4.h),
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
