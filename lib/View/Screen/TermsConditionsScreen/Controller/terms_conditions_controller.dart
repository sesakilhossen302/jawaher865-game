import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TermsConditionsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Lock Terms & Conditions Screen to Portrait mode ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
