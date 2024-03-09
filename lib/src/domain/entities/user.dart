import 'package:wizard_guide/src/core/enums/gender.dart';

class UserData {
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final GenderEnum gender;
  final String password;

  UserData({
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.password,
  });
}
