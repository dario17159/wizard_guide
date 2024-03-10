import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/icon_routes.dart';
import 'package:wizard_guide/src/presenter/pages/login/login_controller.dart';
import 'package:wizard_guide/src/presenter/pages/signup/signup.dart';

class LoginPage extends GetWidget<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SvgPicture.asset(IconRoutes.loginSVG),
            Obx(
              () => TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                    label: const Text('Email'),
                    hintText: 'example@example.com',
                    border: const OutlineInputBorder(),
                    errorText: controller.emailErrorText.value),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
              () => TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  label: const Text('Contraseña'),
                  hintText: '********',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () => controller.onChangePasswordObscure(),
                    icon: Obx(
                      () => controller.isPasswordObscure.value
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
                obscureText: controller.isPasswordObscure.value,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No tenes cuenta?'),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                  onPressed: () => Get.to(
                    () => const SignUpPage(),
                    binding: SignUpBinding(),
                  ),
                  child: const Text('Registrarme'),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.onClickLogin(),
                child: const Text('Iniciar sesión'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
