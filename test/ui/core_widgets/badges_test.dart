import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phimflux/ui/core_widgets/badges/language_tag_badge.dart';
import 'package:phimflux/ui/core_widgets/badges/quality_tag_badge.dart';
import 'package:phimflux/ui/core_widgets/badges/rating_star_item.dart';
import 'package:phimflux/ui/core_widgets/buttons/primary_play_button.dart';

void main() {
  testWidgets('QualityTagBadge renders text correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: QualityTagBadge(quality: '4K'),
        ),
      ),
    );
    expect(find.text('4K'), findsOneWidget);
  });

  testWidgets('LanguageTagBadge renders text correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LanguageTagBadge(language: 'Vietsub'),
        ),
      ),
    );
    expect(find.text('Vietsub'), findsOneWidget);
  });

  testWidgets('RatingStarItem renders rating number', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RatingStarItem(rating: 8.5),
        ),
      ),
    );
    expect(find.text('8.5'), findsOneWidget);
  });

  testWidgets('PrimaryPlayButton reacts to tap', (tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryPlayButton(
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('XEM NGAY'));
    expect(tapped, isTrue);
  });
}
