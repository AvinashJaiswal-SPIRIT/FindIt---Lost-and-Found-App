import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// Recovery success story banner on auth screens

class SuccessStoryCard extends StatelessWidget {
  final String rate;
  final String title;
  final String subtitle;
  final String imageUrl;

  const SuccessStoryCard({
    super.key,
    this.rate = '⚡ 84% Recovered',
    this.title = 'Reunited Yesterday',
    this.subtitle =
        'Liam got his student keys back at Quad North within 25 mins.',
    this.imageUrl =
        'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=500',
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              width: 58,
              height: 58,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 58,
                height: 58,
                color: AppColors.primaryLight,
                child: const Icon(
                  Icons.people_alt_rounded,
                  color: AppColors.primary,
                  size: 26,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.amberLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    rate,
                    style: const TextStyle(
                      color: AppColors.amber,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
