import 'dart:html';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  final YoutubeMainPage youtubeMainPage = YoutubeMainPage(input: document);

  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.key) {
      case 'g':
        youtubeMainPage.addBorderToNext();
        break;
      case 'Enter':
        window.open('https://youtu.be/PN51zAW-JcE', '');
        print(window.opener);
        break;
        
    }
  });
}
