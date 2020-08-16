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

    test('Default Page', () {
      final String url = '';

      final String tags = UrlHandler.tags(url);

      expect(tags, 'p');
    });
  });
}
