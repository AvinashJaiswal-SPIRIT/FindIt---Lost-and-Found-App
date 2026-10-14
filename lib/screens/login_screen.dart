import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/app_logo.dart';
import '../widgets/auth_tab_switch.dart';
import '../widgets/campus_trust_badge.dart';
import '../widgets/primary_button.dart';
import '../widgets/sso_button.dart';
import '../widgets/success_story_card.dart';

import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final mail = _emailController.text.trim();
    final pass = _passwordController.text.trim();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: pass)
          .then((value) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      });
    } catch (err) {
      debugPrint(err.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                const AppLogo(size: 60),
                const SizedBox(height: 14),
                _buildHeaderBadge(),
                const SizedBox(height: 6),
                const Text(
                  'Find What Matters',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Campus Lost & Found community for students and faculty',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: AppColors.muted),
                ),
                const SizedBox(height: 18),
                const SuccessStoryCard(),
                const SizedBox(height: 18),
                AuthTabSwitch(
                  isSignIn: true,
                  onToggle: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  ),
                ),
                const SizedBox(height: 18),
                _buildEmailField(),
                const SizedBox(height: 14),
                _buildPasswordField(),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: 'Sign In',
                  trailingIcon: Icons.arrow_forward_rounded,
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: 16),
                _buildDivider(),
                const SizedBox(height: 14),
                SsoButton(
                  text: 'Sign in with Campus SSO',
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: 16),
                _buildFooterLink(),
                const SizedBox(height: 14),
                const CampusTrustBadge(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'CAMPUS COMMUNITY HUB',
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Campus Email',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.text),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(fontSize: 13),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_outlined, size: 18, color: AppColors.muted),
            hintText: 'student@campus.edu',
          ),
          validator: (v) => v == null || v.isEmpty ? 'Please enter campus email' : null,
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Password',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.text),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18, color: AppColors.muted),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 18,
                color: AppColors.muted,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            hintText: 'Enter password',
          ),
          validator: (v) => v == null || v.isEmpty ? 'Please enter password' : null,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR FAST ACCESS',
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.muted),
          ),
        ),
        Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }

  Widget _buildFooterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(fontSize: 11, color: AppColors.muted)),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SignupScreen()),
          ),
          child: const Text(
            'Create an account',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}