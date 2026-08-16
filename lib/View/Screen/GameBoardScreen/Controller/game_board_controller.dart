import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Model/category_model.dart';
import '../../../../Model/game_board_model.dart';
import '../../../../Model/team_model.dart';
import '../../../../Utils/AppImg/app_img.dart';

class GameBoardController extends GetxController {
  final Rx<TeamModel> player1 = TeamModel(
    id: '1',
    name: 'Asaduujan',
    teamType: 'blue',
    score: 1000,
    avatarInitials: 'ش',
    isTurn: true,
  ).obs;

  final Rx<TeamModel> player2 = TeamModel(
    id: '2',
    name: 'Sulaiman',
    teamType: 'red',
    score: 1000,
    avatarInitials: 'م',
    isTurn: false,
  ).obs;

  final RxBool isLoading = false.obs;
  final RxSet<String> usedPointButtons = <String>{}.obs;

  final RxList<GameBoardBlockModel> categoryBlocks = <GameBoardBlockModel>[
    GameBoardBlockModel(
      id: 1,
      title: 'Islamic',
      imagePath: AppImg.islamicImg,
    ),
    GameBoardBlockModel(
      id: 2,
      title: 'Flags',
      imagePath: AppImg.flagsImg,
    ),
    GameBoardBlockModel(
      id: 3,
      title: 'AI',
      imagePath: AppImg.aiImg,
    ),
    GameBoardBlockModel(
      id: 4,
      title: 'Islamic',
      imagePath: AppImg.islamicImg,
    ),
    GameBoardBlockModel(
      id: 5,
      title: 'Flags',
      imagePath: AppImg.flagsImg,
    ),
    GameBoardBlockModel(
      id: 6,
      title: 'AI',
      imagePath: AppImg.aiImg,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      if (args['player1'] != null) {
        player1.value = player1.value.copyWith(name: args['player1']);
      }
      if (args['player2'] != null) {
        player2.value = player2.value.copyWith(name: args['player2']);
      }
      if (args['selectedCategories'] != null &&
          args['selectedCategories'] is List<CategoryModel>) {
        final List<CategoryModel> selected = args['selectedCategories'];
        if (selected.isNotEmpty) {
          final List<GameBoardBlockModel> blocks = [];
          int blockIdCounter = 1;
          for (int round = 0; round < 2; round++) {
            for (var cat in selected) {
              blocks.add(
                GameBoardBlockModel(
                  id: blockIdCounter++,
                  title: cat.title,
                  imagePath: cat.imagePath ?? AppImg.islamicImg,
                  iconUrl: cat.iconUrl,
                ),
              );
            }
          }
          categoryBlocks.value = blocks;
        }
      }
    }
  }

  // Backend API Integration Stub
  Future<void> fetchGameBoardFromApi() async {
    try {
      isLoading.value = true;
      // TODO: Connect real API service when backend endpoint is live
      // final response = await ApiService.getGameBoardData();
      // categoryBlocks.value = response.map((data) => GameBoardBlockModel.fromJson(data)).toList();
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  void onPointTap(int categoryId, String side, int points) {
    final key = '$categoryId-$side-$points';
    if (usedPointButtons.contains(key)) return;

    usedPointButtons.add(key);

    if (player1.value.isTurn) {
      player1.value = player1.value.copyWith(
        score: player1.value.score + points,
        isTurn: false,
      );
      player2.value = player2.value.copyWith(isTurn: true);
    } else {
      player2.value = player2.value.copyWith(
        score: player2.value.score + points,
        isTurn: false,
      );
      player1.value = player1.value.copyWith(isTurn: true);
    }

    Get.snackbar(
      '+$points Points!',
      'Points scored! Next turn.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF065967),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void onRestart() {
    usedPointButtons.clear();
    player1.value = player1.value.copyWith(score: 1000, isTurn: true);
    player2.value = player2.value.copyWith(score: 1000, isTurn: false);

    Get.snackbar(
      'Game Restarted',
      'Scores and board have been reset.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF065967),
      colorText: Colors.white,
    );
  }

  void onExit() {
    Get.defaultDialog(
      title: 'Exit Game?',
      middleText: 'Are you sure you want to exit the game board?',
      backgroundColor: const Color(0xFF065967),
      titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      middleTextStyle: const TextStyle(color: Colors.white),
      textConfirm: 'Exit',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFFB4ECE7),
      buttonColor: const Color(0xFFE54124),
      onConfirm: () {
        Get.back(); // close dialog
        Get.back(); // exit board
      },
    );
  }

  void onGameOver() {
    final winner = player1.value.score >= player2.value.score
        ? player1.value.name
        : player2.value.name;

    Get.snackbar(
      'Game Over',
      'The game has ended! Winner: $winner',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF3358FE),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
