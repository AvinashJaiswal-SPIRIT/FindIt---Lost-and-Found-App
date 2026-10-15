import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// Sign in and create account page switching

class AuthTabSwitch extends StatelessWidget {
  final bool isSignIn;
  final VoidCallback onToggle;

  const AuthTabSwitch({
    super.key,
    required this.isSignIn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: isSignIn
                ? _buildActiveTab(Icons.login_rounded, 'Sign In')
                : _buildInactiveTab(Icons.login_rounded, 'Sign In', onToggle),
          ),
          Expanded(
            child: !isSignIn
                ? _buildActiveTab(Icons.person_add_alt_1_rounded, 'Create Account')
                : _buildInactiveTab(Icons.person_add_alt_1_rounded, 'Create Account', onToggle),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTab(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInactiveTab(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: AppColors.muted),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}
