import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wizard_guide/src/data/mappers/gender_mapper.dart';
import 'package:wizard_guide/src/data/models/user_model.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class UserMapper {
  static UserData toEntity(UserModel userModel) => UserData(
      email: userModel.email ?? '',
      phone: userModel.phone ?? '',
      dateOfBirth: userModel.dateOfBirth?.toDate() ?? DateTime.now(),
      gender: GenderMapper.toEntity(userModel.gender ?? ''),
      id: userModel.uid ?? '');

  static UserModel toModel(UserData userData) => UserModel(
        email: userData.email,
        phone: userData.phone,
        gender: userData.gender.value,
        dateOfBirth: Timestamp.fromDate(userData.dateOfBirth),
      );
}
