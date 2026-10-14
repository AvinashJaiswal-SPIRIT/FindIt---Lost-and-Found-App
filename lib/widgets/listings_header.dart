import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ListingsHeader extends StatelessWidget {
  final int totalCount;
  final String activeTab;
  final int activeCount;
  final int returnedCount;
  final ValueChanged<String> onTabChanged;
  final VoidCallback onSortTap;
  final VoidCallback onFilterTap;

  const ListingsHeader({
    super.key,
    required this.totalCount,
    required this.activeTab,
    required this.activeCount,
    required this.returnedCount,
    required this.onTabChanged,
    required this.onSortTap,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Campus Posts',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$totalCount Total',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: onSortTap,
              icon: const Icon(Icons.swap_vert_rounded, color: AppColors.muted, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 12),
            IconButton(
              onPressed: onFilterTap,
              icon: const Icon(Icons.tune_rounded, color: AppColors.muted, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _buildTabPill('Active', '$activeCount', activeTab == 'Active'),
            const SizedBox(width: 10),
            _buildTabPill('Returned & Resolved', '$returnedCount', activeTab != 'Active'),
          ],
        ),
      ],
    );
  }

  Widget _buildTabPill(String title, String count, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.text,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.25)
                      : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  count,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : AppColors.muted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
