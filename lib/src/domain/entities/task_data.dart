import 'dart:io';

import 'package:wizard_guide/src/domain/entities/task_status.dart';

class TaskData {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final TaskStatus status;
  final File? imageFile;
  final String imageName;

  TaskData({
    this.id = '',
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.status,
    this.imageFile,
    this.imageName = '',
  });

  TaskData copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    TaskStatus? status,
    String? imageName,
  }) =>
      TaskData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        status: status ?? this.status,
        imageName: imageName ?? this.imageName,
      );
}
