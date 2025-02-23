import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:ecotrack_mobile/screens/landing_page.dart';
import 'package:ecotrack_mobile/screens/login_page.dart';
import 'package:ecotrack_mobile/screens/register_page.dart';
import 'package:ecotrack_mobile/screens/home_page.dart';
import 'package:ecotrack_mobile/screens/profile_settings.dart';
import 'package:ecotrack_mobile/screens/terms_conditions_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: AuthWrapper(),
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

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isAuthenticated = false;
  String name = "";
  String username = "";
  String email = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    setState(() {
      isAuthenticated = token != null;
      name = prefs.getString('name') ?? "";
      username = prefs.getString('username') ?? "";
      email = prefs.getString('email') ?? "";
      phone = prefs.getString('phone') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuthenticated ? const HomePage() : const LandingPage();
  }
}

class ProtectedRoute extends StatefulWidget {
  final Widget child;
  const ProtectedRoute({super.key, required this.child});

  @override
  _ProtectedRouteState createState() => _ProtectedRouteState();
}

class _ProtectedRouteState extends State<ProtectedRoute> {
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    setState(() {
      isAuthenticated = token != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isAuthenticated ? widget.child : const LandingPage();
  }
}

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LandingPage()),
    (Route<dynamic> route) => false,
  );
}
