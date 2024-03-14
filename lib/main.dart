import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/firebase_options.dart';
import 'package:wizard_guide/src/config/initialization_app.dart';
import 'package:wizard_guide/src/core/extensions/extensions.dart';
import 'package:wizard_guide/src/presenter/pages/home/home.dart';
import 'package:wizard_guide/src/presenter/pages/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  injectDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wizard Guide',
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? const HomePage()
          : const LoginPage(),
      initialBinding: FirebaseAuth.instance.currentUser != null
          ? HomeBinding()
          : LoginBinding(),
      theme: lightTheme(Theme.of(context).textTheme),
      darkTheme: darkTheme(Theme.of(context).textTheme),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [...GlobalMaterialLocalizations.delegates],
      supportedLocales: const [
        Locale('es'),
      ],
    );
  }
}
