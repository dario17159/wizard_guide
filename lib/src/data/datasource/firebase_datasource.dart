import 'package:firebase_auth/firebase_auth.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/domain/datasource/datasource.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class FirebaseDatasource implements IDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
  Future<UserData> register(UserData userdata) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: userdata.email,
      password: userdata.password,
    );

    // TODO: Una vez creado el usuario tengo que mandar a almacenar la infor a la coleccion de usuario,
    // con el id que obtengo del registro

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
}
