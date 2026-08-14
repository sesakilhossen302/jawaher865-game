import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../AppColors/app_colors.dart';

class ToastMessage {
  static void showToast(
    String message, {
    Color backgroundColor = AppColors.primaryColor,
    Color textColor = AppColors.whiteColor,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 14.0,
    );
  }

  static void showErrorToast(String message) {
    showToast(
      message,
      backgroundColor: AppColors.errorColor,
      textColor: AppColors.whiteColor,
    );
  }

  static void showSuccessToast(String message) {
    showToast(
      message,
      backgroundColor: AppColors.successColor,
      textColor: AppColors.whiteColor,
    );
  }
}
