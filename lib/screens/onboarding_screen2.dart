import 'package:flutter/material.dart';
import 'onboarding_screen3.dart';

class OnboardingScreen02 extends StatefulWidget {
  const OnboardingScreen02({super.key});

  @override
  State<OnboardingScreen02> createState() => _OnboardingScreen02State();
}

class _OnboardingScreen02State extends State<OnboardingScreen02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4938E8),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null &&
              details.primaryVelocity! < 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen03(),
              ),
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/onboarding2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}