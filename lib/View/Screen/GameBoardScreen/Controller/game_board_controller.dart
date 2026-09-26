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

  final RxBool isOnlineMatch = false.obs;
  final RxMap<String, Map<String, dynamic>> dynamicQuestions =
      <String, Map<String, dynamic>>{}.obs;

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
          args['selectedCategories'] is List) {
        final List incoming = args['selectedCategories'];
        if (incoming.isNotEmpty) {
          final List<GameBoardBlockModel> blocks = [];
          int blockIdCounter = 1;
          for (var item in incoming) {
            if (item is CategoryModel) {
              blocks.add(
                GameBoardBlockModel(
                  id: blockIdCounter++,
                  title: item.title,
                  imagePath: item.imagePath ?? item.iconUrl ?? AppImg.catUae,
                  iconUrl: item.iconUrl,
                ),
              );
            } else if (item is GameBoardBlockModel) {
              blocks.add(item);
            } else if (item is Map<String, dynamic>) {
              blocks.add(GameBoardBlockModel.fromJson(item));
            }
          }
          if (blocks.isNotEmpty) {
            categoryBlocks.value = blocks;
          }
        }
      }
      if (args['questions'] != null && args['questions'] is Map) {
        final Map incomingQ = args['questions'];
        incomingQ.forEach((k, v) {
          if (v is Map) {
            dynamicQuestions[k.toString()] = Map<String, dynamic>.from(v);
          }
        });
      }
    }
  }

  void setQuestionsFromApi(Map<String, dynamic> questionsMap) {
    questionsMap.forEach((k, v) {
      if (v is Map) {
        dynamicQuestions[k] = Map<String, dynamic>.from(v);
      }
    });
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
        imagePath: AppImg.qBrazilFlag,
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

    // 1. Check if dynamic question exists from API
    final keyWithPoints = '$cleanTitle-$points';
    if (dynamicQuestions.containsKey(keyWithPoints)) {
      final q = dynamicQuestions[keyWithPoints]!;
      return {
        'question': q['question']?.toString() ?? 'Question for $title',
        'answer': q['answer']?.toString() ?? 'Answer for $title',
        'image': q['image']?.toString() ?? '',
      };
    }

    if (cleanTitle.contains('uae')) {
      if (points == 200) {
        return {
          'question': 'Which emirate is Burj Khalifa located in?',
          'answer': 'Dubai',
          'image': AppImg.catUae,
        };
      } else if (points == 400) {
        return {
          'question': 'What is the capital city of the United Arab Emirates?',
          'answer': 'Abu Dhabi',
          'image': AppImg.catUae,
        };
      } else {
        return {
          'question': 'In what year was the UAE federation founded?',
          'answer': '1971',
          'image': AppImg.catUae,
        };
      }
    } else if (cleanTitle.contains('song')) {
      if (points == 200) {
        return {
          'question': 'Who is widely celebrated as the King of Pop?',
          'answer': 'Michael Jackson',
          'image': AppImg.catSongs,
        };
      } else if (points == 400) {
        return {
          'question': 'Which legendary album features Thriller & Billie Jean?',
          'answer': 'Thriller',
          'image': AppImg.catSongs,
        };
      } else {
        return {
          'question': 'What signature dance move did Michael Jackson debut in 1983?',
          'answer': 'Moonwalk',
          'image': AppImg.catSongs,
        };
      }
    } else if (cleanTitle.contains('abdulmajed')) {
      if (points == 200) {
        return {
          'question': 'What traditional musical instrument does Abdul Majeed play?',
          'answer': 'Oud',
          'image': AppImg.catAbdulmajed,
        };
      } else if (points == 400) {
        return {
          'question': 'Which Arabian Gulf country is singer Abdul Majeed from?',
          'answer': 'Saudi Arabia',
          'image': AppImg.catAbdulmajed,
        };
      } else {
        return {
          'question': 'Which famous romantic Arabic song is sung by Abdul Majeed Abdullah?',
          'answer': 'Ghanili',
          'image': AppImg.catAbdulmajed,
        };
      }
    } else if (cleanTitle.contains('arabic')) {
      if (points == 200) {
        return {
          'question': 'What stringed instrument is known as the king of Arabic instruments?',
          'answer': 'Oud',
          'image': AppImg.catArabic,
        };
      } else if (points == 400) {
        return {
          'question': 'What Arabic percussion instrument is shaped like a goblet drum?',
          'answer': 'Darbuka',
          'image': AppImg.catArabic,
        };
      } else {
        return {
          'question': 'Which melodic framework system is fundamental to Arabic traditional music?',
          'answer': 'Maqam',
          'image': AppImg.catArabic,
        };
      }
    } else if (cleanTitle.contains('fifa')) {
      if (points == 200) {
        return {
          'question': 'WHAT COUNTRY DOES THIS FLAG BELONG TO?',
          'answer': 'Brazil',
          'image': AppImg.qBrazilFlag,
        };
      } else if (points == 400) {
        return {
          'question': 'In which year did Lionel Messi lead Argentina to World Cup glory in Qatar?',
          'answer': '2022',
          'image': AppImg.catFifa,
        };
      } else {
        return {
          'question': 'How many players are on the pitch for one team in a standard football match?',
          'answer': '11 Players',
          'image': AppImg.catFifa,
        };
      }
    } else if (cleanTitle.contains('potter')) {
      if (points == 200) {
        return {
          'question': 'Which Hogwarts house was Harry Potter sorted into?',
          'answer': 'Gryffindor',
          'image': AppImg.catHarryPotter,
        };
      } else if (points == 400) {
        return {
          'question': 'What broomstick sport is played high in the air at Hogwarts?',
          'answer': 'Quidditch',
          'image': AppImg.catHarryPotter,
        };
      } else {
        return {
          'question': 'What is the name of Harry Potter\'s pet snowy owl?',
          'answer': 'Hedwig',
          'image': AppImg.catHarryPotter,
        };
      }
    } else if (cleanTitle.contains('friend')) {
      if (points == 200) {
        return {
          'question': 'HOW MANY SISTERS DID JOEY TRIBBANI HAVE?',
          'answer': '7 Sisters',
          'image': AppImg.qJoey,
        };
      } else if (points == 400) {
        return {
          'question': 'What is the name of the coffee shop where the Friends hung out?',
          'answer': 'Central Perk',
          'image': AppImg.catFriends,
        };
      } else {
        return {
          'question': 'What catchphrase does Joey famously use when greeting women?',
          'answer': 'How you doin\'?',
          'image': AppImg.qJoey,
        };
      }
    } else if (cleanTitle.contains('show')) {
      if (points == 200) {
        return {
          'question': 'Which British period crime drama features Thomas Shelby?',
          'answer': 'Peaky Blinders',
          'image': AppImg.catShows,
        };
      } else if (points == 400) {
        return {
          'question': 'Which epic fantasy series features the Iron Throne and Westeros?',
          'answer': 'Game of Thrones',
          'image': AppImg.catShows,
        };
      } else {
        return {
          'question': 'In which critically acclaimed series does Walter White become Heisenberg?',
          'answer': 'Breaking Bad',
          'image': AppImg.catShows,
        };
      }
    } else if (cleanTitle.contains('flag')) {
      return {
        'question': 'WHAT COUNTRY DOES THIS FLAG BELONG TO?',
        'answer': 'Brazil',
        'image': AppImg.qBrazilFlag,
      };
    }

    return {
      'question': 'What is the correct answer for $title ($points Points)?',
      'answer': 'Answer for $title',
      'image': AppImg.catUae,
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
        Get.offAllNamed(AppRoute.mainScreen);
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
