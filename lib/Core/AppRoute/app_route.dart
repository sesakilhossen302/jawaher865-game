import 'package:get/get.dart';
import '../../View/Screen/SplashScreen/Controller/splash_controller.dart';
import '../../View/Screen/SplashScreen/splash_screen.dart';

class AppRoute {
  static const String splashScreen = '/splash_screen';

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
  ];
}
