import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordObscure = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void onChangePasswordObscure() =>
      isPasswordObscure.value = !isPasswordObscure.value;

  Future<void> onClickLogin() async {
    // Get.offAll(
    //   () => const HomePage(),
    //   binding: HomeBinding(),
    // );
  }
}
