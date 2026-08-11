import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design Token Typography for PhimFlux UI
class AppTypography {
  static const TextStyle heroTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle sectionHeader = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle badgeText = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
}
