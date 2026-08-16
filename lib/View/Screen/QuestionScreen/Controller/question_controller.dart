import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/AppRoute/app_route.dart';
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
  final RxBool isOnlineMatch = false.obs;

  final TextEditingController userAnswerController = TextEditingController();
  final TextEditingController chatInputController = TextEditingController();

  final RxInt remainingSeconds = 30.obs;
  Timer? countdownTimer;
  Timer? _backendTimer;

  final RxBool isCheckingBackend = false.obs;
  final RxString checkingStatus = 'Verifying answer with server...'.obs;

  final RxList<Map<String, String>> chatMessages = <Map<String, String>>[
    {
      'sender': 'Asaduzzaman',
      'message': 'Hello !',
      'time': '1:20 am',
    },
  ].obs;

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
      isOnlineMatch.value = args['isOnlineMatch'] ?? false;
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

    // Start 30-second countdown timer
    startCountdownTimer();
  }

  void startCountdownTimer() {
    countdownTimer?.cancel();
    remainingSeconds.value = 30;
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        if (isOnlineMatch.value) {
          submitUserAnswer();
        } else {
          goToResultDistribution();
        }
      }
    });
  }

  void submitUserAnswer() {
    countdownTimer?.cancel();
    _backendTimer?.cancel();

    if (isOnlineMatch.value) {
      viewState.value = QuestionViewState.resultDistribution;
      isCheckingBackend.value = true;
      checkingStatus.value = 'Verifying answer with server...';

      final userAns = userAnswerController.text.trim().toLowerCase();
      final correctAns = answerText.value.trim().toLowerCase();

      // Simulate 5-second backend response evaluation
      _backendTimer = Timer(const Duration(seconds: 5), () {
        isCheckingBackend.value = false;

        // Check if answer contains keywords or exact match
        bool isCorrect = false;
        if (userAns.isNotEmpty) {
          final words = correctAns.split(' ');
          for (var word in words) {
            if (word.length > 2 && userAns.contains(word)) {
              isCorrect = true;
              break;
            }
          }
          if (userAns == correctAns) isCorrect = true;
        }

        if (isCorrect) {
          checkingStatus.value = 'Correct Answer! +${points.value} Points to ${player1.value.name}';
          _awardPointsToPlayer(isPlayer1: true, autoBackDelay: true);
        } else {
          checkingStatus.value = 'Incorrect Answer! +${points.value} Points to ${player2.value.name}';
          _awardPointsToPlayer(isPlayer1: false, autoBackDelay: true);
        }
      });
    } else {
      goToResultDistribution();
    }
  }

  void sendChatMessage(String msg) {
    if (msg.trim().isEmpty) return;
    chatMessages.add({
      'sender': player1.value.name,
      'message': msg.trim(),
      'time': '1:21 am',
    });
    chatInputController.clear();
  }

  void toggleShowAnswer() {
    if (viewState.value == QuestionViewState.question) {
      viewState.value = QuestionViewState.answerRevealed;
    } else {
      viewState.value = QuestionViewState.question;
    }
  }

  void goToResultDistribution() {
    countdownTimer?.cancel();
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

  void _awardPointsToPlayer({
    bool isPlayer1 = false,
    bool isNoOne = false,
    bool autoBackDelay = false,
  }) {
    countdownTimer?.cancel();
    if (Get.isRegistered<GameBoardController>()) {
      final gbController = Get.find<GameBoardController>();
      if (isNoOne) {
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
          isTurn: isOnlineMatch.value ? true : false,
        );
        gbController.player2.value = gbController.player2.value.copyWith(
          isTurn: isOnlineMatch.value ? true : true,
        );
        player1.value = gbController.player1.value;
      } else {
        gbController.player2.value = gbController.player2.value.copyWith(
          score: gbController.player2.value.score + points.value,
          isTurn: isOnlineMatch.value ? true : false,
        );
        gbController.player1.value = gbController.player1.value.copyWith(
          isTurn: isOnlineMatch.value ? true : true,
        );
        player2.value = gbController.player2.value;
      }
    }

    if (autoBackDelay) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (Get.currentRoute == AppRoute.questionScreen) {
          Get.back();
        }
      });
    } else {
      Get.back();
    }
  }

  void onExit() {
    countdownTimer?.cancel();
    _backendTimer?.cancel();
    Get.back();
  }

  void onRestart() {
    countdownTimer?.cancel();
    _backendTimer?.cancel();
    if (Get.isRegistered<GameBoardController>()) {
      Get.find<GameBoardController>().onRestart();
    }
    Get.back();
  }

  void onGameOver() {
    countdownTimer?.cancel();
    _backendTimer?.cancel();
    if (Get.isRegistered<GameBoardController>()) {
      Get.find<GameBoardController>().onGameOver();
    } else {
      Get.toNamed(
        AppRoute.winningScreen,
        arguments: {
          'isOnlineMatch': isOnlineMatch.value,
          'winnerName': player1.value.name,
          'winnerScore': player1.value.score,
          'winnerAvatar': player1.value.avatarInitials,
        },
      );
    }
  }

  @override
  void onClose() {
    countdownTimer?.cancel();
    _backendTimer?.cancel();
    userAnswerController.dispose();
    chatInputController.dispose();
    super.onClose();
  }
}
