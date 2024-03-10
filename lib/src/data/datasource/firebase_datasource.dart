import 'package:firebase_auth/firebase_auth.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/domain/datasource/datasource.dart';
import 'package:wizard_guide/src/domain/entities/user.dart';

class FirebaseDatasource implements IDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserData> login(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return UserData(
      email: 'email',
      phoneNumber: 'phoneNumber',
      dateOfBirth: DateTime.now(),
      gender: GenderEnum.MALE,
      password: 'password',
    );
  }

  @override
  Future<UserData> register(String email, String password, DateTime dateOfBirth,
      String gender) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    // TODO: Una vez creado el usuario tengo que mandar a almacenar la infor a la coleccion de usuario,
    // con el id que obtengo del registro

    return UserData(
      email: 'email',
      phoneNumber: 'phoneNumber',
      dateOfBirth: DateTime.now(),
      gender: GenderEnum.MALE,
      password: 'password',
    );
  }
}
