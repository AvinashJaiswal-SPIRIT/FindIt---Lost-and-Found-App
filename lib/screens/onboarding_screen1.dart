import 'package:flutter/material.dart';
import 'onboarding_screen2.dart';

class OnboardingScreen01 extends StatefulWidget {
  const OnboardingScreen01({super.key});

  @override
  State<OnboardingScreen01> createState() => _OnboardingScreen01State();
}

class _OnboardingScreen01State extends State<OnboardingScreen01> {
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
                builder: (context) => const OnboardingScreen02(),
              ),
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/onboarding1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}