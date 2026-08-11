import 'package:flutter/material.dart';

/// Applies a 1.05x scale factor animation when focused
class FocusScaleWrapper extends StatelessWidget {
  final Widget child;
  final bool isFocused;
  final double scaleFactor;

  const FocusScaleWrapper({
    super.key,
    required this.child,
    required this.isFocused,
    this.scaleFactor = 1.05,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isFocused ? scaleFactor : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      child: child,
    );
  }
}
