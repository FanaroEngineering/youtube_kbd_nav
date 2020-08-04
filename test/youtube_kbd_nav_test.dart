import 'package:html/dom.dart';
import 'package:test/test.dart';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  group('Thumbnail selector', () {
    test('Tests if we extract the correct amount of thumbnails', () {
      final Thumbnails thumbnails = Thumbnails(input: youtubeThumbnailHtml);
      final List<Element> recommendedThumbnails =
          thumbnails.recommendedThumbnails;

      expect(recommendedThumbnails.length, 1);
    });
  });
}

const String youtubeThumbnailHtml = '''
<ytd-rich-item-renderer></ytd-rich-item-renderer>
''';
