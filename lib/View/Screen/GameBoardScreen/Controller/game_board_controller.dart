import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
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
    GameBoardBlockModel(id: 1, title: 'Islamic', imagePath: AppImg.islamicImg),
    GameBoardBlockModel(id: 2, title: 'Flags', imagePath: AppImg.flagsImg),
    GameBoardBlockModel(id: 3, title: 'AI', imagePath: AppImg.aiImg),
    GameBoardBlockModel(id: 4, title: 'Islamic', imagePath: AppImg.islamicImg),
    GameBoardBlockModel(id: 5, title: 'Flags', imagePath: AppImg.flagsImg),
    GameBoardBlockModel(id: 6, title: 'AI', imagePath: AppImg.aiImg),
  ].obs;

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
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Quran_and_rehal.jpg/640px-Quran_and_rehal.jpg',
        };
      } else if (points == 400) {
        return {
          'question':
              'Which sacred book of Islam is placed on the Rehal stand?',
          'answer': 'Holy Quran',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Quran_Open.png/640px-Quran_Open.png',
        };
      } else {
        return {
          'question':
              'In which Holy Islamic month was the Quran revealed to Prophet Muhammad (PBUH)?',
          'answer': 'Ramadan',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Crescent_moon_Ramadan.jpg/640px-Crescent_moon_Ramadan.jpg',
        };
      }
    } else if (cleanTitle.contains('flag')) {
      if (points == 200) {
        return {
          'question':
              'What is the country name of this green national flag with Arabic script & sword?',
          'answer': 'Saudi Arabia Flag',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/640px-Flag_of_Saudi_Arabia.svg.png',
        };
      } else if (points == 400) {
        return {
          'question':
              'Which country\'s national flag features 50 white stars and 13 red and white stripes?',
          'answer': 'United States (USA) Flag',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/640px-Flag_of_the_United_States.svg.png',
        };
      } else {
        return {
          'question':
              'Which country\'s national flag features a green field with a red circle in the center?',
          'answer': 'Bangladesh Flag',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/640px-Flag_of_Bangladesh.svg.png',
        };
      }
    } else if (cleanTitle.contains('ai')) {
      if (points == 200) {
        return {
          'question': 'What does AI stand for in modern computer technology?',
          'answer': 'Artificial Intelligence',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/HONOR_AI_Icon.png/640px-HONOR_AI_Icon.png',
        };
      } else if (points == 400) {
        return {
          'question':
              'What mechanical gear & neural brain graphic represents machine processing?',
          'answer': 'Neural Processing Engine',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Artificial_intelligence_prompt.png/640px-Artificial_intelligence_prompt.png',
        };
      } else {
        return {
          'question':
              'Which neural network architecture powers modern Large Language Models?',
          'answer': 'Transformer Architecture',
          'image':
              'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Artificial_human_neural_network.svg/640px-Artificial_human_neural_network.svg.png',
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
