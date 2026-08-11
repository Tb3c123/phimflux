import 'package:flutter/material.dart';
import '../../../../data/models/movie_summary.dart';
import '../../../core_widgets/cards/focusable_movie_card.dart';
import '../../../core_widgets/cards/skeleton_card.dart';
import 'horizontal_section_header.dart';

/// Horizontal scrolling row of standardized movie cards (Height 290 for 0-overflow)
class HorizontalMovieList extends StatelessWidget {
  final String title;
  final List<MovieSummary> movies;
  final bool isLoading;
  final ValueChanged<MovieSummary> onMovieTap;

  const HorizontalMovieList({
    super.key,
    required this.title,
    required this.movies,
    required this.isLoading,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HorizontalSectionHeader(title: title),
        FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: SizedBox(
            height: 290,
            child: isLoading
                ? ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 5,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, __) => const SkeletonCard(),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: movies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return FocusableMovieCard(
                        width: 140,
                        title: movie.name,
                        imageUrl: movie.thumbUrl,
                        quality: movie.quality,
                        language: movie.language,
                        onTap: () => onMovieTap(movie),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
