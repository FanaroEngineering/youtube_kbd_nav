import 'dart:html';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  Page page;

  void ext(Event event) {
    if (document.baseUri.contains('watch')) {
      page = Page(
          input: document,
          tag: 'ytd-compact-video-renderer, ytd-compact-radio-renderer');
    } else {
      page = Page(input: document);
    }
  }

  window.addEventListener('yt-navigate-start', ext);

  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.key) {
      case 'z':
        page?.addBorder(NextOrPrevious.next);
        break;
      case 'x':
        page?.addBorder(NextOrPrevious.previous);
        break;
      case 'Enter':
        final String thumbnailLink = page?.currentThumbnailLink;
        window.open(thumbnailLink, '');
        break;
    }
  });
}
