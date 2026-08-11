import 'package:flutter_test/flutter_test.dart';
import 'package:phimflux/data/models/movie_summary.dart';
import 'package:phimflux/data/services/api_service.dart';

void main() {
  group('ApiService Real-time Tests', () {
    final apiService = ApiService();

    test('getLatestMovies fetches non-empty list of MovieSummary', () async {
      final movies = await apiService.getLatestMovies(page: 1);
      expect(movies, isNotEmpty);
      expect(movies.first.name, isNotEmpty);
      expect(movies.first.slug, isNotEmpty);
    });

    test('MovieSummary.fromJson parses JSON correctly', () {
      final jsonMap = {
        'name': 'Phim Test',
        'slug': 'phim-test',
        'original_name': 'Test Movie',
        'thumb_url': 'https://example.com/thumb.jpg',
        'poster_url': 'https://example.com/poster.jpg',
        'current_episode': 'Tập 1',
        'quality': '4K',
        'language': 'Vietsub',
        'year': '2026',
      };

      final movie = MovieSummary.fromJson(jsonMap);
      expect(movie.name, 'Phim Test');
      expect(movie.slug, 'phim-test');
      expect(movie.quality, '4K');
      expect(movie.language, 'Vietsub');
    });
  });
}
