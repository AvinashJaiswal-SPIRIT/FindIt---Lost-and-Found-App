import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final bool showDot;

  const StatusBadge({
    super.key,
    required this.label,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    final clean = label.toUpperCase();
    final isLost = clean.contains('LOST');
    final isFound = clean.contains('FOUND');
    final isReturned = clean.contains('RETURN') || clean.contains('RESOLV');

    final Color bgColor = isLost
        ? AppColors.redLight
        : isFound
            ? AppColors.blueLight
            : isReturned
                ? AppColors.greenLight
                : AppColors.primaryLight;

    final Color textColor = isLost
        ? AppColors.red
        : isFound
            ? AppColors.blue
            : isReturned
                ? AppColors.green
                : AppColors.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: textColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            clean,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}