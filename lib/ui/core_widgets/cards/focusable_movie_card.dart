import 'package:flutter/material.dart';
import '../../../core/focus/tv_focusable.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../badges/language_tag_badge.dart';
import '../badges/quality_tag_badge.dart';
import 'movie_poster_image.dart';

/// Standardized Compact Movie Card with AspectRatio poster, title & bottom action button
class FocusableMovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String quality;
  final String language;
  final VoidCallback onTap;
  final FocusOnKeyEventCallback? onKeyEvent;
  final double? width;

  const FocusableMovieCard({
    super.key,
    required this.title,
    required this.imageUrl,
    this.quality = '',
    this.language = '',
    required this.onTap,
    this.onKeyEvent,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return TvFocusable(
      onTap: onTap,
      onKeyEvent: onKeyEvent,
      borderRadius: 8,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Poster Image with top badges
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 0.70,
                  child: MoviePosterImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: 0,
                  ),
                ),
                if (quality.isNotEmpty)
                  Positioned(
                    top: 6,
                    left: 6,
                    child: QualityTagBadge(quality: quality),
                  ),
                if (language.isNotEmpty)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: LanguageTagBadge(language: language),
                  ),
              ],
            ),
            // 2. Movie Title & CHI TIẾT Button below poster
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryFocusGlow,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow_rounded, size: 12, color: Colors.black),
                        SizedBox(width: 2),
                        Text(
                          'CHI TIẾT',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
