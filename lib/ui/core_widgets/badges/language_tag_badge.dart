import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Tag badge displaying language info (e.g. Vietsub, Thuyết Minh)
class LanguageTagBadge extends StatelessWidget {
  final String language;

  const LanguageTagBadge({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    if (language.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primaryFocusGlow.withOpacity(0.2),
        border: Border.all(color: AppColors.primaryFocusGlow, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        language,
        style: AppTypography.badgeText.copyWith(color: AppColors.primaryFocusGlow),
      ),
    );
  }
}
