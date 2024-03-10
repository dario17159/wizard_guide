import 'package:wizard_guide/src/domain/entities/gender.dart';

class UserData {
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final Gender gender;
  final String password;

  UserData({
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    required this.password,
  });
}
