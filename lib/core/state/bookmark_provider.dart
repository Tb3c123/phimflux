import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/movie_summary.dart';

/// Provider for bookmarks / favorite movies persistence
class BookmarkProvider extends ChangeNotifier {
  static const String _key = 'phimflux_bookmarks';
  final SharedPreferences? _prefs;
  List<MovieSummary> _bookmarks = [];

  BookmarkProvider({SharedPreferences? prefs}) : _prefs = prefs {
    _loadFromStorage();
  }

  List<MovieSummary> get bookmarks => List.unmodifiable(_bookmarks);

  Future<void> _loadFromStorage() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    final jsonStringList = prefs.getStringList(_key) ?? [];
    _bookmarks = jsonStringList
        .map((str) => MovieSummary.fromJson(json.decode(str)))
        .toList();
    notifyListeners();
  }

  bool isBookmarked(String slug) {
    return _bookmarks.any((item) => item.slug == slug);
  }

  Future<void> toggleBookmark(MovieSummary movie) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    if (isBookmarked(movie.slug)) {
      _bookmarks.removeWhere((item) => item.slug == movie.slug);
    } else {
      _bookmarks.insert(0, movie);
    }

    final jsonStringList = _bookmarks.map((m) => json.encode({
      'name': m.name,
      'slug': m.slug,
      'original_name': m.originalName,
      'thumb_url': m.thumbUrl,
      'poster_url': m.posterUrl,
      'current_episode': m.currentEpisode,
      'quality': m.quality,
      'language': m.language,
      'year': m.year,
    })).toList();

    await prefs.setStringList(_key, jsonStringList);
    notifyListeners();
  }
}
