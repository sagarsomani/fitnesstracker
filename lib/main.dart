import 'package:fitnesstracker/screens/home/add_activity.dart';
import 'package:fitnesstracker/screens/home/dashboard_screen.dart';
import 'package:fitnesstracker/screens/login_screen.dart';
import 'package:fitnesstracker/screens/register_screen.dart';
import 'package:fitnesstracker/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initializes Firebase Connection
  runApp(const FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker Pro',
      debugShowCheckedModeBanner: false,

      // 1. Premium Theme Logic (Requirement: Dark Mode)
      themeMode: ThemeMode.system, // Switches based on phone settings
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.deepPurple,
      ),

      // 2. Navigation Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/add_activity': (context) => const AddActivityScreen(),
      },
    );
  }
}
