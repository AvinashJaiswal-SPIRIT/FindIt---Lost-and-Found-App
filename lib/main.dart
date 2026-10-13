import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/listings_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/report_item_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(const FindItApp());
}

class FindItApp extends StatelessWidget {
  const FindItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindIt',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/listings': (context) => const ListingsScreen(),
        '/report': (context) => const ReportItemScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}