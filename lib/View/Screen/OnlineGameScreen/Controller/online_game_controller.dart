import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../Model/online_game_model.dart';

class OnlineGameController extends GetxController {
  final Rx<OnlineGameMatchModel?> matchData = Rx<OnlineGameMatchModel?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isMicOn = false.obs;
  final bool isOnlineMatch = true;

  @override
  void onInit() {
    super.onInit();

    // Allow rotation (Portrait + Landscape) for Online Game screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Load initial match model data
    loadMatchData();
  }

  void toggleMic() {
    isMicOn.value = !isMicOn.value;
  }

  void loadMatchData() {
    isLoading.value = true;

    // Simulated Model JSON Response with unique player names & network image URLs
    final Map<String, dynamic> responseJson = {
      'match_id': 'MATCH_98521',
      'status': 'ready',
      'team1': [
        {
          'id': 'P1',
          'name': 'Asaduzzaman',
          'avatar_url': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
          'is_your_team': true,
          'score': 0,
        },
        {
          'id': 'P2',
          'name': 'Tariq Rahman',
          'avatar_url': 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150',
          'is_your_team': false,
          'score': 0,
        },
      ],
      'team2': [
        {
          'id': 'P3',
          'name': 'Imran Hossain',
          'avatar_url': 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=150',
          'is_your_team': true,
          'score': 0,
        },
        {
          'id': 'P4',
          'name': 'Zayed Ahmed',
          'avatar_url': '',
          'is_your_team': false,
          'score': 0,
        },
        {
          'id': 'P5',
          'name': 'Selecting...',
          'avatar_url': '',
          'is_your_team': false,
          'score': 0,
        },
      ],
    };

    // Parse model from JSON
    matchData.value = OnlineGameMatchModel.fromJson(responseJson);
    isLoading.value = false;
  }

  void onContinueTap() {
    // Navigate to ChooseCategoryScreen with online match flags & model data
    Get.toNamed(
      AppRoute.chooseCategoryScreen,
      arguments: {
        'isOnlineMatch': true,
        'matchId': matchData.value?.matchId ?? 'MATCH_98521',
        'player1': matchData.value?.team1.firstOrNull?.name ?? 'Player 1',
        'player2': matchData.value?.team2.firstOrNull?.name ?? 'Player 2',
      },
    );
  }
}
