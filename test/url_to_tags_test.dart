import 'package:test/test.dart' show expect, group, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show UrlToTags;

void main() {
  group('URL to Tag Conversion |', () {
    test('Main Page', () {
      final String url = 'https://www.youtube.com/';

      final UrlToTags urlToTags = UrlToTags(url);

      expect(urlToTags.tags, 'ytd-rich-item-renderer');
    });

    test('Watch Page', () {
      final String url = 'https://www.youtube.com/watch';

      final UrlToTags urlToTags = UrlToTags(url);

      expect(urlToTags.tags,
          'ytd-compact-video-renderer, ytd-compact-radio-renderer');
    });

    test('Default Page', () {
      final String url = '';

      final UrlToTags urlToTags = UrlToTags(url);

      expect(urlToTags.tags, 'p');
    });
  });
}
