/// Model representing an episode item in NguonC API
class Episode {
  final String name;
  final String slug;
  final String embed;
  final String m3u8;

  Episode({
    required this.name,
    required this.slug,
    required this.embed,
    required this.m3u8,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      embed: json['embed']?.toString() ?? '',
      m3u8: json['m3u8']?.toString() ?? '',
    );
  }
}

/// Model representing a movie server stream group (e.g. Vietsub / Thuyết minh)
class ServerData {
  final String serverName;
  final List<Episode> episodes;

  ServerData({
    required this.serverName,
    required this.episodes,
  });

  factory ServerData.fromJson(Map<String, dynamic> json) {
    var rawItems = json['items'] as List? ?? [];
    return ServerData(
      serverName: json['server_name']?.toString() ?? 'Server 1',
      episodes: rawItems.map((e) => Episode.fromJson(e)).toList(),
    );
  }
}
