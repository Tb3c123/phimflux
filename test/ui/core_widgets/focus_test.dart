import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phimflux/core/theme/app_colors.dart';
import 'package:phimflux/ui/core_widgets/focus/neon_glow_border.dart';
import 'package:phimflux/ui/core_widgets/focus/tv_focusable_wrapper.dart';

void main() {
  testWidgets('NeonGlowBorder displays cyan glow when isFocused is true', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: NeonGlowBorder(
            isFocused: true,
            child: Text('Focus Test'),
          ),
        ),
      ),
    );

    final containerFinder = find.byType(AnimatedContainer);
    expect(containerFinder, findsOneWidget);

    final container = tester.widget<AnimatedContainer>(containerFinder);
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.border?.top.color, AppColors.primaryFocusGlow);
    expect(decoration.boxShadow, isNotNull);
  });

  testWidgets('TvFocusableWrapper triggers onTap on tap gesture', (tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TvFocusableWrapper(
            onTap: () => tapped = true,
            child: const Text('Clickable Item'),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Clickable Item'));
    expect(tapped, isTrue);
  });
}
