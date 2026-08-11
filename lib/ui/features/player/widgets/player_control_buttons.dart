import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../core_widgets/focus/tv_focusable_wrapper.dart';

/// Play/Pause, Seek -10s, Seek +10s OSD control buttons
class PlayerControlButtons extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onRewind10;
  final VoidCallback onForward10;

  const PlayerControlButtons({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onRewind10,
    required this.onForward10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TvFocusableWrapper(
          onTap: onRewind10,
          borderRadius: 24,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.replay_10_rounded, color: AppColors.textPrimary, size: 36),
          ),
        ),
        const SizedBox(width: 24),
        TvFocusableWrapper(
          onTap: onPlayPause,
          autoFocus: true,
          borderRadius: 32,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryFocusGlow,
            ),
            child: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
        const SizedBox(width: 24),
        TvFocusableWrapper(
          onTap: onForward10,
          borderRadius: 24,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.forward_10_rounded, color: AppColors.textPrimary, size: 36),
          ),
        ),
      ],
    );
  }
}
