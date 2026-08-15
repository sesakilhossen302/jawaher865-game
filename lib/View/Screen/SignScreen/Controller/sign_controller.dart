import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class SignController extends GetxController {
  void signInWithGoogle() {
    Get.offAllNamed(AppRoute.homeScreen);
  }

  void signInWithApple() {
    Get.offAllNamed(AppRoute.homeScreen);
  }

  void signInWithEmail() {
    Get.toNamed(AppRoute.signInEmailScreen);
  }

  void continueAsGuest() {
    Get.offAllNamed(AppRoute.homeScreen);
  }
}
