import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Cached image with loading indicator & 404 fallback placeholder
class MoviePosterImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  const MoviePosterImage({
    super.key,
    required this.imageUrl,
    this.width = 140,
    this.height = 200,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: width,
                  height: height,
                  color: AppColors.cardBackground,
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryFocusGlow,
                      ),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
            )
          : _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: AppColors.cardBackground,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.movie_rounded, size: 40, color: AppColors.textSecondary),
          SizedBox(height: 8),
          Text(
            'PhimFlux',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
