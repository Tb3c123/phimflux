import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/movie_summary.dart';
import 'hero_backdrop_image.dart';
import 'hero_title_info.dart';

/// Interactive Multi-Movie Hero Banner Slider optimized for Smart TV & Mobile
class HeroBannerSlider extends StatefulWidget {
  final List<MovieSummary> movies;
  final ValueChanged<MovieSummary> onMovieTap;

  const HeroBannerSlider({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  @override
  State<HeroBannerSlider> createState() => _HeroBannerSliderState();
}

class _HeroBannerSliderState extends State<HeroBannerSlider> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (widget.movies.isEmpty || !mounted) return;
      final nextPage = (_currentPage + 1) % widget.movies.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 360,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (idx) {
              setState(() => _currentPage = idx);
            },
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return Stack(
                children: [
                  HeroBackdropImage(imageUrl: movie.posterUrl),
                  Positioned(
                    left: 32,
                    bottom: 24,
                    right: 32,
                    child: HeroTitleInfo(
                      title: movie.name,
                      quality: movie.quality,
                      language: movie.language,
                      year: movie.year,
                      onPlayTap: () => widget.onMovieTap(movie),
                    ),
                  ),
                ],
              );
            },
          ),
          // Page Indicator Dots
          Positioned(
            right: 32,
            bottom: 16,
            child: Row(
              children: List.generate(
                widget.movies.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.primaryFocusGlow
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
