import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/movie_summary.dart';
import '../../../data/repositories/movie_repository.dart';
import '../catalog/widgets/movie_grid_view.dart';
import 'widgets/search_input_bar.dart';

/// Search Screen allowing keyword lookup across movies
class SearchScreen extends StatefulWidget {
  final MovieRepository repository;
  final ValueChanged<MovieSummary> onMovieSelect;
  final String? initialQuery;

  const SearchScreen({
    super.key,
    required this.repository,
    required this.onMovieSelect,
    this.initialQuery,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<MovieSummary> _searchResults = [];
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null && widget.initialQuery!.trim().isNotEmpty) {
      _searchController.text = widget.initialQuery!;
      _handleSearch(widget.initialQuery!);
    }
  }

  @override
  void didUpdateWidget(covariant SearchScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQuery != null &&
        widget.initialQuery!.trim().isNotEmpty &&
        widget.initialQuery != oldWidget.initialQuery) {
      _searchController.text = widget.initialQuery!;
      _handleSearch(widget.initialQuery!);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      _isLoading = true;
      _currentQuery = trimmed;
    });

    final results = await widget.repository.searchMovies(trimmed);
    if (mounted) {
      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResults = [];
      _currentQuery = '';
    });
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
              padding: const EdgeInsets.all(16.0),
              child: SearchInputBar(
                controller: _searchController,
                onSubmitted: _handleSearch,
                onClear: _clearSearch,
              ),
            ),
            if (_currentQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Kết quả tìm kiếm cho "$_currentQuery":',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            _isLoading
                ? const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.primaryFocusGlow),
                    ),
                  )
                : _searchResults.isEmpty && _currentQuery.isNotEmpty
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(
                            'Không tìm thấy phim phù hợp',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    : MovieGridView(
                        movies: _searchResults,
                        onMovieTap: widget.onMovieSelect,
                      ),
          ],
        ),
      ),
    );
  }
}
