import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class HomeGreeting extends StatelessWidget {
  final String userName;
  final int reportedCount;

  const HomeGreeting({
    super.key,
    this.userName = 'Avi',
    required this.reportedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi $userName 👋',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$reportedCount items reported around campus',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.explore_outlined,
            color: AppColors.primary,
            size: 22,
          ),
        ),
      ],
    );
  }
}
