import 'package:wizard_guide/src/core/enums/task_status.dart';

class Task {
  final String title;
  final String description;
  final String imageUrl;
  final TaskStatusENUM status;

  Task({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.status,
  });
}
