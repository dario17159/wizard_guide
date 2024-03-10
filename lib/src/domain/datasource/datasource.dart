import 'package:wizard_guide/src/data/models/user_model.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

abstract class IDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserData userData);
  Future<void> logout();
}
