import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

/// Cyan Timeline Progress Bar for OSD
class PlayerProgressBar extends StatelessWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration> onSeek;

  const PlayerProgressBar({
    super.key,
    required this.position,
    required this.duration,
    required this.onSeek,
  });

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (d.inHours > 0) {
      return '${d.inHours}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final maxSec = duration.inSeconds > 0 ? duration.inSeconds.toDouble() : 1.0;
    final currentSec = position.inSeconds.toDouble().clamp(0.0, maxSec);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(_formatDuration(position), style: AppTypography.badgeText),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                activeTrackColor: AppColors.primaryFocusGlow,
                inactiveTrackColor: AppColors.cardBorderDefault,
                thumbColor: AppColors.primaryFocusGlow,
                overlayColor: AppColors.primaryFocusGlow.withOpacity(0.3),
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              ),
              child: Slider(
                value: currentSec,
                min: 0.0,
                max: maxSec,
                onChanged: (val) => onSeek(Duration(seconds: val.toInt())),
              ),
            ),
          ),
          Text(_formatDuration(duration), style: AppTypography.badgeText),
        ],
      ),
    );
  }
}
