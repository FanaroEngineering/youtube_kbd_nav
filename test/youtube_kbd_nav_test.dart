import 'dart:html';

import 'package:test/test.dart';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  group('Thumbnails |', () {
    document.body.append(ParagraphElement());
    document.body.append(ParagraphElement());

    YoutubeMainPage youtubeMainPage;

    setUp(() => youtubeMainPage = YoutubeMainPage(input: document, tag: 'p'));

    test('Puts border on the first thumbnail', () {
      youtubeMainPage.addBorderToNext();

      final String newStyle = document.querySelector('p').attributes['style'];

      expect(newStyle, isNotNull);
    });

    test(
        'Putting a border on the second thumbnail deletes the border on the '
        'first', () {
      youtubeMainPage.addBorderToNext();
      youtubeMainPage.addBorderToNext();

      final List<Element> thumbnails = document.querySelectorAll('p');
      final Element firstThumbnail = thumbnails.first;
      final Element secondThumbnail = thumbnails.last;

      expect(firstThumbnail.attributes['style'], isNull);
      expect(secondThumbnail.attributes['style'], isNotNull);
    });
  });
}

class YtdRichItemRenderer extends HtmlElement {
  static const String tag = 'ytd-rich-item-renderer';

  factory YtdRichItemRenderer() => Element.tag(tag);

  YtdRichItemRenderer.created() : super.created();
}
