import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

abstract class IApiRepository {
  Future<void> login(String email, String password);
  Future<void> register(UserData userData);
  Future<void> logout();

  Stream<List<TaskData>> getTask(TaskStatusENUM type);
  Future<void> addTask(TaskData task);
  Future<void> updateTask(TaskData task);
  Future<void> deleteTask(String id);
}
