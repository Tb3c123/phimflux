import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/movie_summary.dart';
import '../../../data/repositories/movie_repository.dart';
import '../../components/pagination/pagination_bar.dart';
import 'widgets/filter_chip_group.dart';
import 'widgets/movie_grid_view.dart';

/// Full Catalog Screen with category filtering & pagination
class CatalogScreen extends StatefulWidget {
  final MovieRepository repository;
  final ValueChanged<MovieSummary> onMovieSelect;

  const CatalogScreen({
    super.key,
    required this.repository,
    required this.onMovieSelect,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _selectedSlug = 'phim-le';
  int _currentPage = 1;
  bool _isLoading = true;
  List<MovieSummary> _movies = [];

  final List<Map<String, String>> _categories = const [
    {'label': 'Phim Lẻ', 'slug': 'phim-le'},
    {'label': 'Phim Bộ', 'slug': 'phim-bo'},
    {'label': 'Hoạt Hình', 'slug': 'hoat-hinh'},
    {'label': 'TV Shows', 'slug': 'tv-shows'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchCategoryData();
  }

  Future<void> _fetchCategoryData() async {
    setState(() => _isLoading = true);
    final movies = await widget.repository.getMoviesByCategory(_selectedSlug, page: _currentPage);
    if (mounted) {
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    }
  }

  void _onCategoryChanged(String slug) {
    if (_selectedSlug != slug) {
      setState(() {
        _selectedSlug = slug;
        _currentPage = 1;
      });
      _fetchCategoryData();
    }
  }

  void _onPageChanged(int page) {
    if (_currentPage != page) {
      setState(() => _currentPage = page);
      _fetchCategoryData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 65, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FilterChipGroup(
                filters: _categories,
                selectedSlug: _selectedSlug,
                onSelected: _onCategoryChanged,
              ),
            ),
            const SizedBox(height: 12),
            _isLoading
                ? const SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.primaryFocusGlow),
                    ),
                  )
                : MovieGridView(
                    movies: _movies,
                    onMovieTap: widget.onMovieSelect,
                  ),
            const SizedBox(height: 16),
            PaginationBar(
              currentPage: _currentPage,
              onPageChanged: _onPageChanged,
            ),
          ],
        ),
      ),
    );
  }
}
