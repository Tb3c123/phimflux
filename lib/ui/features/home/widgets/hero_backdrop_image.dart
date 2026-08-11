import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Blurred backdrop poster background for Giant Hero section (Height 520px)
class HeroBackdropImage extends StatelessWidget {
  final String imageUrl;

  const HeroBackdropImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (imageUrl.isNotEmpty)
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 520,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(height: 520, color: AppColors.darkBackground),
          )
        else
          Container(height: 520, color: AppColors.darkBackground),
        Container(
          height: 520,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                AppColors.darkBackground.withOpacity(0.4),
                AppColors.darkBackground,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
