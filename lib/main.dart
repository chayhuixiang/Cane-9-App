import 'package:cane_9_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Cane9App());
}

class Cane9App extends StatelessWidget {
  const Cane9App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Inter',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromRGBO(255, 129, 89, 1),
            background: const Color.fromRGBO(249, 227, 220, 1),
            primaryContainer: const Color.fromRGBO(223, 41, 53, 1),
            tertiary: const Color.fromRGBO(255, 102, 53, 1),
          ),
          textTheme: const TextTheme(
              titleSmall: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter'),
              bodySmall: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Inter'))),
      home: const LoginPage(),
    );
  }
}
