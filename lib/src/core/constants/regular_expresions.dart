class RegularExpressions {
  static final RegExp mayusLetterValidation = RegExp(r'^(?=.*[A-Z])+');
  static final RegExp specialCaracterValidation = RegExp(r'^(?=.*[!@#$&*])+');
  static final RegExp numbersValidation = RegExp(r'^(?=.*[0-9])+');
  static final RegExp minusLetterValidation = RegExp(r'^(?=.*[a-z])+');
}
