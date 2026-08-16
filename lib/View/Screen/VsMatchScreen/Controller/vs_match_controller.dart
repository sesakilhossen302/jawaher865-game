import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../OnlineGameScreen/Model/online_game_model.dart';

class VsMatchController extends GetxController {
  final Rx<OnlineGameMatchModel?> matchData = Rx<OnlineGameMatchModel?>(null);
  final RxBool isLoading = true.obs;

  Timer? _autoVsTimer;

  @override
  void onInit() {
    super.onInit();

    // Allow rotation (Portrait + Landscape) for VS Match screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Load initial 2 vs 2 match data
    loadVsMatchData();

    // Auto-navigate to OnlineGameScreen after 3 seconds
    _start3SecondAutoTimer();
  }

  void _start3SecondAutoTimer() {
    _autoVsTimer?.cancel();
    _autoVsTimer = Timer(const Duration(seconds: 3), () {
      navigateToNextScreen();
    });
  }

  void loadVsMatchData() {
    isLoading.value = true;

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
      ],
    };

    matchData.value = OnlineGameMatchModel.fromJson(responseJson);
    isLoading.value = false;
  }

  void navigateToNextScreen() {
    _autoVsTimer?.cancel();
    Get.offNamed(AppRoute.onlineGameScreen);
  }

  @override
  void onClose() {
    _autoVsTimer?.cancel();
    super.onClose();
  }
}
