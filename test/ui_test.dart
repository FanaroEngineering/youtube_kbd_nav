import 'dart:html'
    show
        AnchorElement,
        ButtonElement,
        document,
        Element,
        Event,
        ParagraphElement;

import 'package:test/test.dart'
    show expect, group, isNull, setUp, setUpAll, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Ui;

void main() {
  group('Thumbnail |', () {
    final String exampleSite = 'https://example.com/';

    setUpAll(() {
      for (int i = 0; i < 2; i++) document.body.append(ParagraphElement());

      final ParagraphElement paragraphWithLink = ParagraphElement();
      paragraphWithLink.append(AnchorElement(href: exampleSite));

      document.body.append(paragraphWithLink);
    });

    final String expectedThumbnailStyling =
        'outline: red solid; outline-offset: -1px;';

    Ui ui;

    setUp(() => ui = Ui(tags: 'p'));

    test('Adds border to the thumbnail', () {
      ui.addBorder(currentIndex: 0);

      final String newStyle = document.querySelector('p').attributes['style'];

      expect(newStyle, expectedThumbnailStyling);
    });

    test(
        'Adding a border to the current thumbnail deletes the styling on its '
        'neighbors', () {
      ui.addBorder(currentIndex: 1);

      final List<Element> thumbnails = document.querySelectorAll('p');
      final String thumbnail0Style = thumbnails[0].attributes['style'];
      final String thumbnail1Style = thumbnails[1].attributes['style'];

      expect(thumbnail0Style, isNull);
      expect(thumbnail1Style, expectedThumbnailStyling);
    });

    test('Resetting the current thumbnail\'s style', () {
      ui.addBorder(currentIndex: 1);

      final String thumbnailStyleBefore =
          document.querySelectorAll('p')[1].attributes['style'];

      expect(thumbnailStyleBefore, expectedThumbnailStyling);

      ui.resetCurrent();

      final String thumbnailStyleAfter =
          document.querySelectorAll('p')[1].attributes['style'];

      expect(thumbnailStyleAfter, isNull);
    });

    test('Extracting the link from the thumbnail', () {
      ui.addBorder(currentIndex: 2);

      expect(ui.thumbnailLink, exampleSite);
    });

    test('Like', () {
      ChangesOnClick changesOnLike;

      final ButtonElement likeButtonElement = ButtonElement();
      likeButtonElement.className = 'like';
      likeButtonElement.onClick
          .listen((Event event) => changesOnLike = ChangesOnClick.like);

      document.body.append(likeButtonElement);

      ui.like(query: 'button');

      expect(changesOnLike, ChangesOnClick.like);
    });

    test('Dislike', () {
      ChangesOnClick changesOnDislike;

      final ButtonElement dislikeButtonElement = ButtonElement();
      dislikeButtonElement.className = 'dislike';
      dislikeButtonElement.onClick
          .listen((Event event) => changesOnDislike = ChangesOnClick.dislike);

      document.body.append(dislikeButtonElement);

      ui.dislike(query: 'button');

      expect(changesOnDislike, ChangesOnClick.dislike);
    });

    test('Subscribe', () {
      ChangesOnClick changesOnSubscribe;

      final ButtonElement buttonElement = ButtonElement();
      buttonElement.className = 'subscribe';
      buttonElement.onClick.listen(
          (Event event) => changesOnSubscribe = ChangesOnClick.subscribed);

      document.body.append(buttonElement);

      ui.subscribe(query: 'button.subscribe');

      expect(changesOnSubscribe, ChangesOnClick.subscribed);
    });
  });
}

enum ChangesOnClick {
  subscribed,
  like,
  dislike,
}
