import 'package:cochabambacultural/cultural_event/bloc/cultural_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cochabambacultural/ui/screen/welcome_screen.dart';
import 'package:cochabambacultural/ui/screen/login_screen.dart';
import 'package:cochabambacultural/ui/screen/user_register_screen.dart';

import 'package:cochabambacultural/user/ui/screens/user_home.dart';

import 'package:cochabambacultural/cultural_event/ui/screens/event_registration_form.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cochabambacultural/user/bloc/user_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, statusBarIconBrightness: Brightness.light));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => CulturalEventBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cochabamba Cultural',
        initialRoute: 'welcome_screen',
        routes: {
          'welcome_screen': (_) => const WelcomeScreen(),
          'login_screen': (_) => const LoginScreen(),
          'user_register_screen': (_) => const UserRegisterScreen(),
          'user_home_screen': (_) => const UserHomeScreen(),
          'create_event_screen': (_) => const EventRegistrationForm()
        },
      ),
    );
  }
}
