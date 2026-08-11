import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Skeleton loading card placeholder
class SkeletonCard extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonCard({
    super.key,
    this.width = 140,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Container(
          width: width * 0.7,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.cardBorderDefault,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
