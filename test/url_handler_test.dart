import 'package:test/test.dart' show expect, group, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show UrlHandler;

void main() {
  group('URL to Tag Conversion |', () {
    test('Main Page', () {
      final String url = 'https://www.youtube.com/';

      final String tags = UrlHandler.tags(url);

      expect(tags, 'ytd-rich-item-renderer');
    });

    test('Watch Page', () {
      final String url = 'https://www.youtube.com/watch';

      final String tags = UrlHandler.tags(url);

      expect(
          tags,
          'ytd-compact-video-renderer, '
          'ytd-compact-radio-renderer, '
          'ytd-compact-playlist-renderer');
    });

    test('Search Results Page', () {
      final String url = 'https://www.youtube.com/results?search';

      final String tags = UrlHandler.tags(url);

      expect(
          tags,
          'ytd-video-renderer, '
          'ytd-radio-renderer, '
          'ytd-playlist-renderer, '
          'ytd-channel-renderer');
    });

    test('Default Page', () {
      final String url = '';

      final String tags = UrlHandler.tags(url);

      expect(tags, 'p');
    });
  });

  group('Link Handling |', () {
    test('Prefix a link if it has only the ending', () {
      final String link = '/watch?v=lajd;slf';

      final String completeLink = UrlHandler.prefixedLink(link);

      expect(completeLink, 'https://www.youtube.com' + link);
    });
  });
}
