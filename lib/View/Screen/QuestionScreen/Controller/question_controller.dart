import 'package:get/get.dart';
import '../../../../Model/team_model.dart';
import '../../../../Utils/AppImg/app_img.dart';
import '../../GameBoardScreen/Controller/game_board_controller.dart';

enum QuestionViewState {
  question,
  answerRevealed,
  resultDistribution,
}

class QuestionController extends GetxController {
  final RxString categoryTitle = 'Flags'.obs;
  final RxInt points = 200.obs;
  final RxString questionText = 'What is the name of this flag ?'.obs;
  final RxString answerText = 'Saudi Arabia'.obs;
  final RxString questionImage = AppImg.flagsImg.obs;

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

  final Rx<QuestionViewState> viewState = QuestionViewState.question.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      if (args['categoryTitle'] != null) categoryTitle.value = args['categoryTitle'];
      if (args['points'] != null) points.value = args['points'];
      if (args['questionText'] != null) questionText.value = args['questionText'];
      if (args['answerText'] != null) answerText.value = args['answerText'];
      if (args['questionImage'] != null) questionImage.value = args['questionImage'];

      if (args['player1'] != null && args['player1'] is TeamModel) {
        player1.value = args['player1'];
      }
      if (args['player2'] != null && args['player2'] is TeamModel) {
        player2.value = args['player2'];
      }
    }
  }

  void toggleShowAnswer() {
    if (viewState.value == QuestionViewState.question) {
      viewState.value = QuestionViewState.answerRevealed;
    } else {
      viewState.value = QuestionViewState.question;
    }
  }

  void goToResultDistribution() {
    viewState.value = QuestionViewState.resultDistribution;
  }

  void onReturnToAnswer() {
    viewState.value = QuestionViewState.answerRevealed;
  }

  void onAwardTeam1() {
    _awardPointsToPlayer(isPlayer1: true);
  }

  void onAwardTeam2() {
    _awardPointsToPlayer(isPlayer1: false);
  }

  void onAwardNoOne() {
    _awardPointsToPlayer(isNoOne: true);
  }

  void onTurnTap() {
    goToResultDistribution();
  }

  void _awardPointsToPlayer({bool isPlayer1 = false, bool isNoOne = false}) {
    if (Get.isRegistered<GameBoardController>()) {
      final gbController = Get.find<GameBoardController>();
      if (isNoOne) {
        // No points awarded, switch turn
        if (gbController.player1.value.isTurn) {
          gbController.player1.value = gbController.player1.value.copyWith(isTurn: false);
          gbController.player2.value = gbController.player2.value.copyWith(isTurn: true);
        } else {
          gbController.player2.value = gbController.player2.value.copyWith(isTurn: false);
          gbController.player1.value = gbController.player1.value.copyWith(isTurn: true);
        }
      } else if (isPlayer1) {
        gbController.player1.value = gbController.player1.value.copyWith(
          score: gbController.player1.value.score + points.value,
          isTurn: false,
        );
        gbController.player2.value = gbController.player2.value.copyWith(isTurn: true);
      } else {
        gbController.player2.value = gbController.player2.value.copyWith(
          score: gbController.player2.value.score + points.value,
          isTurn: false,
        );
        gbController.player1.value = gbController.player1.value.copyWith(isTurn: true);
      }
    }
    Get.back(); // Return to game board
  }

  void onExit() {
    Get.back();
  }

  void onRestart() {
    if (Get.isRegistered<GameBoardController>()) {
      Get.find<GameBoardController>().onRestart();
    }
    Get.back();
  }

  void onGameOver() {
    if (Get.isRegistered<GameBoardController>()) {
      Get.find<GameBoardController>().onGameOver();
    }
  }
}
