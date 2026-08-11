import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Search input bar with text field & clear button
class SearchInputBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  const SearchInputBar({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cardBorderDefault),
        ),
        child: TextField(
          controller: controller,
          onSubmitted: onSubmitted,
          autofocus: true,
          style: AppTypography.cardTitle,
          decoration: InputDecoration(
            hintText: 'Nhập tên phim, diễn viên...',
            hintStyle: AppTypography.bodySecondary,
            prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primaryFocusGlow),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, color: AppColors.textSecondary),
                    onPressed: onClear,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}
