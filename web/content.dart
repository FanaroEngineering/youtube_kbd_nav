import 'dart:html';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  final MainPage youtubeMainPage = MainPage(input: document);

  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.key) {
      case 'j':
        youtubeMainPage.addBorder(NextOrPrevious.next);
        break;
      case 'k':
        youtubeMainPage.addBorder(NextOrPrevious.previous);
        break;
      case 'Enter':
        final String thumbnailLink = youtubeMainPage.currentThumbnailLink;
        window.open(thumbnailLink, '');
        break;
    }
  });
}
