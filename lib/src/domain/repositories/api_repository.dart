import 'package:wizard_guide/src/domain/entities/entities.dart';

abstract class IApiRepository {
  Future<UserData> login(String email, String password);
  Future<UserData> register(UserData userData);
}
