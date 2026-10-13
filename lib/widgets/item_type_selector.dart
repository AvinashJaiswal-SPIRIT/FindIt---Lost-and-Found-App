import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ItemTypeSelector extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onChanged;

  const ItemTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildTypeButton(
            'I Lost an Item',
            Icons.search_rounded,
            selectedType == 'Lost',
            () => onChanged('Lost'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildTypeButton(
            'I Found an Item',
            Icons.label_outline_rounded,
            selectedType == 'Found',
            () => onChanged('Found'),
          ),
        ),
      ],
    );
  }

  Widget _buildTypeButton(
    String label,
    IconData icon,
    bool active,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: active ? Colors.white : AppColors.muted),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: active ? Colors.white : AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
