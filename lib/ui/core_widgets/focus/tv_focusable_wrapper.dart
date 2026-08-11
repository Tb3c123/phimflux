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
  final FocusNode? focusNode;

  const TvFocusableWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.onFocusChanged,
    this.autoFocus = false,
    this.borderRadius = 12.0,
    this.focusNode,
  });

  @override
  State<TvFocusableWrapper> createState() => _TvFocusableWrapperState();
}

class _TvFocusableWrapperState extends State<TvFocusableWrapper> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusListener);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusListener);
    }
    super.dispose();
  }

  void _onFocusListener() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() => _isFocused = _focusNode.hasFocus);
      if (_focusNode.hasFocus) {
        Scrollable.ensureVisible(
          context,
          alignment: 0.2,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      }
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged!(_focusNode.hasFocus);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: widget.autoFocus,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          final key = event.logicalKey;
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
