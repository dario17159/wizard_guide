import 'package:wizard_guide/src/domain/entities/entities.dart';

abstract class IDatasource {
  Future<UserData> login(String email, String password);
  Future<UserData> register(UserData userData);
}
