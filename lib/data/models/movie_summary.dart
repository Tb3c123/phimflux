/// Model representing a movie summary item from NguonC API
class MovieSummary {
  final String name;
  final String slug;
  final String originalName;
  final String thumbUrl;
  final String posterUrl;
  final String currentEpisode;
  final String quality;
  final String language;
  final String year;

  MovieSummary({
    required this.name,
    required this.slug,
    this.originalName = '',
    this.thumbUrl = '',
    this.posterUrl = '',
    this.currentEpisode = '',
    this.quality = 'HD',
    this.language = 'Vietsub',
    this.year = '',
  });

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

  factory MovieSummary.fromJson(Map<String, dynamic> json) {
    final rawThumb = json['thumb_url']?.toString();
    final rawPoster = json['poster_url']?.toString();
    final thumb = _cleanUrl(rawThumb);
    final poster = _cleanUrl(rawPoster).isNotEmpty ? _cleanUrl(rawPoster) : thumb;

    return MovieSummary(
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      originalName: json['original_name']?.toString() ?? '',
      thumbUrl: thumb,
      posterUrl: poster,
      currentEpisode: json['current_episode']?.toString() ?? '',
      quality: json['quality']?.toString() ?? 'HD',
      language: json['language']?.toString() ?? 'Vietsub',
      year: json['year']?.toString() ?? '',
    );
  }
}
