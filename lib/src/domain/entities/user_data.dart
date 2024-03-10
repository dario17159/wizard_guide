import 'dart:convert';

import 'package:wizard_guide/src/domain/entities/entities.dart';
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

  factory UserData.fromRawJson(String str) =>
      UserData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        gender: Gender.fromRawJson(json["gender"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "dateOfBirth": dateOfBirth.toIso8601String(),
        "gender": gender.toRawJson(),
      };
}
