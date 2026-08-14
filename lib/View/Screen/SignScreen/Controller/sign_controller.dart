import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Utils/ToastMessage/toast_message.dart';

class SignController extends GetxController {
  void signInWithGoogle() {
    ToastMessage.showSuccessToast('Google sign in clicked');
  }

  void signInWithApple() {
    ToastMessage.showSuccessToast('Apple sign in clicked');
  }

  void signInWithEmail() {
    Get.toNamed(AppRoute.signInEmailScreen);
  }

  void continueAsGuest() {
    ToastMessage.showSuccessToast('Continue as guest clicked');
  }
}
