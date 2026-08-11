import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'focus_scale_wrapper.dart';
import 'neon_glow_border.dart';

/// Wraps any widget to make it focusable by D-Pad Remote & touch tap
class TvFocusableWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFocusChanged;
  final bool autoFocus;
  final double borderRadius;

  const TvFocusableWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.onFocusChanged,
    this.autoFocus = false,
    this.borderRadius = 12.0,
  });

  @override
  State<TvFocusableWrapper> createState() => _TvFocusableWrapperState();
}

class _TvFocusableWrapperState extends State<TvFocusableWrapper> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.autoFocus,
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
        if (widget.onFocusChanged != null) {
          widget.onFocusChanged!(focused);
        }
      },
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.gameButtonA) {
            widget.onTap?.call();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: FocusScaleWrapper(
          isFocused: _isFocused,
          child: NeonGlowBorder(
            isFocused: _isFocused,
            borderRadius: widget.borderRadius,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
