import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/data/models/models.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

abstract class IDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserData userData);
  Future<void> logout();

  // Actions on task
  Stream<List<TaskModel>> getTask(TaskStatusENUM type);
  Future<void> addTask(TaskData task);
  Future<void> updateTask(TaskData task);
  Future<void> deleteTask(String id);
}
