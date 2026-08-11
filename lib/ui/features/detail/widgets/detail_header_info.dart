import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/movie_detail.dart';
import '../../../core_widgets/badges/language_tag_badge.dart';
import '../../../core_widgets/badges/quality_tag_badge.dart';
import '../../../core_widgets/buttons/primary_play_button.dart';
import '../../../core_widgets/buttons/secondary_action_button.dart';
import '../../../core_widgets/cards/movie_poster_image.dart';

/// Detailed movie header displaying movie poster image, metadata, genres & IMDb rating
class DetailHeaderInfo extends StatelessWidget {
  final MovieDetail detail;
  final VoidCallback onPlayFirstEpisode;
  final VoidCallback onBookmarkTap;
  final bool isBookmarked;

  const DetailHeaderInfo({
    super.key,
    required this.detail,
    required this.onPlayFirstEpisode,
    required this.onBookmarkTap,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final infoColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(detail.name, style: AppTypography.heroTitle),
            if (detail.originalName.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                detail.originalName,
                style: AppTypography.bodySecondary.copyWith(color: AppColors.primaryFocusGlow),
              ),
            ],
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                QualityTagBadge(quality: detail.quality),
                LanguageTagBadge(language: detail.language),
                if (detail.imdbRating.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(/* IMDb Gold */ 0xFFF5C518),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, size: 13, color: Colors.black),
                        const SizedBox(width: 2),
                        Text(
                          '${detail.imdbRating} IMDb',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (detail.year.isNotEmpty)
                  Text(detail.year, style: AppTypography.bodySecondary),
                if (detail.time.isNotEmpty)
                  Text('• ${detail.time}', style: AppTypography.bodySecondary),
              ],
            ),
            if (detail.genres.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: detail.genres.take(5).map((g) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.cardBorderDefault),
                    ),
                    child: Text(
                      g,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 14),
            Row(
              children: [
                PrimaryPlayButton(
                  onTap: onPlayFirstEpisode,
                  label: 'XEM TẬP 1',
                  autoFocus: true,
                ),
                const SizedBox(width: 12),
                SecondaryActionButton(
                  onTap: onBookmarkTap,
                  label: isBookmarked ? 'Đã Lưu' : 'Thêm Tủ Phim',
                  icon: isBookmarked ? Icons.bookmark_added_rounded : Icons.bookmark_border_rounded,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text('Đạo diễn: ${detail.director}', style: AppTypography.bodySecondary),
            const SizedBox(height: 4),
            Text('Diễn viên: ${detail.casts}', style: AppTypography.bodySecondary),
            const SizedBox(height: 12),
            Text(
              detail.description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.bodySecondary.copyWith(
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ],
        );

        final poster = MoviePosterImage(
          imageUrl: detail.posterUrl.isNotEmpty ? detail.posterUrl : detail.thumbUrl,
          width: 170,
          height: 245,
          borderRadius: 12,
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: poster),
              const SizedBox(height: 16),
              infoColumn,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            poster,
            const SizedBox(width: 24),
            Expanded(child: infoColumn),
          ],
        );
      },
    );
  }
}
