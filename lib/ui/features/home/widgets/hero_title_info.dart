import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/focus/tv_focus_engine.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../core_widgets/badges/language_tag_badge.dart';
import '../../../core_widgets/badges/quality_tag_badge.dart';
import '../../../core_widgets/buttons/primary_play_button.dart';

/// Title, metadata tags & play button overlay for Hero banner with Left Edge Escape
class HeroTitleInfo extends StatelessWidget {
  final String title;
  final String quality;
  final String language;
  final String year;
  final VoidCallback onPlayTap;

  const HeroTitleInfo({
    super.key,
    required this.title,
    required this.quality,
    required this.language,
    required this.year,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.heroTitle,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            QualityTagBadge(quality: quality),
            const SizedBox(width: 8),
            LanguageTagBadge(language: language),
            if (year.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(year, style: AppTypography.bodySecondary),
            ],
          ],
        ),
        const SizedBox(height: 14),
        PrimaryPlayButton(
          onTap: onPlayTap,
          autoFocus: true,
          onKeyEvent: (node, event) {
            if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              TvFocusEngine().focusSidebar();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
        ),
      ],
    );
  }
}
