import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../core_widgets/focus/tv_focusable_wrapper.dart';

/// Category filter chips selector
class FilterChipGroup extends StatelessWidget {
  final List<Map<String, String>> filters;
  final String selectedSlug;
  final ValueChanged<String> onSelected;

  const FilterChipGroup({
    super.key,
    required this.filters,
    required this.selectedSlug,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = filters[index];
          final isSelected = selectedSlug == item['slug'];
          return TvFocusableWrapper(
            onTap: () => onSelected(item['slug']!),
            borderRadius: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryFocusGlow : AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item['label']!,
                style: AppTypography.badgeText.copyWith(
                  color: isSelected ? Colors.black : AppColors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
