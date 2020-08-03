import 'dart:html';

void main() {
  final String htmlElement = 'ytd-rich-item-renderer';
  final ElementList<Element> thumbnails =
      document.querySelectorAll(htmlElement);

  int thumbnailsIndex = -1;
  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.keyCode) {
      case 103: // code for the letter `g`
        thumbnailsIndex++;
        final StyleElement selectedThumbnailStyle = StyleElement()
          ..text = '''
          $htmlElement :nth-child($thumbnailsIndex) {
            border: solid;
            border-width: .5 px;
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
