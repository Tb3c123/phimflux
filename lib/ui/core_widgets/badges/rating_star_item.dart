import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Star icon item displaying rating score
class RatingStarItem extends StatelessWidget {
  final double rating;

  const RatingStarItem({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star_rounded,
          color: AppColors.secondaryAccent,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          rating > 0 ? rating.toStringAsFixed(1) : 'N/A',
          style: AppTypography.badgeText.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
