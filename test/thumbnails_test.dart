import 'dart:html' show Document, DomParser, Element;

import 'package:test/test.dart' show contains, expect, isNull, setUp, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Cycle, Thumbnails;

void main() {
  const String mainTag = 'ytd-rich-item-renderer',
      expectedThumbnailStyling = 'outline: red solid; outline-offset: -1px;';

  final Document document =
      DomParser().parseFromString(thumbnailsHtmlAsString, 'text/html');

  Thumbnails thumbnails;

  setUp(() =>
      thumbnails = Thumbnails(tags: 'ytd-rich-item-renderer', doc: document));

  test('Adds border to the thumbnail', () {
    thumbnails = thumbnails + const Cycle();

    final String newStyle = document.querySelector(mainTag).attributes['style'];

    expect(newStyle, expectedThumbnailStyling);
  });

  test(
      'Adding a border to the current thumbnail deletes the styling on its '
      'neighbors', () {
    thumbnails = thumbnails + const Cycle();
    thumbnails = thumbnails + const Cycle();

    final List<Element> thumbnailElements = document.querySelectorAll(mainTag);
    final String thumbnail0Style = thumbnailElements[0].attributes['style'],
        thumbnail1Style = thumbnailElements[1].attributes['style'];

    expect(thumbnail0Style, isNull);
    expect(thumbnail1Style, expectedThumbnailStyling);
  });

  test('Resetting the current thumbnail\'s style', () {
    thumbnails = thumbnails + const Cycle();
    thumbnails = thumbnails + const Cycle();

    final String thumbnailStyleBefore =
        document.querySelectorAll(mainTag)[1].attributes['style'];

    expect(thumbnailStyleBefore, expectedThumbnailStyling);

    thumbnails.resetCurrentThumbnail();

    final String thumbnailStyleAfter =
        document.querySelectorAll(mainTag)[1].attributes['style'];

    expect(thumbnailStyleAfter, isNull);
  });

  test('Extracting the link from the thumbnail', () {
    thumbnails = thumbnails + const Cycle();
    thumbnails = thumbnails + const Cycle();

    expect(thumbnails.thumbnailLink, contains('/watch?v=qwerty'));
  });

  test('Extracting the channel\'s link from the thumbnail', () {
    thumbnails = thumbnails + const Cycle();

    expect(thumbnails.channelLink, contains('/c/dummyChannel1'));
  });
}

const String thumbnailsHtmlAsString = '''
  <ytd-rich-item-renderer>
    <div>
      <ytd-rich-grid-video-renderer>
        <div>
          <ytd-thumbnail>
            <a href="/watch?v=asdf"></a>
          </ytd-thumbnail>
          <a href="/c/dummyChannel1">dummyChannel1</a>
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
          <a href="/c/dummyChannel2">dummyChannel2</a>
        </div>
      </ytd-rich-grid-video-renderer>
    </div>
  </ytd-rich-item-renderer>
''';
