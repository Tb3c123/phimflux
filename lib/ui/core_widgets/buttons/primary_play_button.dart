import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../focus/tv_focusable_wrapper.dart';

/// Primary "Xem Ngay" button with Cyan styling
class PrimaryPlayButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool autoFocus;

  const PrimaryPlayButton({
    super.key,
    required this.onTap,
    this.label = 'XEM NGAY',
    this.autoFocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TvFocusableWrapper(
      onTap: onTap,
      autoFocus: autoFocus,
      borderRadius: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryFocusGlow,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 24),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.cardTitle.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
