import 'package:cochabambacultural/ui/screen/welcome_screen.dart';
import 'package:cochabambacultural/ui/screen/login_screen.dart';
import 'package:cochabambacultural/ui/screen/user_register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cochabamba Cultural',
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (_) => const WelcomeScreen(),
        'login_screen': (_) => const LoginScreen(),
        'user_register_screen': (_) => const UserRegisterScreen(),
      },
    );
  }
}
