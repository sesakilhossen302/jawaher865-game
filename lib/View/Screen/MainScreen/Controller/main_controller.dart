import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxString currentLang = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    // Enforce portrait mode for MainScreen navigation container
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
