import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/focus/tv_focus_engine.dart';
import '../../../core/focus/tv_focusable.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// Single item component inside TV Sidebar Menu with ArrowRight jump to main content
class TvSidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isExpanded;
  final bool autoFocus;
  final VoidCallback onTap;

  const TvSidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isExpanded,
    this.autoFocus = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isSelected ? AppColors.primaryFocusGlow : AppColors.textSecondary;

    return TvFocusable(
      onTap: onTap,
      autoFocus: autoFocus,
      borderRadius: 8,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.arrowRight) {
          TvFocusEngine().focusMainArea();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: activeColor, size: 22),
            if (isExpanded) ...[
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  style: AppTypography.cardTitle.copyWith(
                    color: activeColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
