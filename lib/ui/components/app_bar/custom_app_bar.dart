import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Top application bar with transparent gradient background
class CustomAppBar extends StatefulWidget {
  final String title;
  final ValueChanged<String>? onSearchSubmit;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onSearchSubmit,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.85),
            Colors.black.withOpacity(0.0),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.play_circle_fill_rounded, color: AppColors.primaryFocusGlow, size: 28),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          if (widget.onSearchSubmit != null)
            SizedBox(
              width: 240,
              height: 38,
              child: TextField(
                controller: _searchController,
                onSubmitted: widget.onSearchSubmit,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Tìm phim...',
                  hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primaryFocusGlow, size: 18),
                  filled: true,
                  fillColor: AppColors.cardBackground.withOpacity(0.8),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
