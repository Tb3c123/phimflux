import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Tag badge displaying quality info (e.g. 4K, HDR, HD)
class QualityTagBadge extends StatelessWidget {
  final String quality;

  const QualityTagBadge({super.key, required this.quality});

  @override
  Widget build(BuildContext context) {
    if (quality.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.secondaryAccent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        quality.toUpperCase(),
        style: AppTypography.badgeText.copyWith(color: Colors.black),
      ),
    );
  }
}
