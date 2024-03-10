import 'package:get/get.dart';
import 'package:wizard_guide/src/data/datasource/firebase_datasource.dart';
import 'package:wizard_guide/src/domain/datasource/datasource.dart';
import 'package:wizard_guide/src/domain/entities/user.dart';
import 'package:wizard_guide/src/domain/repositories/api_repository.dart';

// ? Aqui se puede utilizar manejo de cache si es necesario

class ApiRepositoryImpl implements IApiRepository {
  final IDatasource _datasource = Get.find<FirebaseDatasource>();

  @override
  Future<UserData> login(String email, String password) =>
      _datasource.login(email, password);

  @override
  Future<UserData> register(
          String email, String password, DateTime dateOfBirth, String gender) =>
      _datasource.register(email, password, dateOfBirth, gender);
}
