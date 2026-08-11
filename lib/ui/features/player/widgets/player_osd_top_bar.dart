import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Top OSD Bar for video player (Back button + Movie & Episode Title)
class PlayerOsdTopBar extends StatelessWidget {
  final String movieTitle;
  final String episodeName;
  final VoidCallback onBack;

  const PlayerOsdTopBar({
    super.key,
    required this.movieTitle,
    required this.episodeName,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.transparent,
          ],
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary, size: 28),
              onPressed: onBack,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(movieTitle, style: AppTypography.cardTitle),
                  Text(
                    episodeName,
                    style: AppTypography.bodySecondary.copyWith(color: AppColors.primaryFocusGlow),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
