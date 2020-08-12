import 'dart:html';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  window.addEventListener('yt-navigate-start', (Event event) {
    Page page;

    if (document.baseUri.contains('watch')) {
      print('watch');
      page = Page(input: document, tag: 'ytd-compact-video-renderer');
    } else {
      print('main');
      page = Page(input: document);
    }

    document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
      switch (keyboardEvent.key) {
        case 'z':
          page.addBorder(NextOrPrevious.next);
          break;
        case 'x':
          page.addBorder(NextOrPrevious.previous);
          break;
        case 'Enter':
          final String thumbnailLink = page.currentThumbnailLink;
          window.open(thumbnailLink, '');
          break;
      }
    });
  });
}
