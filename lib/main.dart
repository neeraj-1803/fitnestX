// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:fitnestx_flutter/auth/auth_page.dart';
import 'package:fitnestx_flutter/dashboard/SavedPage.dart';
import 'package:fitnestx_flutter/dashboard/landing_page.dart';
import 'package:fitnestx_flutter/dashboard/exercise_page.dart';
import 'package:fitnestx_flutter/onboarding/intro_page.dart';
import 'package:fitnestx_flutter/registration/goals.dart';
import 'package:fitnestx_flutter/registration/profile.dart';
import 'package:fitnestx_flutter/registration/user_registration.dart';
import 'package:fitnestx_flutter/registration/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/*
  ANDROID App Link - https://i.diawi.com/iVgvPh
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  await Hive.openBox('exercisedb');
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation()
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      builder: EasyLoading.init(),
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/registration': (context) => const AuthPage(),
        '/userregistration': (context) => UserRegistration(isBack: false),
        '/registrationprofile': (context) => const RegistrationProfile(),
        '/goals': (context) => const Goals(),
        '/welcome': (context) => const WelcomePage(),
        '/dashboard': (context) => const LandingPage(),
        '/exercisepage': (context) => const ExercisePage(),
        '/savedpage': (context) => const Savedpage(),
      },
    );
  }
}
