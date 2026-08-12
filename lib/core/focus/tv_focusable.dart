import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../ui/core_widgets/focus/focus_scale_wrapper.dart';
import '../../ui/core_widgets/focus/neon_glow_border.dart';

/// Universal Hybrid Focusable Widget for Remote TV D-Pad, Web Keyboard, and Mouse Hover
class TvFocusable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFocusChanged;
  final FocusOnKeyEventCallback? onKeyEvent;
  final bool autoFocus;
  final double borderRadius;
  final FocusNode? focusNode;

  const TvFocusable({
    super.key,
    required this.child,
    this.onTap,
    this.onFocusChanged,
    this.onKeyEvent,
    this.autoFocus = false,
    this.borderRadius = 12.0,
    this.focusNode,
  });

  @override
  State<TvFocusable> createState() => _TvFocusableState();
}

class _TvFocusableState extends State<TvFocusable> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isHovered = false;

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
      if (_focusNode.hasFocus && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _focusNode.hasFocus) {
            try {
              Scrollable.ensureVisible(
                context,
                alignment: 0.5,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            } catch (_) {}
          }
        });
      }
      if (widget.onFocusChanged != null) {
        widget.onFocusChanged!(_focusNode.hasFocus);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final active = _isFocused || _isHovered;

    return Focus(
      focusNode: _focusNode,
      autofocus: widget.autoFocus,
      onKeyEvent: (node, event) {
        if (widget.onKeyEvent != null) {
          final customResult = widget.onKeyEvent!(node, event);
          if (customResult == KeyEventResult.handled) {
            return KeyEventResult.handled;
          }
        }
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
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          if (!_focusNode.hasFocus) {
            _focusNode.requestFocus();
          }
        },
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: FocusScaleWrapper(
            isFocused: active,
            child: NeonGlowBorder(
              isFocused: active,
              borderRadius: widget.borderRadius,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
