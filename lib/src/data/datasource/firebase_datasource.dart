import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wizard_guide/src/core/constants/storage_collection.dart';
import 'package:wizard_guide/src/data/mappers/user_mapper.dart';
import 'package:wizard_guide/src/data/models/user_model.dart';
import 'package:wizard_guide/src/domain/datasource/datasource.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class FirebaseDatasource implements IDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<UserModel> login(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final docSnapshot = await _firebaseFirestore
        .collection(StorageCollection.USERS)
        .withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel city, options) => city.toFirestore(),
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
          toFirestore: (UserModel city, options) => city.toFirestore(),
        )
        .doc(credential.user!.uid)
        .set(userModel);
    return userModel.copyWith(uid: credential.user!.uid);
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
