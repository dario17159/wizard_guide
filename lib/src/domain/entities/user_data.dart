import 'package:wizard_guide/src/domain/entities/gender.dart';

class UserData {
  final String id;
  final String email;
  final String phone;
  final DateTime dateOfBirth;
  final Gender gender;
  final String password;

  UserData({
    this.id = '',
    required this.email,
    required this.phone,
    required this.dateOfBirth,
    required this.gender,
    this.password = '',
  });

  UserData copyWith({
    String? id,
    String? email,
    String? phone,
    DateTime? dateOfBirth,
    Gender? gender,
    String? password,
  }) =>
      UserData(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        id: id ?? this.id,
        password: '',
      );
}
