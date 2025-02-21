import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      home: AuthWrapper(), // Handle initial authentication flow
      routes: {
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const ProtectedRoute(child: HomePage()),
        '/profile': (context) => const ProtectedRoute(child: ProfileSettingsPage()),
        '/terms': (context) => const TermsConditionsPage(),
      },
    );
  }
}

/// **AuthWrapper Class** (Handles Protected Routes)
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const HomePage(); // If user is authenticated, go to HomePage
        } else {
          return const LandingPage(); // Otherwise, show LandingPage
        }
      },
    );
  }
}

/// **Protected Route Widget** (Ensures only authenticated users can access)
class ProtectedRoute extends StatelessWidget {
  final Widget child;
  const ProtectedRoute({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return child; // If logged in, allow access
        } else {
          return const LandingPage(); // Redirect to LandingPage if not logged in
        }
      },
    );
  }
}