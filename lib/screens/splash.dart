import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/pref_service.dart';
import 'home_screen.dart';
import 'onboarding_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final loggedIn = await PrefService.isLoggedIn();
    final user = FirebaseAuth.instance.currentUser;
    if (loggedIn && user != null) {
      final tokenResult = await user.getIdTokenResult();
      debugPrint('====================================================');
      debugPrint(' [SPLASH: PERSISTED SESSION VERIFIED BY FIREBASE]');
      debugPrint(' Active User UID : ${user.uid}');
      debugPrint(' Active Email    : ${user.email}');
      debugPrint(' Token Valid To  : ${tokenResult.expirationTime}');
      debugPrint('====================================================');
    }
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => (loggedIn && user != null)
            ? const HomeScreen()
            : const OnboardingScreen01(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 70, 234),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
