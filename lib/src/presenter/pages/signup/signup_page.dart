import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';
import 'package:wizard_guide/src/presenter/pages/signup/signup_controller.dart';

class SignUpPage extends GetWidget<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido a Wizard Guide!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Para poder acceder, necesitamos que completes el siguiente formulario.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 24),
            Obx(
              () => TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('Email'),
                  errorText: controller.emailErrorText.value,
                  hintText: 'example@example.com',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Teléfono'),
                    hintText: '0000-0000',
                    errorText: controller.phoneErrorText.value),
                inputFormatters: [controller.maskFormatter],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.dateOfBirthController,
              onTap: () => controller.onClickDateOfBirth(context),
              canRequestFocus: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: const Text('Fecha de Nacimiento'),
                suffixIcon: IconButton(
                  onPressed: () => controller.onClickDateOfBirth(context),
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                  ),
                ),
              ),
              readOnly: true,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.ageController,
              canRequestFocus: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Edad'),
              ),
              readOnly: true,
              enableSuggestions: false,
              enableInteractiveSelection: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Gender>(
              value: controller.genderSelected.value,
              hint: const Text('Genero'),
              onChanged: (Gender? value) => controller.onChangeGender(value),
              items: controller.genders.map<DropdownMenuItem<Gender>>(
                (Gender item) {
                  return DropdownMenuItem<Gender>(
                    value: item,
                    child: Text(item.value),
                  );
                },
              ).toList(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  label: const Text('Contraseña'),
                  hintText: '********',
                  border: const OutlineInputBorder(),
                  errorText: controller.passwordErrorText.value,
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.onClickSignUp(),
                child: const Text('Confirmar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
