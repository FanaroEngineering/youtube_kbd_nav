import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:test/test.dart';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  group('Thumbnails |', () {
    final Document youtubeThumbnailHtml = parse(youtubeThumbnailHtmlString);
    YoutubeMainPage youtubeMainPage;

    setUp(() => youtubeMainPage = YoutubeMainPage(input: youtubeThumbnailHtml));

    test('Puts border on the first thumbnail', () {
      youtubeMainPage.addBorderToNext();

      final String newStyle = youtubeThumbnailHtml
          .querySelector('ytd-rich-item-renderer')
          .attributes['style'];

      expect(newStyle, isNotNull);
    });

    test(
        'Putting a border on the second thumbnail deletes the border on the '
        'first', () {
      youtubeMainPage.addBorderToNext();
      youtubeMainPage.addBorderToNext();

      final List<Element> thumbnails =
          youtubeThumbnailHtml.querySelectorAll('ytd-rich-item-renderer');
      final Element firstThumbnail = thumbnails.first;
      final Element secondThumbnail = thumbnails.last;

      expect(firstThumbnail.attributes['style'], isNull);
      expect(secondThumbnail.attributes['style'], isNotNull);
    });
  });
}

const String youtubeThumbnailHtmlString = '''
<ytd-rich-item-renderer></ytd-rich-item-renderer>
<ytd-rich-item-renderer></ytd-rich-item-renderer>
''';
