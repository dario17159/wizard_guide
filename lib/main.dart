import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/firebase_options.dart';
import 'package:wizard_guide/src/presenter/pages/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wizard Guide',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      initialBinding: LoginBinding(),
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1A3E6D),
      ),
    );
  }
}
