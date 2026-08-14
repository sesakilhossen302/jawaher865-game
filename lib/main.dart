import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Core/AppRoute/app_route.dart';
import 'Core/Dependency/dependency.dart';
import 'Language/translator.dart';
import 'Utils/AppColors/app_colors.dart';
import 'Utils/AppConst/app_const.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConst.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),
      translations: Translator(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppRoute.splashScreen,
      getPages: AppRoute.routes,
    );
  }
}
