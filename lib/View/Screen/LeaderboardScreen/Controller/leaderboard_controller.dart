import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Model/leaderboard_model.dart';

class LeaderboardController extends GetxController {
  final RxInt selectedTabIndex = 0.obs; // 0: Weekly, 1: Monthly, 2: All Time

  final RxList<LeaderboardUserModel> weeklyList = <LeaderboardUserModel>[].obs;
  final RxList<LeaderboardUserModel> monthlyList = <LeaderboardUserModel>[].obs;
  final RxList<LeaderboardUserModel> allTimeList = <LeaderboardUserModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Lock Leaderboard Screen to Portrait mode ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _loadLeaderboardData();
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void _loadLeaderboardData() {
    weeklyList.value = [
      LeaderboardUserModel(
        rank: 1,
        name: 'demo_user',
        username: '@demo_user',
        avatarUrl: '',
        points: 0,
      ),
    ];

    monthlyList.value = [
      LeaderboardUserModel(
        rank: 1,
        name: 'demo_user',
        username: '@demo_user',
        avatarUrl: '',
        points: 1200,
      ),
      LeaderboardUserModel(
        rank: 2,
        name: 'Asaduzzaman',
        username: '@asad',
        avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
        points: 950,
      ),
      LeaderboardUserModel(
        rank: 3,
        name: 'Imran Hossain',
        username: '@imran',
        avatarUrl: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=150',
        points: 800,
      ),
    ];

    allTimeList.value = [
      LeaderboardUserModel(
        rank: 1,
        name: 'demo_user',
        username: '@demo_user',
        avatarUrl: '',
        points: 5400,
      ),
      LeaderboardUserModel(
        rank: 2,
        name: 'Asaduzzaman',
        username: '@asad',
        avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
        points: 4200,
      ),
      LeaderboardUserModel(
        rank: 3,
        name: 'Tariq Rahman',
        username: '@tariq',
        avatarUrl: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150',
        points: 3900,
      ),
      LeaderboardUserModel(
        rank: 4,
        name: 'Imran Hossain',
        username: '@imran',
        avatarUrl: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=150',
        points: 3100,
      ),
    ];
  }
}
