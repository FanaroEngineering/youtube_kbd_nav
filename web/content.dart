import 'dart:html';

void main() {
  final String htmlElement = 'ytd-rich-item-renderer';
  final ElementList<Element> recommendedThumbnails =
      document.querySelectorAll(htmlElement);

  final StyleElement selectedThumbnailStyle = StyleElement()..text = '';
  document.head.append(selectedThumbnailStyle);

  int thumbnailsIndex = -1;
  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.keyCode) {
      case 103: // code for the letter `g`
        if (thumbnailsIndex < recommendedThumbnails.length - 1) {
          thumbnailsIndex++;
          selectedThumbnailStyle.text = '''
            $htmlElement:nth-child($thumbnailsIndex) {
              border: solid;
              border-width: .5 px;
              border-color: red;
            }
          ''';

          print(thumbnailsIndex);
        }
        break;
      default:
    }
  });
}
