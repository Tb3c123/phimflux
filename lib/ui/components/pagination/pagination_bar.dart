import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../core_widgets/focus/tv_focusable_wrapper.dart';

/// Pagination bar component for catalog screens
class PaginationBar extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPage > 1)
            TvFocusableWrapper(
              onTap: () => onPageChanged(currentPage - 1),
              borderRadius: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_back_ios_rounded, size: 14, color: AppColors.textPrimary),
                    SizedBox(width: 4),
                    Text('Trang Trước', style: AppTypography.badgeText),
                  ],
                ),
              ),
            ),
          const SizedBox(width: 16),
          Text(
            'Trang $currentPage',
            style: AppTypography.cardTitle.copyWith(color: AppColors.primaryFocusGlow),
          ),
          const SizedBox(width: 16),
          TvFocusableWrapper(
            onTap: () => onPageChanged(currentPage + 1),
            borderRadius: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Text('Trang Sau', style: AppTypography.badgeText),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textPrimary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
