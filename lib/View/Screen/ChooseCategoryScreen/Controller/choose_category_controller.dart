import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
import '../../../../Model/category_model.dart';
import '../../../../Utils/AppImg/app_img.dart';

class ChooseCategoryController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final RxString activeTeamName = 'Blue Team'.obs;
  final RxString blueTeamName = 'Blue Team'.obs;
  final RxString redTeamName = 'Red Team'.obs;

  final RxBool isLoading = false.obs;

  final RxList<CategoryModel> categories = <CategoryModel>[
    CategoryModel(
      id: 1,
      title: 'Islamic',
      imagePath: AppImg.islamicImg,
    ),
    CategoryModel(
      id: 2,
      title: 'Flags',
      imagePath: AppImg.flagsImg,
    ),
    CategoryModel(
      id: 3,
      title: 'AI',
      imagePath: AppImg.aiImg,
    ),
    CategoryModel(
      id: 4,
      title: 'AI',
      imagePath: AppImg.aiImg,
    ),
    CategoryModel(
      id: 5,
      title: 'Islamic',
      imagePath: AppImg.islamicImg,
    ),
    CategoryModel(
      id: 6,
      title: 'Flags',
      imagePath: AppImg.flagsImg,
    ),
    CategoryModel(
      id: 7,
      title: 'Islamic',
      imagePath: AppImg.islamicImg,
    ),
    CategoryModel(
      id: 8,
      title: 'Flags',
      imagePath: AppImg.flagsImg,
    ),
  ].obs;

  final RxList<int> selectedCategoryIds = <int>[].obs;

  final RxBool isOnlineMatch = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Lock ChooseCategoryScreen strictly to Portrait Mode ONLY
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      isOnlineMatch.value = args['isOnlineMatch'] ?? false;
      blueTeamName.value = args['blueTeam'] ?? args['player1'] ?? 'Blue Team';
      redTeamName.value = args['redTeam'] ?? args['player2'] ?? 'Red Team';
      activeTeamName.value = blueTeamName.value;
    }
  }

  // Ready for Backend API Call
  Future<void> fetchCategoriesFromApi() async {
    try {
      isLoading.value = true;
      // TODO: Replace with real API service call when backend endpoint is ready
      // final response = await ApiService.getCategories();
      // categories.value = response.map((data) => CategoryModel.fromJson(data)).toList();
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  List<CategoryModel> get filteredCategories {
    if (searchQuery.isEmpty) {
      return categories;
    }
    return categories
        .where((cat) =>
            cat.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  List<CategoryModel> get selectedCategoryModels {
    return categories
        .where((cat) => selectedCategoryIds.contains(cat.id))
        .toList();
  }

  void toggleCategory(int id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      if (selectedCategoryIds.length < 3) {
        selectedCategoryIds.add(id);
      } else {
        Get.snackbar(
          'Category Limit',
          'You can choose maximum 3 categories!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF065967),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  void removeCategory(int id) {
    selectedCategoryIds.remove(id);
  }

  void clearAll() {
    selectedCategoryIds.clear();
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void onActionTap() {
    if (selectedCategoryIds.length == 3) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
      ]);
      Get.toNamed(
        AppRoute.gameBoardScreen,
        arguments: {
          'isOnlineMatch': isOnlineMatch.value,
          'player1': blueTeamName.value,
          'player2': redTeamName.value,
          'selectedCategories': selectedCategoryModels,
        },
      );
    } else {
      Get.snackbar(
        'Select Categories',
        'Please select 3 categories to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF065967),
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
