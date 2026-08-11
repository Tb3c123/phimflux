import 'dart:convert';
import 'package:http/http.dart' as http;

/// OMDb metadata object
class OmdbData {
  final List<String> genres;
  final String imdbRating;
  final String plot;
  final String rated;

  OmdbData({
    required this.genres,
    required this.imdbRating,
    required this.plot,
    required this.rated,
  });

  factory OmdbData.fromJson(Map<String, dynamic> json) {
    final rawGenre = json['Genre']?.toString() ?? '';
    final genreList = rawGenre
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && e != 'N/A')
        .toList();

    return OmdbData(
      genres: genreList,
      imdbRating: json['imdbRating']?.toString() ?? '',
      plot: json['Plot']?.toString() ?? '',
      rated: json['Rated']?.toString() ?? '',
    );
  }
}

/// Service fetching detailed movie genres and ratings from OMDb API
class OmdbService {
  static const String _apiKey = 'trilogy';
  final http.Client client;

  OmdbService({http.Client? client}) : client = client ?? http.Client();

  /// Search OMDb metadata by movie title
  Future<OmdbData?> fetchMovieMetadata(String title) async {
    if (title.trim().isEmpty) return null;
    final cleanedTitle = _cleanTitle(title);
    if (cleanedTitle.isEmpty) return null;

    try {
      final uri = Uri.parse('https://www.omdbapi.com/?t=${Uri.encodeComponent(cleanedTitle)}&apikey=$_apiKey');
      final response = await client.get(uri).timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['Response'] == 'True') {
          return OmdbData.fromJson(data);
        }
      }
    } catch (_) {
      // Gracefully handle network timeouts or API limits
    }
    return null;
  }

  static String _cleanTitle(String rawTitle) {
    // Remove Vietnamese accents or year parentheses if present
    var clean = rawTitle.replaceAll(RegExp(r'\(\d{4}\)'), '').trim();
    return clean;
  }
}
