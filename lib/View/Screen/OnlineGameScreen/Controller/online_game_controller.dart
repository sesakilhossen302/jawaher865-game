import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Model/game_board_model.dart';
import '../../../../Utils/AppImg/app_img.dart';

class OnlineCategoryItem {
  final int id;
  final String title;
  final String imagePath;

  OnlineCategoryItem({
    required this.id,
    required this.title,
    required this.imagePath,
  });
}

class OnlineGameController extends GetxController {
  final RxList<OnlineCategoryItem> categories = <OnlineCategoryItem>[
    OnlineCategoryItem(id: 1, title: 'UAE', imagePath: AppImg.catUae),
    OnlineCategoryItem(id: 2, title: 'SONGS', imagePath: AppImg.catSongs),
    OnlineCategoryItem(id: 3, title: 'ABDULMAJED', imagePath: AppImg.catAbdulmajed),
    OnlineCategoryItem(id: 4, title: 'ARABIC', imagePath: AppImg.catArabic),
    OnlineCategoryItem(id: 5, title: 'FIFA', imagePath: AppImg.catFifa),
    OnlineCategoryItem(id: 6, title: 'HARRY POTTER', imagePath: AppImg.catHarryPotter),
    OnlineCategoryItem(id: 7, title: 'FRIENDS', imagePath: AppImg.catFriends),
    OnlineCategoryItem(id: 8, title: 'SHOWS', imagePath: AppImg.catShows),
  ].obs;

  // By default, first 6 categories are pre-selected matching Figma ("Choose 6 categories")
  final RxSet<int> selectedCategoryIds = <int>{1, 2, 3, 4, 5, 6}.obs;

  @override
  void onInit() {
    super.onInit();
    // Maintain portrait mode while choosing categories
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void toggleCategory(int id) {
    if (selectedCategoryIds.contains(id)) {
      if (selectedCategoryIds.length > 1) {
        selectedCategoryIds.remove(id);
      }
    } else {
      selectedCategoryIds.add(id);
    }
  }

  bool isSelected(int id) => selectedCategoryIds.contains(id);

  void onStartGame() {
    // 1. Convert selected categories into GameBoardBlockModel list
    final List<GameBoardBlockModel> selectedBlocks = categories
        .where((cat) => selectedCategoryIds.contains(cat.id))
        .map((cat) => GameBoardBlockModel(
              id: cat.id,
              title: cat.title,
              imagePath: cat.imagePath,
            ))
        .toList();

    // 2. Immediately lock and rotate orientation to landscape!
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // 3. Navigate to GameBoardScreen with online match arguments
    Get.toNamed(
      AppRoute.gameBoardScreen,
      arguments: {
        'isOnlineMatch': true,
        'player1': 'Green Team',
        'player2': 'Red Team',
        'selectedCategories': selectedBlocks,
      },
    );
  }
}
