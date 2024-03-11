import 'dart:io';

import 'package:wizard_guide/src/domain/entities/task_status.dart';

class TaskData {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String blurHash;
  final TaskStatus status;
  final File? imageFile;
  final String imageName;

  TaskData({
    this.id = '',
    required this.title,
    required this.description,
    required this.imageUrl,
    this.blurHash = '',
    required this.status,
    this.imageFile,
    this.imageName = '',
  });

  TaskData copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? blurHash,
    TaskStatus? status,
    String? imageName,
  }) =>
      TaskData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        blurHash: blurHash ?? this.blurHash,
        status: status ?? this.status,
        imageName: imageName ?? this.imageName,
      );
}
