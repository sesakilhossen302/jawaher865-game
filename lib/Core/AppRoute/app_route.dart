import 'package:get/get.dart';
import '../../View/Screen/SignScreen/Controller/sign_controller.dart';
import '../../View/Screen/SignScreen/sign_screen.dart';
import '../../View/Screen/SplashScreen/Controller/splash_controller.dart';
import '../../View/Screen/SplashScreen/splash_screen.dart';

class AppRoute {
  static const String splashScreen = '/splash_screen';
  static const String signScreen = '/sign_screen';

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
  ];
}
