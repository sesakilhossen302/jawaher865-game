import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';

class RoomNameController extends GetxController {
  final RxList<Map<String, String>> roomMatchesList = <Map<String, String>>[
    {'name': 'kadir Ali', 'avatar': ''},
    {'name': 'kadir Ali', 'avatar': ''},
  ].obs;

  void onShareMeelas() {
    Get.toNamed(AppRoute.shareMeelasScreen);
  }

  void onCardOptionsTap(int index) {
    Get.snackbar(
      'Options',
      'Options for ${roomMatchesList[index]['name']}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF065967),
      colorText: Colors.white,
    );
  }
}
