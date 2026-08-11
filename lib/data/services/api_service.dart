import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/episode.dart';
import '../models/movie_detail.dart';
import '../models/movie_summary.dart';

/// HTTP Client Service for NguonC API (phim.nguonc.com)
class ApiService {
  static const String baseUrl = 'https://phim.nguonc.com/api';

  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  /// Fetch latest updated movies
  Future<List<MovieSummary>> getLatestMovies({int page = 1}) async {
    final response = await client.get(
      Uri.parse('$baseUrl/films/phim-moi-cap-nhat?page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List? ?? [];
      return items.map((e) => MovieSummary.fromJson(e)).toList();
    }
    return [];
  }

  /// Fetch detailed movie info by slug
  Future<MovieDetail?> getMovieDetail(String slug) async {
    final response = await client.get(Uri.parse('$baseUrl/film/$slug'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final movieData = data['movie'];
      final rawServers = movieData?['episodes'] as List? ?? [];
      final servers = rawServers.map((s) => ServerData.fromJson(s)).toList();
      return MovieDetail.fromJson(data, servers);
    }
    return null;
  }

  /// Fetch movies list by category/genre
  Future<List<MovieSummary>> getMoviesByCategory(String categorySlug, {int page = 1}) async {
    final response = await client.get(
      Uri.parse('$baseUrl/films/danh-sach/$categorySlug?page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List? ?? [];
      return items.map((e) => MovieSummary.fromJson(e)).toList();
    }
    return [];
  }

  /// Search movies by keyword
  Future<List<MovieSummary>> searchMovies(String keyword, {int page = 1}) async {
    final response = await client.get(
      Uri.parse('$baseUrl/films/search?keyword=${Uri.encodeComponent(keyword)}&page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List? ?? [];
      return items.map((e) => MovieSummary.fromJson(e)).toList();
    }
    return [];
  }
}
