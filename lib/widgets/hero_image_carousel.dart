import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'item_image_view.dart';

class HeroImageCarousel extends StatelessWidget {
  final String imageUrl;
  final String pageText;
  final String badgeLeft;
  final String badgeRight;

  const HeroImageCarousel({
    super.key,
    required this.imageUrl,
    this.pageText = '1/3',
    this.badgeLeft = '🛡️ Safe Hand-off Logged',
    this.badgeRight = '🔍 Inspect Details',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.primaryLight,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ItemImageView(
              imagePath: imageUrl,
              fit: BoxFit.cover,
              fallback: const Center(
                child: Icon(Icons.inventory_2_outlined, size: 50, color: AppColors.primary),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                pageText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: _buildBadge(badgeLeft),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: _buildBadge(badgeRight),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
