import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  static void showSuccess(
      {String title = 'title', String message = 'Message'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  static void showError(
      {String title = 'title', String message = 'Message'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

  static void showInformative(
      {String title = 'title', String message = 'Message'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      colorText: Colors.white,
      backgroundColor: Colors.blue,
    );
  }
}
