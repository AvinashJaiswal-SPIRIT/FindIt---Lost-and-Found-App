import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../core/app_colors.dart';

// Image display from different sources

class ItemImageView extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? fallback;

  const ItemImageView({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.fallback,
  });

  Widget _defaultFallback() {
    return fallback ??
        Container(
          width: width,
          height: height,
          color: AppColors.primaryLight,
          child: const Center(
            child: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.primary,
              size: 28,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) {
      return _defaultFallback();
    }
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _defaultFallback(),
      );
    }
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _defaultFallback(),
      );
    }
    if (kIsWeb) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _defaultFallback(),
      );
    }
    return Image.file(
      File(imagePath),
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, _, _) => _defaultFallback(),
    );
  }
}
