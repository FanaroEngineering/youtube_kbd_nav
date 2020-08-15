import 'dart:html' show document, Element, ParagraphElement;

import 'package:test/test.dart' show expect, group, isNull, setUpAll, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Ui;

void main() {
  group('Thumbnail |', () {
    setUpAll(() {
      for (int i = 0; i < 2; i++) {
        document.body.append(ParagraphElement());
      }
    });

    final String expectedThumbnailStyling =
        'outline: red solid; outline-offset: -1px;';

    test('Adds border to the thumbnail', () {
      final Ui ui = Ui(tags: 'p');
      ui.addBorder(currentIndex: 0);

      final String newStyle = document.querySelector('p').attributes['style'];

      expect(newStyle, expectedThumbnailStyling);
    });

    test(
        'Adding a border to the current thumbnail deletes the styling on its '
        'neighbors', () {
      final Ui ui = Ui(tags: 'p');
      ui.addBorder(currentIndex: 1);

      final List<Element> thumbnails = document.querySelectorAll('p');
      final String thumbnail0Style = thumbnails[0].attributes['style'];
      final String thumbnail1Style = thumbnails[1].attributes['style'];

      expect(thumbnail0Style, isNull);
      expect(thumbnail1Style, expectedThumbnailStyling);
    });
  });
}
