import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// SSO button

class SsoButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SsoButton({
    super.key,
    this.text = 'Sign in with Campus SSO',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.school_rounded, color: AppColors.amber, size: 18),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 46),
        backgroundColor: Colors.white,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
