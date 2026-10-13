import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'primary_button.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onButtonTap;

  const EmptyState({
    super.key,
    this.title = 'No active listings',
    this.subtitle =
        'All caught up! Found something lost or missing your own essentials on campus?',
    this.buttonText = 'Report an Item',
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.all_inbox_rounded,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.muted,
              height: 1.4,
            ),
          ),
          if (onButtonTap != null) ...[
            const SizedBox(height: 16),
            PrimaryButton(
              text: buttonText,
              icon: Icons.add_circle_outline,
              onPressed: onButtonTap,
              height: 42,
            ),
          ],
        ],
      ),
    );
  }
}
