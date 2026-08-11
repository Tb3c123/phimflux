import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/movie_detail.dart';
import '../../../data/models/movie_summary.dart';
import '../../../data/repositories/movie_repository.dart';
import '../home/widgets/hero_backdrop_image.dart';
import '../home/widgets/horizontal_movie_list.dart';
import 'widgets/detail_header_info.dart';
import 'widgets/episode_grid_section.dart';

/// Fullscreen Movie Detail Screen with IMDb metadata & recommended movies
class DetailScreen extends StatefulWidget {
  final String movieSlug;
  final MovieRepository repository;
  final Function(MovieDetail detail, dynamic episode) onPlayEpisode;
  final ValueChanged<String> onMovieSelect;
  final VoidCallback onBack;

  const DetailScreen({
    super.key,
    required this.movieSlug,
    required this.repository,
    required this.onPlayEpisode,
    required this.onMovieSelect,
    required this.onBack,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = true;
  bool _isLoadingRecommended = true;
  MovieDetail? _movieDetail;
  List<MovieSummary> _recommendedMovies = [];
  int _selectedServerIndex = 0;
  int _selectedEpisodeIndex = 0;
  bool _isBookmarked = false;
  final FocusNode _playButtonFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fetchDetail();
  }

  @override
  void dispose() {
    _playButtonFocusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movieSlug != widget.movieSlug) {
      _fetchDetail();
    }
  }

  Future<void> _fetchDetail() async {
    setState(() {
      _isLoading = true;
      _isLoadingRecommended = true;
    });

    final detail = await widget.repository.getMovieDetail(widget.movieSlug);
    if (mounted) {
      setState(() {
        _movieDetail = detail;
        _isLoading = false;
      });

      // Automatically request focus on XEM TẬP 1 button when Detail Screen loads
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _playButtonFocusNode.canRequestFocus) {
          _playButtonFocusNode.requestFocus();
        }
      });

      if (detail != null) {
        _fetchRecommendedMovies(detail);
      }
    }
  }

  Future<void> _fetchRecommendedMovies(MovieDetail detail) async {
    List<MovieSummary> list = await widget.repository.getMoviesByCategory(detail.categorySlug);

    if (detail.genres.isNotEmpty) {
      final mainGenre = detail.genres.first;
      final searched = await widget.repository.searchMovies(mainGenre);
      if (searched.length >= 3) {
        list.addAll(searched);
      }
    }

    if (list.isEmpty) {
      list = await widget.repository.getLatestMovies();
    }

    final Map<String, MovieSummary> uniqueMap = {};
    for (var m in list) {
      if (m.slug != widget.movieSlug) {
        uniqueMap[m.slug] = m;
      }
    }

    final filtered = uniqueMap.values.toList()..shuffle();

    if (mounted) {
      setState(() {
        _recommendedMovies = filtered;
        _isLoadingRecommended = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recommendationTitle = _movieDetail != null && _movieDetail!.genres.isNotEmpty
        ? '🔥 Phim Thể Loại ${_movieDetail!.genres.first} Đề Xuất'
        : '🔥 Phim Đề Xuất Cùng Thể Loại';

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: widget.onBack,
        ),
        title: Text(
          _movieDetail?.name ?? 'Chi Tiết Phim',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryFocusGlow),
            )
          : _movieDetail == null
              ? const Center(
                  child: Text('Không tìm thấy chi tiết phim',
                      style: TextStyle(color: AppColors.textSecondary)),
                )
              : Stack(
                  children: [
                    HeroBackdropImage(
                      imageUrl: _movieDetail!.posterUrl.isNotEmpty
                          ? _movieDetail!.posterUrl
                          : _movieDetail!.thumbUrl,
                    ),
                    ListView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      children: [
                        DetailHeaderInfo(
                          detail: _movieDetail!,
                          isBookmarked: _isBookmarked,
                          playButtonFocusNode: _playButtonFocusNode,
                          onBookmarkTap: () {
                            setState(() => _isBookmarked = !_isBookmarked);
                          },
                          onPlayFirstEpisode: () {
                            if (_movieDetail!.servers.isNotEmpty &&
                                _movieDetail!.servers.first.episodes.isNotEmpty) {
                              widget.onPlayEpisode(
                                _movieDetail!,
                                _movieDetail!.servers.first.episodes.first,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        EpisodeGridSection(
                          servers: _movieDetail!.servers,
                          selectedServerIndex: _selectedServerIndex,
                          selectedEpisodeIndex: _selectedEpisodeIndex,
                          onServerSelected: (idx) {
                            setState(() {
                              _selectedServerIndex = idx;
                              _selectedEpisodeIndex = 0;
                            });
                          },
                          onEpisodeSelected: (idx) {
                            setState(() => _selectedEpisodeIndex = idx);
                            final ep = _movieDetail!
                                .servers[_selectedServerIndex]
                                .episodes[idx];
                            widget.onPlayEpisode(_movieDetail!, ep);
                          },
                        ),
                        const SizedBox(height: 32),
                        HorizontalMovieList(
                          title: recommendationTitle,
                          movies: _recommendedMovies,
                          isLoading: _isLoadingRecommended,
                          onMovieTap: (m) => widget.onMovieSelect(m.slug),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}
