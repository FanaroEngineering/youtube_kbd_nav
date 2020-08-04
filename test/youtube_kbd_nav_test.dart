import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  final Document youtubeThumbnailHtml = parse(youtubeThumbnailHtmlString);

  group('Thumbnails', () {
    test('Puts border on the first thumbnail', () {
      final YoutubeMainPage youtubeMainPage =
          YoutubeMainPage(input: youtubeThumbnailHtml);

      youtubeMainPage.addBorderToNext();

      final String newStyle = youtubeThumbnailHtml
          .querySelector('ytd-rich-item-renderer')
          .attributes['style'];

      expect(newStyle, isNotNull);
    });
  });
}

const String youtubeThumbnailHtmlString = '''
<ytd-rich-item-renderer></ytd-rich-item-renderer>
''';
