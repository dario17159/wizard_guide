import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/data/mappers/task_status.mapper.dart';
import 'package:wizard_guide/src/data/models/models.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class TaskMapper {
  static TaskData toEntity(TaskModel taskModel) => TaskData(
        id: taskModel.id ?? '',
        title: taskModel.title ?? '',
        description: taskModel.description ?? '',
        imageUrl: taskModel.urlImage ?? '',
        blurHash: taskModel.blurHash ?? '',
        status: TaskStatusMapper.toEntity(taskModel.status ?? ''),
      );

  static TaskModel toModel(TaskData taskData) => TaskModel(
        id: taskData.id,
        title: taskData.title,
        description: taskData.description,
        urlImage: taskData.imageUrl,
        blurHash: taskData.blurHash,
        status: toTaskString[taskData.status.type],
      );
}
