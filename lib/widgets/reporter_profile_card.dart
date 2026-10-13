import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ReporterProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String responseTime;
  final String karma;
  final String avatar;

  const ReporterProfileCard({
    super.key,
    required this.name,
    required this.role,
    this.responseTime = 'Within 1 hour',
    this.karma = '14 items returned',
    this.avatar =
        'assets/images/report_image.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(avatar),
                    backgroundColor: AppColors.primaryLight,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: AppColors.green,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name • Sophomore',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 1),
                    const Row(
                      children: [
                        Icon(Icons.verified, size: 11, color: AppColors.primary),
                        SizedBox(width: 4),
                        Text(
                          'Campus Verified Student',
                          style: TextStyle(fontSize: 10, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildStatPill('Response Time', '⚡ $responseTime'),
              const SizedBox(width: 8),
              _buildStatPill('Goodwill Karma', '🤝 $karma'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 9, color: AppColors.muted),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
