import 'package:wizard_guide/src/domain/entities/entities.dart';
abstract class IApiRepository{
  Future<UserData> login(String email, String password);
  Future<UserData> register(
      String email, String password, DateTime dateOfBirth, String gender);
}