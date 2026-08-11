import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Item recording watch history position
class HistoryItem {
  final String movieSlug;
  final String movieName;
  final String episodeSlug;
  final String episodeName;
  final int positionSeconds;

  HistoryItem({
    required this.movieSlug,
    required this.movieName,
    required this.episodeSlug,
    required this.episodeName,
    required this.positionSeconds,
  });

  Map<String, dynamic> toJson() => {
        'movieSlug': movieSlug,
        'movieName': movieName,
        'episodeSlug': episodeSlug,
        'episodeName': episodeName,
        'positionSeconds': positionSeconds,
      };

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
        movieSlug: json['movieSlug'] ?? '',
        movieName: json['movieName'] ?? '',
        episodeSlug: json['episodeSlug'] ?? '',
        episodeName: json['episodeName'] ?? '',
        positionSeconds: json['positionSeconds'] ?? 0,
      );
}

/// Provider for managing watch history persistence
class HistoryProvider extends ChangeNotifier {
  static const String _key = 'phimflux_history';
  final SharedPreferences? _prefs;
  List<HistoryItem> _history = [];

  HistoryProvider({SharedPreferences? prefs}) : _prefs = prefs {
    _loadFromStorage();
  }

  List<HistoryItem> get history => List.unmodifiable(_history);

  Future<void> _loadFromStorage() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    _history = jsonList.map((s) => HistoryItem.fromJson(json.decode(s))).toList();
    notifyListeners();
  }

  Future<void> saveHistory(HistoryItem item) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _history.removeWhere((h) => h.movieSlug == item.movieSlug);
    _history.insert(0, item);

    final jsonList = _history.map((h) => json.encode(h.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
    notifyListeners();
  }

  HistoryItem? getHistoryForMovie(String movieSlug) {
    try {
      return _history.firstWhere((h) => h.movieSlug == movieSlug);
    } catch (_) {
      return null;
    }
  }
}
