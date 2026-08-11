import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'focus_scale_wrapper.dart';
import 'neon_glow_border.dart';

/// Wraps any widget to make it focusable by D-Pad Remote & touch tap with auto-scroll support
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

  void _handleFocusChange(bool focused) {
    setState(() => _isFocused = focused);
    if (focused) {
      // Auto scroll viewport when TV Remote D-Pad focuses this element
      Scrollable.ensureVisible(
        context,
        alignment: 0.2,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
    if (widget.onFocusChanged != null) {
      widget.onFocusChanged!(focused);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.autoFocus,
      onFocusChange: _handleFocusChange,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final key = event.logicalKey;
          // Support all Android TV Remote D-Pad Center / OK keys (0x00070058 is DPAD_CENTER / Select)
          if (key == LogicalKeyboardKey.select ||
              key == LogicalKeyboardKey.enter ||
              key == LogicalKeyboardKey.numpadEnter ||
              key == LogicalKeyboardKey.gameButtonA ||
              key == LogicalKeyboardKey.space ||
              key.keyId == 0x00070058) {
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
