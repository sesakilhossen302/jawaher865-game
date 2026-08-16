import 'package:get/get.dart';
import '../../View/Screen/ChooseCategoryScreen/Controller/choose_category_controller.dart';
import '../../View/Screen/ChooseCategoryScreen/choose_category_screen.dart';
import '../../View/Screen/ForgotPasswordScreen/Controller/forgot_password_controller.dart';
import '../../View/Screen/ForgotPasswordScreen/forgot_password_screen.dart';
import '../../View/Screen/GameBoardScreen/Controller/game_board_controller.dart';
import '../../View/Screen/GameBoardScreen/game_board_screen.dart';
import '../../View/Screen/HomeScreen/Controller/home_controller.dart';
import '../../View/Screen/MainScreen/Controller/main_controller.dart';
import '../../View/Screen/MainScreen/main_screen.dart';
import '../../View/Screen/OtpScreen/Controller/otp_controller.dart';
import '../../View/Screen/OtpScreen/otp_screen.dart';
import '../../View/Screen/PlayScreen/Controller/play_controller.dart';
import '../../View/Screen/QuestionScreen/Controller/question_controller.dart';
import '../../View/Screen/QuestionScreen/question_screen.dart';
import '../../View/Screen/ResetPasswordScreen/Controller/reset_password_controller.dart';
import '../../View/Screen/ResetPasswordScreen/reset_password_screen.dart';
import '../../View/Screen/SignInEmailScreen/Controller/sign_in_email_controller.dart';
import '../../View/Screen/SignInEmailScreen/sign_in_email_screen.dart';
import '../../View/Screen/SignUpScreen/Controller/sign_up_controller.dart';
import '../../View/Screen/SignUpScreen/sign_up_screen.dart';
import '../../View/Screen/SignScreen/Controller/sign_controller.dart';
import '../../View/Screen/SignScreen/sign_screen.dart';
import '../../View/Screen/SplashScreen/Controller/splash_controller.dart';
import '../../View/Screen/SplashScreen/splash_screen.dart';
import '../../View/Screen/TeamSelectScreen/Controller/team_select_controller.dart';
import '../../View/Screen/TeamSelectScreen/team_select_screen.dart';
import '../../View/Screen/MatchmakingScreen/Controller/matchmaking_controller.dart';
import '../../View/Screen/MatchmakingScreen/matchmaking_screen.dart';
import '../../View/Screen/WinningScreen/Controller/winning_controller.dart';
import '../../View/Screen/WinningScreen/winning_screen.dart';

class AppRoute {
  static const String splashScreen = '/splash_screen';
  static const String signScreen = '/sign_screen';
  static const String signInEmailScreen = '/sign_in_email_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String otpScreen = '/otp_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String resetPasswordScreen = '/reset_password_screen';
  static const String homeScreen = '/home_screen';
  static const String mainScreen = '/main_screen';
  static const String teamSelectScreen = '/team_select_screen';
  static const String chooseCategoryScreen = '/choose_category_screen';
  static const String gameBoardScreen = '/game_board_screen';
  static const String questionScreen = '/question_screen';
  static const String winningScreen = '/winning_screen';
  static const String matchmakingScreen = '/matchmaking_screen';

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put<SplashController>(SplashController());
      }),
    ),
    GetPage(
      name: signScreen,
      page: () => const SignScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignController>(() => SignController());
      }),
    ),
    GetPage(
      name: signInEmailScreen,
      page: () => const SignInEmailScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignInEmailController>(() => SignInEmailController());
      }),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignUpController>(() => SignUpController());
      }),
    ),
    GetPage(
      name: otpScreen,
      page: () => const OtpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OtpController>(() => OtpController());
      }),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
      }),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
      }),
    ),
    GetPage(
      name: homeScreen,
      page: () => const MainScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainController>(() => MainController());
        Get.lazyPut<HomeController>(() => HomeController());
        Get.lazyPut<PlayController>(() => PlayController());
      }),
    ),
    GetPage(
      name: mainScreen,
      page: () => const MainScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainController>(() => MainController());
        Get.lazyPut<HomeController>(() => HomeController());
        Get.lazyPut<PlayController>(() => PlayController());
      }),
    ),
    GetPage(
      name: teamSelectScreen,
      page: () => const TeamSelectScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<TeamSelectController>(() => TeamSelectController());
      }),
    ),
    GetPage(
      name: chooseCategoryScreen,
      page: () => const ChooseCategoryScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ChooseCategoryController>(() => ChooseCategoryController());
      }),
    ),
    GetPage(
      name: gameBoardScreen,
      page: () => const GameBoardScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GameBoardController>(() => GameBoardController());
      }),
    ),
    GetPage(
      name: questionScreen,
      page: () => const QuestionScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<QuestionController>(() => QuestionController());
      }),
    ),
    GetPage(
      name: winningScreen,
      page: () => const WinningScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<WinningController>(() => WinningController());
      }),
    ),
    GetPage(
      name: matchmakingScreen,
      page: () => const MatchmakingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MatchmakingController>(() => MatchmakingController());
      }),
    ),
  ];
}
