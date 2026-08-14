import 'package:get/get.dart';
import '../../View/Screen/SplashScreen/Controller/splash_controller.dart';
import '../../service/socket_service.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocketService(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);
  }
}
