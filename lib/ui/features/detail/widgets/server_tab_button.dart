import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../core_widgets/focus/tv_focusable_wrapper.dart';

/// Server tab selection button (e.g. Vietsub / Thuyết Minh)
class ServerTabButton extends StatelessWidget {
  final String serverName;
  final bool isSelected;
  final VoidCallback onTap;

  const ServerTabButton({
    super.key,
    required this.serverName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TvFocusableWrapper(
      onTap: onTap,
      borderRadius: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryFocusGlow : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          serverName,
          style: AppTypography.badgeText.copyWith(
            color: isSelected ? Colors.black : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
