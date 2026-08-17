import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Utils/StaticString/static_string.dart';

class ShareMeelasController extends GetxController {
  final RxString shareLink = StaticString.shareLinkExample.obs;

  void copyLinkToClipboard() {
    Clipboard.setData(ClipboardData(text: shareLink.value));
    Get.snackbar(
      'Copied!',
      StaticString.linkCopiedToClipboard,
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF3358FE),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
