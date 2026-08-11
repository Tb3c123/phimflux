import '../models/movie_detail.dart';
import '../models/movie_summary.dart';
import '../services/api_service.dart';
import '../services/omdb_service.dart';

/// Repository providing movie data enriched with OMDb metadata to UI features
class MovieRepository {
  final ApiService apiService;
  final OmdbService omdbService;

  MovieRepository({
    ApiService? apiService,
    OmdbService? omdbService,
  })  : apiService = apiService ?? ApiService(),
        omdbService = omdbService ?? OmdbService();

  Future<List<MovieSummary>> getLatestMovies({int page = 1}) {
    return apiService.getLatestMovies(page: page);
  }

  Future<List<MovieSummary>> getSingleMovies({int page = 1}) {
    return apiService.getMoviesByCategory('phim-le', page: page);
  }

  Future<List<MovieSummary>> getSeriesMovies({int page = 1}) {
    return apiService.getMoviesByCategory('phim-bo', page: page);
  }

  Future<List<MovieSummary>> getMoviesByCategory(String categoryType, {int page = 1}) {
    return apiService.getMoviesByCategory(categoryType, page: page);
  }

  Future<MovieDetail?> getMovieDetail(String slug) async {
    final detail = await apiService.getMovieDetail(slug);
    if (detail == null) return null;

    final queryTitle = detail.originalName.isNotEmpty ? detail.originalName : detail.name;
    final omdbData = await omdbService.fetchMovieMetadata(queryTitle);

    if (omdbData != null) {
      return detail.copyWithOmdb(omdbData);
    }
    return detail;
  }

  Future<List<MovieSummary>> searchMovies(String keyword, {int page = 1}) {
    return apiService.searchMovies(keyword, page: page);
  }
}
