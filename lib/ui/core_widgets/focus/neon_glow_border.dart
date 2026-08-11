import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Container that applies a Neon Cyan glow and border when focused
class NeonGlowBorder extends StatelessWidget {
  final Widget child;
  final bool isFocused;
  final double borderRadius;

  const NeonGlowBorder({
    super.key,
    required this.child,
    required this.isFocused,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isFocused ? AppColors.primaryFocusGlow : Colors.transparent,
          width: isFocused ? 2.5 : 0,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: AppColors.primaryFocusGlow.withOpacity(0.6),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: child,
    );
  }
}
