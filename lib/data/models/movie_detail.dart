import '../services/omdb_service.dart';
import 'episode.dart';

/// Detailed model for full movie information enriched with OMDb genres
class MovieDetail {
  final String name;
  final String slug;
  final String originalName;
  final String thumbUrl;
  final String posterUrl;
  final String description;
  final String currentEpisode;
  final String time;
  final String quality;
  final String language;
  final String director;
  final String casts;
  final String year;
  final String categorySlug;
  final List<String> genres;
  final String imdbRating;
  final List<ServerData> servers;

  MovieDetail({
    required this.name,
    required this.slug,
    required this.originalName,
    required this.thumbUrl,
    required this.posterUrl,
    required this.description,
    required this.currentEpisode,
    required this.time,
    required this.quality,
    required this.language,
    required this.director,
    required this.casts,
    required this.year,
    required this.categorySlug,
    this.genres = const [],
    this.imdbRating = '',
    required this.servers,
  });

  MovieDetail copyWithOmdb(OmdbData omdb) {
    return MovieDetail(
      name: name,
      slug: slug,
      originalName: originalName,
      thumbUrl: thumbUrl,
      posterUrl: posterUrl,
      description: description.isNotEmpty ? description : omdb.plot,
      currentEpisode: currentEpisode,
      time: time,
      quality: quality,
      language: language,
      director: director,
      casts: casts,
      year: year,
      categorySlug: categorySlug,
      genres: omdb.genres.isNotEmpty ? omdb.genres : genres,
      imdbRating: omdb.imdbRating.isNotEmpty ? omdb.imdbRating : imdbRating,
      servers: servers,
    );
  }

  static String _cleanUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';
    var cleaned = url.trim();
    if (cleaned.startsWith('//')) {
      cleaned = 'https:$cleaned';
    } else if (!cleaned.startsWith('http')) {
      if (!cleaned.startsWith('/')) cleaned = '/$cleaned';
      cleaned = 'https://phim.nguonc.com$cleaned';
    }
    return 'https://images.weserv.nl/?url=${Uri.encodeComponent(cleaned)}';
  }

  factory MovieDetail.fromJson(Map<String, dynamic> json, List<ServerData> servers) {
    var movieJson = json['movie'] ?? json;
    final rawThumb = movieJson['thumb_url']?.toString();
    final rawPoster = movieJson['poster_url']?.toString();
    final thumb = _cleanUrl(rawThumb);
    final poster = _cleanUrl(rawPoster).isNotEmpty ? _cleanUrl(rawPoster) : thumb;

    // Parse category slug & genres
    String catSlug = 'phim-le';
    List<String> parsedGenres = [];

    final typeStr = movieJson['type']?.toString().toLowerCase();
    if (typeStr == 'series' || typeStr == 'phim-bo') {
      catSlug = 'phim-bo';
    } else if (typeStr == 'hoathinh' || typeStr == 'hoat-hinh') {
      catSlug = 'hoat-hinh';
    } else if (typeStr == 'tvshows' || typeStr == 'tv-shows') {
      catSlug = 'tv-shows';
    }

    final categoryJson = movieJson['category'];
    if (categoryJson is Map && categoryJson.isNotEmpty) {
      for (var cat in categoryJson.values) {
        if (cat is Map && cat['name'] != null) {
          parsedGenres.add(cat['name'].toString());
        }
      }
    } else if (categoryJson is List) {
      for (var cat in categoryJson) {
        if (cat is Map && cat['name'] != null) {
          parsedGenres.add(cat['name'].toString());
        }
      }
    }

    return MovieDetail(
      name: movieJson['name']?.toString() ?? '',
      slug: movieJson['slug']?.toString() ?? '',
      originalName: movieJson['original_name']?.toString() ?? '',
      thumbUrl: thumb,
      posterUrl: poster,
      description: movieJson['description']?.toString() ?? '',
      currentEpisode: movieJson['current_episode']?.toString() ?? '',
      time: movieJson['time']?.toString() ?? '',
      quality: movieJson['quality']?.toString() ?? 'HD',
      language: movieJson['language']?.toString() ?? 'Vietsub',
      director: movieJson['director']?.toString() ?? 'Đang cập nhật',
      casts: movieJson['casts']?.toString() ?? 'Đang cập nhật',
      year: movieJson['year']?.toString() ?? '',
      categorySlug: catSlug,
      genres: parsedGenres,
      imdbRating: '',
      servers: servers,
    );
  }
}
