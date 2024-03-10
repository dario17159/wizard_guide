import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wizard_guide/src/core/constants/regular_expresions.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/core/extensions/date_time_exrension.dart';
import 'package:wizard_guide/src/core/extensions/string_extension.dart';
import 'package:wizard_guide/src/core/services/services.dart';
import 'package:wizard_guide/src/data/repositories/api_repository_impl.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';
import 'package:wizard_guide/src/domain/repositories/api_repository.dart';

class SignUpController extends GetxController {
  final IApiRepository _apiRepository = Get.find<ApiRepositoryImpl>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final List<Gender> genders = [
    Gender(value: 'Masculino', type: GenderEnum.MALE),
    Gender(value: 'Femenino', type: GenderEnum.FEMALE),
  ];

  Rx<Gender?> genderSelected = Rx<Gender?>(null);
  Rx<String?> emailErrorText = Rx<String?>(null);
  Rx<String?> phoneErrorText = Rx<String?>(null);
  Rx<String?> passwordErrorText = Rx<String?>(null);
  RxBool isPasswordObscure = true.obs;

  bool _emailValid = false;
  bool _phoneValid = false;
  bool _ageValid = false;
  bool _passwordValid = false;
  DateTime? dateOfBirth;

  @override
  void onInit() {
    emailController.addListener(_validateEmail);
    phoneController.addListener(_validatePhone);
    passwordController.addListener(_validatePassword);
    super.onInit();
  }

  @override
  void onClose() {
    emailController.removeListener(_validateEmail);
    phoneController.removeListener(_validatePhone);
    passwordController.removeListener(_validatePassword);

    emailController.dispose();
    phoneController.dispose();
    ageController.dispose();
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

  void _validatePhone() {
    phoneErrorText.value = phoneController.text.isEmpty ||
            maskFormatter.getUnmaskedText().length == 8
        ? null
        : 'Ingresa un teléfono válido';
    _phoneValid = (phoneErrorText.value == null);
  }

  void _validatePassword() {
    final password = passwordController.text.trim();
    if (password.length >= 8 && password.length <= 12) {
      if (!RegularExpressions.mayusLetterValidation.hasMatch(password)) {
        passwordErrorText.value =
            'La contraseña debe contener al menos una mayuscula';
      } else if (!RegularExpressions.minusLetterValidation.hasMatch(password)) {
        passwordErrorText.value =
            'La contraseña debe contener al menos una minuscula';
      } else if (!RegularExpressions.numbersValidation.hasMatch(password)) {
        passwordErrorText.value =
            'La contraseña debe contener al menos un número';
      } else if (RegularExpressions.specialCaracterValidation
          .hasMatch(password)) {
        passwordErrorText.value =
            'La contraseña no debe contener caracteres especiales';
      } else {
        passwordErrorText.value = null;
      }
    } else {
      passwordErrorText.value = password.isEmpty
          ? null
          : 'La contraseña debe tener entre 8 y 12 caracteres';
    }
    _passwordValid = (passwordErrorText.value == null);
  }

  Future<void> onClickSignUp() async {
    if (_ageValid &&
        _emailValid &&
        _passwordValid &&
        _phoneValid &&
        genderSelected.value != null) {
      DialogService.showLoading(message: 'Aguarde un momento...');
      final userData = UserData(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        dateOfBirth: dateOfBirth!,
        gender: genderSelected.value!,
        phone: phoneController.text.trim(),
      );
      final data = _apiRepository.register(userData);
      DialogService.hideLoading();
    } else {
      SnackbarService.showInformative(
        title: 'Atención',
        message: 'Verifique que los campos esten completos correctamente',
      );
    }
  }

  Future<void> onClickDateOfBirth(BuildContext context) async {
    dateOfBirth = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (dateOfBirth != null) {
      if (dateOfBirth!.parseToAge >= 10) {
        ageController.text = dateOfBirth!.parseToAge.toString();
        _ageValid = true;
      } else {
        SnackbarService.showInformative(
          title: 'Atención',
          message: 'No puede tener menos de 10 años de edad',
        );
        _ageValid = false;
      }
    }
  }

  void onChangeGender(Gender? gender) => genderSelected.value = gender;

  void onChangePasswordObscure() =>
      isPasswordObscure.value = !isPasswordObscure.value;
}
