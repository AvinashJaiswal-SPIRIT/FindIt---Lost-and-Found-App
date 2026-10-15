import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// 	Distance tag and map placeholder

class PickupCoordinatesCard extends StatelessWidget {
  final String distance;
  final String locationTag;

  const PickupCoordinatesCard({
    super.key,
    this.distance = '📍 220 ft away',
    this.locationTag = 'Circulation Desk B • Open until 11:00 PM',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pickup Coordinates',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            Text(
              distance,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(Icons.location_on_rounded, color: AppColors.primary, size: 32),
              ),
              Positioned(
                bottom: 8,
                left: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.place, size: 12, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        locationTag,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
