import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AutoSaveHeader extends StatelessWidget {
  final String text;
  final String stepText;

  const AutoSaveHeader({
    super.key,
    this.text = 'DRAFT AUTO-SAVED 9:41 AM',
    this.stepText = 'Step 1 of 2',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.green,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Text(
          stepText,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
