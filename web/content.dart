import 'dart:html';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  final YoutubeMainPage youtubeMainPage = YoutubeMainPage(input: document);

  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.keyCode) {
      case 103: // code for the letter `g`
        youtubeMainPage.addBorderToNext();
        break;
      default:
    }
  });
}
