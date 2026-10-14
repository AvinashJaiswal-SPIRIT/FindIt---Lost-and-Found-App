import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen03 extends StatefulWidget {
  const OnboardingScreen03({super.key});

  @override
  State<OnboardingScreen03> createState() => _OnboardingScreen03State();
}

class _OnboardingScreen03State extends State<OnboardingScreen03> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Let's Begin button
          Positioned(
            bottom: 60,
            left: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4938E8),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                elevation: 8,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let's Begin",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward, size: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}