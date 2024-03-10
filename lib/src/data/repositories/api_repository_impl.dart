import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/constants.dart';
import 'package:wizard_guide/src/core/services/services.dart';
import 'package:wizard_guide/src/data/datasource/firebase_datasource.dart';
import 'package:wizard_guide/src/data/mappers/mappers.dart';
import 'package:wizard_guide/src/domain/datasource/datasource.dart';
import 'package:wizard_guide/src/domain/entities/user_data.dart';
import 'package:wizard_guide/src/domain/repositories/api_repository.dart';

// ? Aqui se puede utilizar manejo de cache si es necesario

class ApiRepositoryImpl implements IApiRepository {
  final IDatasource _datasource = Get.find<FirebaseDatasource>();

  @override
  Future<void> login(String email, String password) async {
    final userModel = await _datasource.login(email, password);
    // Guardar en cache o servicio
    final userData = UserMapper.toEntity(userModel);
    await StorageService.saveObject(
        userData.toRawJson(), StorageKeys.USER_DATA);
  }

  @override
  Future<void> register(UserData userData) async {
    final userModel = await _datasource.register(userData);
    // Guardar en cache o servicio
    final user = UserMapper.toEntity(userModel);
    await StorageService.saveObject(user.toRawJson(), StorageKeys.USER_DATA);
  }

// Podriamos hacer que el storage se limpe, eso va del lado de lo que requiera el negocio
  @override
  Future<void> logout() => _datasource.logout();
}
