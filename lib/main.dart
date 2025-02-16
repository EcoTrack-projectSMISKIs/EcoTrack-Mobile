import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecotrack_mobile/screens/landing_page.dart';
import 'package:ecotrack_mobile/screens/login_page.dart';
import 'package:ecotrack_mobile/screens/register_page.dart';
import 'package:ecotrack_mobile/screens/home_page.dart';
import 'package:ecotrack_mobile/screens/profile_settings.dart';
import 'package:ecotrack_mobile/screens/terms_conditions_page.dart';
import 'package:ecotrack_mobile/firebase_options.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoTrack',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfileSettingsPage(),
        '/terms': (context) => const TermsConditionsPage(),
      },
    );
  }
}
