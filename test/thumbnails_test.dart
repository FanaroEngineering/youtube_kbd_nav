import 'dart:html' show Document, DomParser, Element;

import 'package:test/test.dart' show contains, expect, isNull, setUp, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Thumbnails;

void main() {
  const String mainTag = 'ytd-rich-item-renderer';

  final Document document =
      DomParser().parseFromString(uiHtmlAsString, 'text/html');

  const String expectedThumbnailStyling =
      'outline: red solid; outline-offset: -1px;';

  Thumbnails thumbnails;

  setUp(() =>
      thumbnails = Thumbnails(tags: 'ytd-rich-item-renderer', doc: document));

  test('Adds border to the thumbnail', () {
    thumbnails.addBorder(index: 0);

    final String newStyle = document.querySelector(mainTag).attributes['style'];

    expect(newStyle, expectedThumbnailStyling);
  });

  test(
      'Adding a border to the current thumbnail deletes the styling on its '
      'neighbors', () {
    thumbnails.addBorder(index: 1);

    final List<Element> thumbnailElements = document.querySelectorAll(mainTag);
    final String thumbnail0Style = thumbnailElements[0].attributes['style'];
    final String thumbnail1Style = thumbnailElements[1].attributes['style'];

    expect(thumbnail0Style, isNull);
    expect(thumbnail1Style, expectedThumbnailStyling);
  });

  test('Resetting the current thumbnail\'s style', () {
    thumbnails.addBorder(index: 1);

    final String thumbnailStyleBefore =
        document.querySelectorAll(mainTag)[1].attributes['style'];

    expect(thumbnailStyleBefore, expectedThumbnailStyling);

    thumbnails.resetCurrentThumbnail();

    final String thumbnailStyleAfter =
        document.querySelectorAll(mainTag)[1].attributes['style'];

    expect(thumbnailStyleAfter, isNull);
  });

  test('Extracting the link from the thumbnail', () {
    thumbnails.addBorder(index: 1);

    expect(thumbnails.thumbnailLink, contains('/watch?v=qwerty'));
  });
}

const String uiHtmlAsString = '''
    <ytd-rich-item-renderer>
      <div>
        <ytd-rich-grid-video-renderer>
          <div>
            <ytd-thumbnail>
              <a href="/watch?v=asdf"></a>
            </ytd-thumbnail>
          </div>
        </ytd-rich-grid-video-renderer>
      </div>
    </ytd-rich-item-renderer>
    <ytd-rich-item-renderer>
      <div>
        <ytd-rich-grid-video-renderer>
          <div>
            <ytd-thumbnail>
              <a href="/watch?v=qwerty"></a>
            </ytd-thumbnail>
          </div>
        </ytd-rich-grid-video-renderer>
      </div>
    </ytd-rich-item-renderer>
  ''';
