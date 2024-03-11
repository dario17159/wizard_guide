import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/domain/entities/task_status.dart';

class TaskStatusMapper {
  static TaskStatus toEntity(String status) => TaskStatus(
        value: status,
        type: toTaskStatusENUM[status]!,
      );
}
