import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// University verified bottom badge

class CampusTrustBadge extends StatelessWidget {
  const CampusTrustBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.greenLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_outlined, size: 14, color: AppColors.green),
          SizedBox(width: 6),
          Text(
            'University Verified • Restricted to student & staff emails',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
