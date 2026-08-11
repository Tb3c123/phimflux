import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../core_widgets/focus/tv_focusable_wrapper.dart';

/// Compact Episode button widget saving vertical screen space
class EpisodeButton extends StatelessWidget {
  final String episodeName;
  final bool isSelected;
  final VoidCallback onTap;

  const EpisodeButton({
    super.key,
    required this.episodeName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TvFocusableWrapper(
      onTap: onTap,
      borderRadius: 6,
      child: Container(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 32),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryFocusGlow : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? AppColors.primaryFocusGlow : AppColors.cardBorderDefault,
          ),
        ),
        child: IntrinsicWidth(
          child: Center(
            child: Text(
              episodeName,
              style: AppTypography.badgeText.copyWith(
                color: isSelected ? Colors.black : AppColors.textPrimary,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
