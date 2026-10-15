import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// Creator controls (Edit, Resolved, Remove).

class ListingControlsCard extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onResolved;
  final VoidCallback onRemove;

  const ListingControlsCard({
    super.key,
    required this.onEdit,
    required this.onResolved,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Listing Controls (Creator View)',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              Text(
                'Your Post',
                style: TextStyle(fontSize: 9, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Did Mayank or the circulation staff complete hand-off? Keep the campus board accurate.',
            style: TextStyle(fontSize: 10, color: AppColors.muted),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onEdit,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: const Text('Edit', style: TextStyle(fontSize: 11, color: AppColors.text)),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ElevatedButton(
                  onPressed: onResolved,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 0,
                  ),
                  child: const Text('Resolved', style: TextStyle(fontSize: 11, color: Colors.white)),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: OutlinedButton(
                  onPressed: onRemove,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    side: const BorderSide(color: AppColors.redLight),
                  ),
                  child: const Text('Remove', style: TextStyle(fontSize: 11, color: AppColors.red)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
