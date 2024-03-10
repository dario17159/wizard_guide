import 'package:wizard_guide/src/domain/entities/entities.dart';

abstract class IApiRepository {
  Future<void> login(String email, String password);
  Future<void> register(UserData userData);
  Future<void> logout();
}
