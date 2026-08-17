import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/support_contact_controller.dart';

class SupportContactScreen extends StatelessWidget {
  const SupportContactScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupportContactController());

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

            // 2. MAIN CONTENT (Scrollable)
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
                        child: Column(
                          children: [
                            // FORM CARD BOX
                            _buildFormCard(controller),

                            SizedBox(height: 24.h),

                            // SUBMIT BUTTON
                            _buildSubmitButton(controller),

                            SizedBox(height: 20.h),
                          ],
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
          StaticString.supportAndContact.tr,
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

  // ==================== FORM CARD ====================
  Widget _buildFormCard(SupportContactController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Title
          Text(
            StaticString.supportAndContact.tr,
            style: TextStyle(
              fontFamily: segoeFont,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16.h),

          // 1. Full Name Field
          _buildFieldLabel(StaticString.fullName.tr),
          SizedBox(height: 6.h),
          _buildInputField(
            textController: controller.fullNameController,
            hintText: StaticString.fullName.tr,
            prefixIcon: Icons.person_outline_rounded,
          ),

          SizedBox(height: 14.h),

          // 2. Email Field
          _buildFieldLabel(StaticString.email.tr),
          SizedBox(height: 6.h),
          _buildInputField(
            textController: controller.emailController,
            hintText: StaticString.exampleEmail.tr,
            keyboardType: TextInputType.emailAddress,
          ),

          SizedBox(height: 14.h),

          // 3. Subject Field
          _buildFieldLabel(StaticString.subject.tr),
          SizedBox(height: 6.h),
          _buildInputField(
            textController: controller.subjectController,
            hintText: StaticString.writeYourSubject.tr,
          ),

          SizedBox(height: 14.h),

          // 4. Feedback Multiline Text Area
          _buildFieldLabel(StaticString.feedback.tr),
          SizedBox(height: 6.h),
          _buildFeedbackTextArea(controller),
        ],
      ),
    );
  }

  // FIELD LABEL WIDGET
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: segoeFont,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white.withValues(alpha: 0.9),
      ),
    );
  }

  // INPUT FIELD WIDGET
  Widget _buildInputField({
    required TextEditingController textController,
    required String hintText,
    IconData? prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
      ),
      child: TextField(
        controller: textController,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 14.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: prefixIcon == null ? 14.w : 0,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 18.sp,
                )
              : null,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: segoeFont,
            fontSize: 13.5.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }

  // FEEDBACK MULTILINE TEXT AREA WIDGET
  Widget _buildFeedbackTextArea(SupportContactController controller) {
    return Container(
      height: 130.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A6372).withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF38E5D8).withValues(alpha: 0.35),
          width: 1.w,
        ),
      ),
      child: TextField(
        controller: controller.feedbackController,
        maxLines: 5,
        style: TextStyle(
          fontFamily: segoeFont,
          fontSize: 14.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: StaticString.writeYourFeedbackHere.tr,
          hintStyle: TextStyle(
            fontFamily: segoeFont,
            fontSize: 13.5.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }

  // ==================== SUBMIT BUTTON ====================
  Widget _buildSubmitButton(SupportContactController controller) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: controller.onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3358FE),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        child: Text(
          StaticString.submit.tr,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
