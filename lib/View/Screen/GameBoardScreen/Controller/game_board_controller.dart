import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Model/category_model.dart';
import '../../../../Model/game_board_model.dart';
import '../../../../Model/team_model.dart';
import '../../../../Utils/AppIcons/app_icons.dart';
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
    GameBoardBlockModel(id: 1, title: 'Islamic', imagePath: AppImg.islamicImg),
    GameBoardBlockModel(id: 2, title: 'Flags', imagePath: AppImg.flagsImg),
    GameBoardBlockModel(id: 3, title: 'AI', imagePath: AppImg.aiImg),
    GameBoardBlockModel(id: 4, title: 'Islamic', imagePath: AppImg.islamicImg),
    GameBoardBlockModel(id: 5, title: 'Flags', imagePath: AppImg.flagsImg),
    GameBoardBlockModel(id: 6, title: 'AI', imagePath: AppImg.aiImg),
  ].obs;

  final RxBool isOnlineMatch = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Allow rotation on Game Board Screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);

    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      isOnlineMatch.value = args['isOnlineMatch'] ?? false;
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

  void onPointTap(int categoryId, String side, int points) {
    final key = '$categoryId-$side-$points';
    if (usedPointButtons.contains(key)) return;

    usedPointButtons.add(key);

    final block = categoryBlocks.firstWhere(
      (b) => b.id == categoryId,
      orElse: () => GameBoardBlockModel(
        id: categoryId,
        title: 'Flags',
        imagePath: AppImg.flagsImg,
      ),
    );

    final questionData = _getQuestionForCategory(block.title, points);

    // Auto trigger game over if all buttons are played
    final totalButtons = categoryBlocks.length * 6;
    if (usedPointButtons.length >= totalButtons) {
      onGameOver();
      return;
    }

    Get.toNamed(
      AppRoute.questionScreen,
      arguments: {
        'isOnlineMatch': isOnlineMatch.value,
        'categoryTitle': block.title,
        'points': points,
        'questionText': questionData['question'],
        'answerText': questionData['answer'],
        'questionImage': questionData['image'] ?? block.imagePath,
        'player1': player1.value,
        'player2': player2.value,
      },
    );
  }

  Map<String, String> _getQuestionForCategory(String title, int points) {
    final cleanTitle = title.toLowerCase().trim();

    if (cleanTitle.contains('islam')) {
      if (points == 200) {
        return {
          'question': 'How many Surahs are in the Holy Quran shown here?',
          'answer': '114 Surahs',
          'image': AppIcons.quranBookSvg,
        };
      } else if (points == 400) {
        return {
          'question':
              'Which sacred book of Islam is placed on the Rehal stand?',
          'answer': 'Holy Quran',
          'image': AppIcons.quranBookSvg,
        };
      } else {
        return {
          'question':
              'In which Holy Islamic month was the Quran revealed to Prophet Muhammad (PBUH)?',
          'answer': 'Ramadan',
          'image': AppIcons.ramadanMoonSvg,
        };
      }
    } else if (cleanTitle.contains('flag')) {
      if (points == 200) {
        return {
          'question':
              'What is the country name of this green national flag with Arabic script & sword?',
          'answer': 'Saudi Arabia Flag',
          'image': AppIcons.saudiFlagSvg,
        };
      } else if (points == 400) {
        return {
          'question':
              'Which Muslim country\'s flag features black, white, and green stripes with a red triangle?',
          'answer': 'Palestine Flag',
          'image': AppIcons.palestineFlagSvg,
        };
      } else {
        return {
          'question':
              'Which Muslim country\'s flag features a white crescent moon and star on a red field?',
          'answer': 'Turkey Flag',
          'image': AppIcons.turkeyFlagSvg,
        };
      }
    } else if (cleanTitle.contains('ai')) {
      if (points == 200) {
        return {
          'question': 'What does AI stand for in modern computer technology?',
          'answer': 'Artificial Intelligence',
          'image': AppIcons.aiBrainEngineSvg,
        };
      } else if (points == 400) {
        return {
          'question':
              'What mechanical gear & neural brain graphic represents machine processing?',
          'answer': 'Neural Processing Engine',
          'image': AppIcons.aiBrainEngineSvg,
        };
      } else {
        return {
          'question':
              'Which neural network architecture powers modern Large Language Models?',
          'answer': 'Transformer Architecture',
          'image': AppIcons.aiBrainEngineSvg,
        };
      }
    }

    return {
      'question': 'What is the answer for $title ($points Points)?',
      'answer': 'Correct Answer for $title',
      'image': AppImg.flagsImg,
    };
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
      titleStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      middleTextStyle: const TextStyle(color: Colors.white),
      textConfirm: 'Exit',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFFB4ECE7),
      buttonColor: const Color(0xFFE54124),
      onConfirm: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        Get.back(); // close dialog
        Get.back(); // exit board
      },
    );
  }

  void onGameOver() {
    final isPlayer1Winner = player1.value.score >= player2.value.score;
    final winnerName = isPlayer1Winner
        ? player1.value.name
        : player2.value.name;
    final winnerScore = isPlayer1Winner
        ? player1.value.score
        : player2.value.score;
    final winnerAvatar = isPlayer1Winner
        ? player1.value.avatarInitials
        : player2.value.avatarInitials;

    Get.toNamed(
      AppRoute.winningScreen,
      arguments: {
        'isOnlineMatch': isOnlineMatch.value,
        'winnerName': winnerName,
        'winnerScore': winnerScore,
        'winnerAvatar': winnerAvatar,
      },
    );
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.onClose();
  }
}
