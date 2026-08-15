import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt selectedNavIndex = 0.obs;

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void onPlayTap() {
    // Navigate or trigger play game action
  }

  void onViewAllLeaderboardTap() {
    // Navigate to full Leaderboard view
    selectedNavIndex.value = 2; // Switch to Leaderboard tab
  }
}
