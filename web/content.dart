import 'dart:html';

void main() {
  final String htmlClass = 'div.ytd-rich-grid-video-renderer';
  final ElementList<Element> thumbnails =
      document.querySelectorAll('div.ytd-rich-grid-video-renderer');

  int thumbnailsIndex = -1;
  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.keyCode) {
      case 103: // code for the letter `g`
        thumbnailsIndex++;
        final StyleElement selectedThumbnailStyle = StyleElement()
          ..text = '''
          $htmlClass :nth-child($thumbnailsIndex) {
            border-color: red;
          }
        ''';
        document.head.append(selectedThumbnailStyle);

        print(thumbnailsIndex);
        break;
      default:
    }
  });
}
