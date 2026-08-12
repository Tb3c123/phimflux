import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/state/bookmark_provider.dart';
import 'core/state/history_provider.dart';
import 'core/theme/app_colors.dart';
import 'data/models/episode.dart';
import 'data/models/movie_detail.dart';
import 'data/repositories/movie_repository.dart';
import 'data/services/api_service.dart';

import 'ui/components/app_bar/custom_app_bar.dart';
import 'ui/components/sidebar/tv_sidebar_menu.dart';
import 'ui/features/catalog/catalog_screen.dart';
import 'ui/features/detail/detail_screen.dart';
import 'ui/features/home/home_screen.dart';
import 'ui/features/library/library_screen.dart';
import 'ui/features/player/player_screen.dart';
import 'ui/features/search/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const PhimFluxApp(),
    ),
  );
}

class PhimFluxApp extends StatelessWidget {
  const PhimFluxApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final repository = MovieRepository(apiService: apiService);

    return MaterialApp(
      title: 'PhimFlux',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        primaryColor: AppColors.primaryFocusGlow,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryFocusGlow,
          surface: AppColors.cardBackground,
        ),
      ),
      home: MainNavigationFrame(repository: repository),
    );
  }
}

class MainNavigationFrame extends StatefulWidget {
  final MovieRepository repository;

  const MainNavigationFrame({super.key, required this.repository});

  @override
  State<MainNavigationFrame> createState() => _MainNavigationFrameState();
}

class _MainNavigationFrameState extends State<MainNavigationFrame> {
  int _selectedNavIndex = 0; // 0: Home, 1: Catalog, 2: Library, 3: Search
  String? _selectedMovieSlug;
  MovieDetail? _playingMovieDetail;
  Episode? _playingEpisode;
  String? _searchQuery;

  void _openMovieDetail(String slug) {
    setState(() {
      _selectedMovieSlug = slug;
    });
  }

  void _startPlayback(MovieDetail detail, Episode episode) {
    setState(() {
      _playingMovieDetail = detail;
      _playingEpisode = episode;
    });
  }

  void _closePlayback() {
    setState(() {
      _playingMovieDetail = null;
      _playingEpisode = null;
    });
  }

  void _closeDetail() {
    setState(() {
      _selectedMovieSlug = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Fullscreen Player Mode
    if (_playingMovieDetail != null && _playingEpisode != null) {
      return PlayerScreen(
        movieTitle: _playingMovieDetail!.name,
        episodeName: _playingEpisode!.name,
        videoUrl: _playingEpisode!.m3u8,
        embedUrl: _playingEpisode!.embed,
        onBack: _closePlayback,
      );
    }

    // 2. Fullscreen Detail Mode
    if (_selectedMovieSlug != null) {
      return DetailScreen(
        movieSlug: _selectedMovieSlug!,
        repository: widget.repository,
        onPlayEpisode: (detail, ep) {
          _startPlayback(detail, ep);
        },
        onMovieSelect: (slug) {
          _openMovieDetail(slug);
        },
        onBack: _closeDetail,
      );
    }

    // 3. Main Navigation Layout with 2D Spatial Focus Policy
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: FocusTraversalGroup(
        policy: ReadingOrderTraversalPolicy(),
        child: Row(
          children: [
            TvSidebarMenu(
              selectedIndex: _selectedNavIndex,
              onItemSelected: (idx) {
                setState(() => _selectedNavIndex = idx);
              },
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: IndexedStack(
                      index: _selectedNavIndex,
                      children: [
                        HomeScreen(
                          repository: widget.repository,
                          onMovieSelect: (movie) => _openMovieDetail(movie.slug),
                        ),
                        CatalogScreen(
                          repository: widget.repository,
                          onMovieSelect: (movie) => _openMovieDetail(movie.slug),
                        ),
                        const LibraryScreen(),
                        SearchScreen(
                          repository: widget.repository,
                          initialQuery: _searchQuery,
                          onMovieSelect: (movie) => _openMovieDetail(movie.slug),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomAppBar(
                      title: 'PhimFlux',
                      onSearchSubmit: (query) {
                        setState(() {
                          _searchQuery = query;
                          _selectedNavIndex = 3;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
