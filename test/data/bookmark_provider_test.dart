import 'package:flutter_test/flutter_test.dart';
import 'package:phimflux/core/state/bookmark_provider.dart';
import 'package:phimflux/data/models/movie_summary.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('BookmarkProvider toggles movie bookmark state', () async {
    SharedPreferences.setMockInitialValues({});
    final provider = BookmarkProvider();

    final testMovie = MovieSummary(
      name: 'Test Movie',
      slug: 'test-movie',
      originalName: 'Original Test Movie',
      thumbUrl: '',
      posterUrl: '',
      currentEpisode: 'Tập 1',
      quality: 'HD',
      language: 'Vietsub',
      year: '2026',
    );

    expect(provider.isBookmarked('test-movie'), isFalse);
    await provider.toggleBookmark(testMovie);
    expect(provider.isBookmarked('test-movie'), isTrue);
    await provider.toggleBookmark(testMovie);
    expect(provider.isBookmarked('test-movie'), isFalse);
  });
}
