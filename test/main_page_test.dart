import 'dart:html';

import 'package:test/test.dart';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  group('Main Page Thumbnails Navigation |', () {
    document.body.append(ParagraphElement());
    document.body.append(ParagraphElement());

    MainPage youtubeMainPage;

    setUp(() => youtubeMainPage = MainPage(input: document, tag: 'p'));

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

    group('Action on Thumbnail |', () {
      final String correctUrl = 'https://hello.com';

      document.body.append(DivElement());
      document.body.querySelector('div').append(DivElement());
      document.body
          .querySelector('div > div')
          .append(AnchorElement()..href = correctUrl);

      MainPage youtubeMainPage;

      setUp(() {
        youtubeMainPage = MainPage(input: document, tag: 'div');
      });

      test('Extracts the link to the thumbnail', () {
        youtubeMainPage.addBorderToNext();

        final String extractedLink = youtubeMainPage.currentThumbnailLink;

        expect(extractedLink, correctUrl);
      });
    });
  });
}
