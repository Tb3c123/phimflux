import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/movie_summary.dart';
import '../../../data/repositories/movie_repository.dart';
import 'widgets/hero_banner_slider.dart';
import 'widgets/horizontal_movie_list.dart';

/// Full Home Screen with multi-movie Hero Banner Slider & non-overlapping lists
class HomeScreen extends StatefulWidget {
  final MovieRepository repository;
  final ValueChanged<MovieSummary> onMovieSelect;

  const HomeScreen({
    super.key,
    required this.repository,
    required this.onMovieSelect,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  List<MovieSummary> _bannerMovies = [];
  List<MovieSummary> _latestMovies = [];
  List<MovieSummary> _singleMovies = [];
  List<MovieSummary> _seriesMovies = [];

  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    setState(() => _isLoading = true);

    final results = await Future.wait([
      widget.repository.getLatestMovies(page: 1),
      widget.repository.getSingleMovies(page: 1),
      widget.repository.getSeriesMovies(page: 1),
      widget.repository.getLatestMovies(page: 2),
    ]);

    final allFetched = <MovieSummary>[];
    for (var list in results) {
      allFetched.addAll(list);
    }

    final Map<String, MovieSummary> uniqueMap = {};
    for (var m in allFetched) {
      uniqueMap[m.slug] = m;
    }

    final pool = uniqueMap.values.toList()..shuffle();

    final bannerList = pool.take(5).toList();
    final usedSlugs = bannerList.map((m) => m.slug).toSet();

    final remainingPool = pool.where((m) => !usedSlugs.contains(m.slug)).toList();

    final latestList = <MovieSummary>[];
    final singleList = <MovieSummary>[];
    final seriesList = <MovieSummary>[];

    for (var m in remainingPool) {
      if (latestList.length < 10) {
        latestList.add(m);
        usedSlugs.add(m.slug);
      } else if (singleList.length < 10) {
        singleList.add(m);
        usedSlugs.add(m.slug);
      } else if (seriesList.length < 10) {
        seriesList.add(m);
        usedSlugs.add(m.slug);
      }
    }

    if (mounted) {
      setState(() {
        _bannerMovies = bannerList;
        _latestMovies = latestList;
        _singleMovies = singleList;
        _seriesMovies = seriesList;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryFocusGlow),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_bannerMovies.isNotEmpty)
            HeroBannerSlider(
              movies: _bannerMovies,
              onMovieTap: widget.onMovieSelect,
            ),
          const SizedBox(height: 16),
          HorizontalMovieList(
            title: '🔥 Phim Mới Cập Nhật',
            movies: _latestMovies,
            isLoading: false,
            onMovieTap: widget.onMovieSelect,
          ),
          const SizedBox(height: 16),
          HorizontalMovieList(
            title: '🎬 Phim Lẻ Đặc Sắc',
            movies: _singleMovies,
            isLoading: false,
            onMovieTap: widget.onMovieSelect,
          ),
          const SizedBox(height: 16),
          HorizontalMovieList(
            title: '📺 Phim Bộ Nổi Bật',
            movies: _seriesMovies,
            isLoading: false,
            onMovieTap: widget.onMovieSelect,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
