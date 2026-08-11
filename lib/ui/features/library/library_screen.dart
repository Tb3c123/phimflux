import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/state/bookmark_provider.dart';
import '../../../core/state/history_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/movie_summary.dart';
import '../catalog/widgets/movie_grid_view.dart';

/// Library Screen displaying bookmarks & watch history
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);

    final historyMovies = historyProvider.history
        .map((h) => MovieSummary(
              name: h.movieName,
              slug: h.movieSlug,
              originalName: '',
              thumbUrl: '',
              posterUrl: '',
              year: '',
            ))
        .toList();

    return Container(
      color: AppColors.darkBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 65, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                '📌 Phim Đã Lưu',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            bookmarkProvider.bookmarks.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Chưa có phim nào trong tủ phim',
                        style: TextStyle(color: AppColors.textSecondary)),
                  )
                : MovieGridView(
                    movies: bookmarkProvider.bookmarks,
                    onMovieTap: (_) {},
                  ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                '🕒 Lịch Sử Xem',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            historyMovies.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Chưa có lịch sử xem phim',
                        style: TextStyle(color: AppColors.textSecondary)),
                  )
                : MovieGridView(
                    movies: historyMovies,
                    onMovieTap: (_) {},
                  ),
          ],
        ),
      ),
    );
  }
}
