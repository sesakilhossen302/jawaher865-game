import 'package:get/get.dart';
import '../../View/Screen/SignInEmailScreen/Controller/sign_in_email_controller.dart';
import '../../View/Screen/SignInEmailScreen/sign_in_email_screen.dart';
import '../../View/Screen/SignUpScreen/Controller/sign_up_controller.dart';
import '../../View/Screen/SignUpScreen/sign_up_screen.dart';
import '../../View/Screen/SignScreen/Controller/sign_controller.dart';
import '../../View/Screen/SignScreen/sign_screen.dart';
import '../../View/Screen/SplashScreen/Controller/splash_controller.dart';
import '../../View/Screen/SplashScreen/splash_screen.dart';

class AppRoute {
  static const String splashScreen = '/splash_screen';
  static const String signScreen = '/sign_screen';
  static const String signInEmailScreen = '/sign_in_email_screen';
  static const String signUpScreen = '/sign_up_screen';

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put<SplashController>(SplashController());
      }),
    ),
    GetPage(
      name: signScreen,
      page: () => const SignScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignController>(() => SignController());
      }),
    ),
    GetPage(
      name: signInEmailScreen,
      page: () => const SignInEmailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignInEmailController>(() => SignInEmailController());
      }),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignUpController>(() => SignUpController());
      }),
    ),
  ];
}
