import 'package:get/get.dart';

class PlayController extends GetxController {
  final RxInt selectedNavIndex = 1.obs;

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void onStartNowTap() {
    // Action for Challenge Your Melas
  }

  void onPlayOnlineTap() {
    // Action for Challenge Other Melases
  }
}
