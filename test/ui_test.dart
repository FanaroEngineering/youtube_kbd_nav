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

      ui.resetCurrentThumbnail();

      final String thumbnailStyleAfter =
          document.querySelectorAll('p')[1].attributes['style'];

      expect(thumbnailStyleAfter, isNull);
    });

    test('Extracting the link from the thumbnail', () {
      ui.addBorder(currentIndex: 2);

      expect(ui.thumbnailLink, exampleSite);
    });

    group('Clicking Buttons |', () {
      const Map<String, String> buttonsClasses = {
        'subscribe': 'subscribe',
        'like': 'likeDislike',
        'dislike': 'likeDislike',
        'notificationPopUp': 'notificationPopUp',
      };

      final Map<String, ButtonElement> buttons = {};
      buttonsClasses.forEach((String key, String className) =>
          buttons.addAll({key: ButtonElement()..className = className}));

      buttons
          .forEach((_, ButtonElement button) => document.body.append(button));

      test('Subscribe', () {
        ChangesOnClick changesOnSubscribe;

        buttons['subscribe']
            .onClick
            .listen((_) => changesOnSubscribe = ChangesOnClick.subscribed);

        ui.subscribe(query: 'button.${buttonsClasses['subscribe']}');

        expect(changesOnSubscribe, ChangesOnClick.subscribed);
      });

      test('Like', () {
        ChangesOnClick changesOnLike;

        buttons['like']
            .onClick
            .listen((_) => changesOnLike = ChangesOnClick.like);

        ui.like(query: 'button.${buttonsClasses['like']}');

        expect(changesOnLike, ChangesOnClick.like);
      });

      test('Dislike', () {
        ChangesOnClick changesOnDislike;

        buttons['dislike']
            .onClick
            .listen((_) => changesOnDislike = ChangesOnClick.dislike);

        ui.dislike(query: 'button.${buttonsClasses['dislike']}');

        expect(changesOnDislike, ChangesOnClick.dislike);
      });

      test('Notification Pop Up', () {
        ChangesOnClick changesOnNotificationPopUp;

        buttons['notificationPopUp'].onClick.listen((Event _) =>
            changesOnNotificationPopUp = ChangesOnClick.notificationPopUp);

        ui.notiticationPopUp(
            query: 'button.${buttonsClasses['notificationPopUp']}');

        expect(changesOnNotificationPopUp, ChangesOnClick.notificationPopUp);
      });
    });
  });
}

enum ChangesOnClick {
  subscribed,
  like,
  dislike,
  notificationPopUp,
}
