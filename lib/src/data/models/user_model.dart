import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? email;
  final String? uid;
  final String? phone;
  final String? status;
  final String? gender;
  final Timestamp? dateOfBirth;

  UserModel({
    this.email,
    this.uid,
    this.phone,
    this.status,
    this.gender,
    this.dateOfBirth,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      email: data?['email'],
      status: data?['status'],
      phone: data?['phone'],
      gender: data?['gender'],
      uid: snapshot.id,
      dateOfBirth: data?['dateOfBirth'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) "email": email,
      if (status != null) "status": status,
      if (gender != null) "gender": gender,
      if (phone != null) "phone": phone,
      if (dateOfBirth != null) "dateOfBirth": dateOfBirth,
    };
  }

  UserModel copyWith({
    String? email,
    String? uid,
    String? phone,
    String? status,
    String? gender,
    Timestamp? dateOfBirth,
  }) =>
      UserModel(
        email: email ?? this.email,
        uid: uid ?? this.uid,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      );
}
