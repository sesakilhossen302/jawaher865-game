import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Utils/AppIcons/app_icons.dart';
import '../../../Utils/AppImg/app_img.dart';
import '../../../Utils/StaticString/static_string.dart';
import 'Controller/sign_controller.dart';

class SignScreen extends GetView<SignController> {
  const SignScreen({super.key});

  static const String segoeFont = 'Segoe UI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Global Background Image
          Positioned.fill(
            child: Image.asset(
              AppImg.globalBackground,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF00C9A7), Color(0xFF008080)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                );
              },
            ),
          ),

          // Main Screen Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 12.0),

                  // Top Navigation Bar / Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.backIcon,
                          width: 16.0,
                          height: 16.0,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.arrow_back_ios_new,
                              size: 16.0,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Character & Logo Illustration Image
                  Image.asset(
                    AppImg.signPageImg,
                    width: Get.width * 0.58,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(height: 120.0);
                    },
                  ),

                  const Spacer(flex: 2),

                  // Buttons Section
                  Column(
                    children: [
                      // Continue with Google Button
                      _buildSocialButton(
                        onTap: () => controller.signInWithGoogle(),
                        iconPath: AppIcons.googleIcon,
                        label: StaticString.continueWithGoogle,
                        backgroundColor: const Color(0xFF1E464C).withValues(alpha: 0.7),
                        borderColor: const Color(0xFF5CA2A6).withValues(alpha: 0.4),
                        textColor: Colors.white,
                      ),

                      const SizedBox(height: 14.0),

                      // Continue with Apple Button
                      _buildSocialButton(
                        onTap: () => controller.signInWithApple(),
                        iconPath: AppIcons.appleIcon,
                        label: StaticString.continueWithApple,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                      ),

                      const SizedBox(height: 20.0),

                      // OR Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white.withValues(alpha: 0.35),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              StaticString.or,
                              style: TextStyle(
                                fontFamily: segoeFont,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withValues(alpha: 0.8),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white.withValues(alpha: 0.35),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),

                      // Sign in with Email Button
                      _buildActionButton(
                        onTap: () => controller.signInWithEmail(),
                        label: StaticString.signInWithEmail,
                        backgroundColor: Colors.white,
                        textColor: const Color(0xFF222222),
                      ),

                      const SizedBox(height: 14.0),

                      // Continue as Guest Button
                      _buildActionButton(
                        onTap: () => controller.continueAsGuest(),
                        label: StaticString.continueAsGuest,
                        backgroundColor: const Color(0xFF3358FE),
                        textColor: Colors.white,
                        isBold: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 36.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required String iconPath,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: borderColor != null
                ? BorderSide(color: borderColor, width: 1.0)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 22.0,
              height: 22.0,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.g_mobiledata, size: 24.0, color: textColor);
              },
            ),
            const SizedBox(width: 12.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: segoeFont,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    bool isBold = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52.0,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: segoeFont,
            fontSize: 16.0,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
