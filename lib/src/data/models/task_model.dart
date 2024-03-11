import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String? id;
  final String? title;
  final String? description;
  final String? urlImage;
  final String? status;
  final String? imageName;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.urlImage,
    this.status,
    this.imageName,
  });

  factory TaskModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return TaskModel(
      id: snapshot.id,
      title: data?['title'],
      description: data?['description'],
      urlImage: data?['urlImage'],
      status: data?['status'],
      imageName: data?['imageName'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (urlImage != null) "urlImage": urlImage,
      if (status != null) "status": status,
      if (imageName != null) "imageName": imageName,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? urlImage,
    String? status,
  }) =>
      TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        urlImage: urlImage ?? this.urlImage,
        status: status ?? this.status,
        imageName: imageName ?? imageName,
      );
}
