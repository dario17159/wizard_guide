import 'package:blurhash_ffi/blurhash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wizard_guide/src/core/constants/storage_collection.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/data/mappers/mappers.dart';
import 'package:wizard_guide/src/data/models/task_model.dart';
import 'package:wizard_guide/src/data/models/user_model.dart';
import 'package:wizard_guide/src/domain/datasource/datasource.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class FirebaseDatasource implements IDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final Reference _firebaseStorage = FirebaseStorage.instance.ref();
  final Uuid _uuid = const Uuid();

  @override
  Future<UserModel> login(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final docSnapshot = await _firebaseFirestore
        .collection(StorageCollection.USERS)
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        )
        .doc(credential.user!.uid)
        .get();
    return docSnapshot.data()!.copyWith(uid: docSnapshot.id);
  }

  @override
  Future<UserModel> register(UserData userData) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: userData.email,
      password: userData.password,
    );

    final userModel = UserMapper.toModel(userData);

    await _firebaseFirestore
        .collection(StorageCollection.USERS)
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel user, options) => user.toFirestore(),
        )
        .doc(credential.user!.uid)
        .set(userModel);
    return userModel.copyWith(uid: credential.user!.uid);
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> addTask(TaskData task) async {
    String urlImage = '';
    String imageName = '';
    String blurHash = '';
    if (task.imageFile != null) {
      // Subir imagen al storage
      imageName = _uuid.v4();
      final imageRef = _firebaseStorage.child('task/$imageName.jpg');
      await imageRef.putFile(
        task.imageFile!,
        SettableMetadata(
          contentType: "image/jpeg",
        ),
      );
      urlImage = await imageRef.getDownloadURL();
      blurHash = await BlurhashFFI.encode(FileImage(task.imageFile!));
    }

    final taskData = task.copyWith(
      imageUrl: urlImage,
      imageName: imageName,
      blurHash: blurHash,
    );

    final taskModel = TaskMapper.toModel(taskData);
    final uid = _firebaseAuth.currentUser!.uid;
    await _firebaseFirestore
        .collection(StorageCollection.TASKS + uid)
        .withConverter(
          fromFirestore: TaskModel.fromFirestore,
          toFirestore: (TaskModel task, options) => task.toFirestore(),
        )
        .doc()
        .set(taskModel);
  }

  @override
  Future<void> deleteTask(String id) async {
    final uid = _firebaseAuth.currentUser!.uid;
    final docRef = _firebaseFirestore
        .collection(StorageCollection.TASKS + uid)
        .withConverter(
          fromFirestore: TaskModel.fromFirestore,
          toFirestore: (TaskModel task, options) => task.toFirestore(),
        )
        .doc(id);
    final taskModel = (await docRef.get()).data()!;
    if (taskModel.urlImage?.isNotEmpty ?? false) {
      final imageRef =
          _firebaseStorage.child('task/${taskModel.imageName}.jpg');
      await imageRef.delete();
    }
    await docRef.delete();
  }

  @override
  Stream<List<TaskModel>> getTask(TaskStatusENUM type) {
    List<TaskModel> taskList = [];
    final uid = _firebaseAuth.currentUser!.uid;
    Stream<QuerySnapshot> snapshots = _firebaseFirestore
        .collection(StorageCollection.TASKS + uid)
        .withConverter(
          fromFirestore: TaskModel.fromFirestore,
          toFirestore: (TaskModel task, _) => task.toFirestore(),
        )
        .where('status', isEqualTo: toTaskString[type])
        .snapshots();
    snapshots.listen((QuerySnapshot query) async {
      if (query.docChanges.isNotEmpty) {
        taskList.clear();
      }
    });
    return snapshots.map((snapshot) {
      for (var messageData in snapshot.docs) {
        taskList.add(messageData.data()! as TaskModel);
      }
      return taskList.toList();
    });
  }

  @override
  Future<void> updateTask(TaskData task) async {
    final taskModel = TaskMapper.toModel(task);
    final uid = _firebaseAuth.currentUser!.uid;
    await _firebaseFirestore
        .collection(StorageCollection.TASKS + uid)
        .withConverter(
          fromFirestore: TaskModel.fromFirestore,
          toFirestore: (TaskModel task, options) => task.toFirestore(),
        )
        .doc(task.id)
        .update(taskModel.toFirestore());
  }
}
