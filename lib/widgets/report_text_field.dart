import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// text field used in ReportItemScreen.

class ReportTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? helperText;
  final IconData? prefixIcon;
  final Widget? trailing;
  final TextEditingController controller;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const ReportTextField({
    super.key,
    required this.label,
    required this.hint,
    this.helperText,
    this.prefixIcon,
    this.trailing,
    required this.controller,
    this.maxLines = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            helperText: helperText,
            helperStyle: const TextStyle(fontSize: 10, color: AppColors.muted),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 18, color: AppColors.muted)
                : null,
          ),
        ),
      ],
    );
  }
}
