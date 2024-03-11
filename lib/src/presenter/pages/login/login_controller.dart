import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/extensions/extensions.dart';
import 'package:wizard_guide/src/core/services/services.dart';
import 'package:wizard_guide/src/data/repositories/api_repository_impl.dart';
import 'package:wizard_guide/src/domain/repositories/api_repository.dart';
import 'package:wizard_guide/src/presenter/pages/home/home.dart';

class LoginController extends GetxController {
  final IApiRepository _apiRepository = Get.find<ApiRepositoryImpl>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordObscure = true.obs;
  Rx<String?> emailErrorText = Rx<String?>(null);

  bool _emailValid = false;

  @override
  void onInit() {
    emailController.addListener(_validateEmail);
    super.onInit();
  }


  @override
  void onClose() {
    emailController.removeListener(_validateEmail);

    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _validateEmail() {
    emailErrorText.value =
        emailController.text.trim().isEmpty || emailController.text.isValidEmail
            ? null
            : 'Ingresa un email válido';
    _emailValid = (emailErrorText.value == null);
  }

  void onChangePasswordObscure() =>
      isPasswordObscure.value = !isPasswordObscure.value;

  Future<void> onClickLogin() async {
    try {
      if (_emailValid && passwordController.text.isNotEmpty) {
        DialogService.showLoading(message: 'Iniciando sesión...');
        await _apiRepository.login(
            emailController.text.trim(), passwordController.text.trim());
        DialogService.hideLoading();
        Get.offAll(
          () => const HomePage(),
          binding: HomeBinding(),
        );
      }
    } catch (e) {
      DialogService.hideLoading();
      SnackbarService.showError(
          title: 'Atención', message: 'Usuario o contraseña incorrecta');
    }
  }
}
