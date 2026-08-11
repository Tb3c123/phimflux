import 'package:flutter_test/flutter_test.dart';
import 'package:phimflux/core/state/history_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('HistoryProvider saves and retrieves watch history position', () async {
    SharedPreferences.setMockInitialValues({});
    final provider = HistoryProvider();

    final historyItem = HistoryItem(
      movieSlug: 'movie-1',
      movieName: 'Movie One',
      episodeSlug: 'ep-1',
      episodeName: 'Tập 1',
      positionSeconds: 2060, // 34m 20s
    );

    await provider.saveHistory(historyItem);
    final saved = provider.getHistoryForMovie('movie-1');

    expect(saved, isNotNull);
    expect(saved!.positionSeconds, 2060);
    expect(saved.episodeName, 'Tập 1');
  });
}
