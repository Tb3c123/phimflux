import 'package:flutter/material.dart';
import '../../../../data/models/movie_summary.dart';
import '../../../core_widgets/cards/focusable_movie_card.dart';

/// Grid view layout displaying standardized movie cards (Ratio 0.49)
class MovieGridView extends StatelessWidget {
  final List<MovieSummary> movies;
  final ValueChanged<MovieSummary> onMovieTap;

  const MovieGridView({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = (constraints.maxWidth / 160).floor().clamp(2, 6);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.49,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return FocusableMovieCard(
              title: movie.name,
              imageUrl: movie.thumbUrl,
              quality: movie.quality,
              language: movie.language,
              onTap: () => onMovieTap(movie),
            );
          },
        );
      },
    );
  }
}
