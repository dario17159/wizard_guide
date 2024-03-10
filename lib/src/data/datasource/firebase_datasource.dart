import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wizard_guide/src/core/constants/storage_collection.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/data/mappers/user_mapper.dart';
import 'package:wizard_guide/src/data/models/user_model.dart';
import 'package:wizard_guide/src/domain/datasource/datasource.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class FirebaseDatasource implements IDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<UserData> login(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return UserData(
      email: 'email',
      phone: 'phoneNumber',
      dateOfBirth: DateTime.now(),
      gender: Gender(
        type: GenderEnum.MALE,
        value: 'Masculino',
      ),
      password: 'password',
    );
  }

  @override
  Future<UserData> register(UserData userData) async {
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

    return userData.copyWith(id: credential.user!.uid);
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
