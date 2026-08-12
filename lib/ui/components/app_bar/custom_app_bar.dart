import 'package:flutter/material.dart';
import '../../../core/focus/tv_focusable.dart';
import '../../../core/theme/app_colors.dart';

/// Top application bar displaying Brand Logo asset & TV-friendly Search button
class CustomAppBar extends StatelessWidget {
  final String title;
  final ValueChanged<String>? onSearchSubmit;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onSearchSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.85),
            Colors.black.withOpacity(0.0),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/brand_logo.jpg',
              height: 40,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Row(
                children: [
                  const Icon(Icons.play_circle_fill_rounded, color: AppColors.primaryFocusGlow, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (onSearchSubmit != null)
            TvFocusable(
              onTap: () => onSearchSubmit!(''),
              borderRadius: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search_rounded, color: AppColors.primaryFocusGlow, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Tìm kiếm phim...',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
