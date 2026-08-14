import 'package:get/get.dart';
import '../../../../Utils/ToastMessage/toast_message.dart';

class SignController extends GetxController {
  void signInWithGoogle() {
    ToastMessage.showSuccessToast('Google sign in clicked');
  }

  void signInWithApple() {
    ToastMessage.showSuccessToast('Apple sign in clicked');
  }

  void signInWithEmail() {
    ToastMessage.showSuccessToast('Email sign in clicked');
  }

  void continueAsGuest() {
    ToastMessage.showSuccessToast('Continue as guest clicked');
  }
}
