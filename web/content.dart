import 'dart:html';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  // Page page;

  document.addEventListener('yt-navigate-finish', (Event event) {
    document.querySelectorAll(
        'ytd-rich-item-renderer, ytd-compact-video-renderer, ytd-compact-radio-renderer')
      ..forEach((Element element) => element.attributes.remove('style'));
    //   print(document.baseUri);

    //   // page = Page(input: document);

    //   // page = Page(
    //   //         input: document,
    //   //         tag: 'ytd-compact-video-renderer, ytd-compact-radio-renderer');

    //   page = document.baseUri.contains('watch')
    //       ? Page(
    //           input: document,
    //           tag: 'ytd-compact-video-renderer, ytd-compact-radio-renderer')
    //       : Page(input: document);
  });

  int index = 0;
  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    // final Page page = Page(input: document);
    // final Page page = Page(
    //         input: document,
    //         tag: 'ytd-compact-video-renderer, ytd-compact-radio-renderer');
    final Page page = document.baseUri.contains('watch')
        ? Page(
            input: document,
            tag: 'ytd-compact-video-renderer, ytd-compact-radio-renderer',
            index: index)
        : Page(input: document, index: index);

    print(document.baseUri);

    switch (keyboardEvent.key) {
      case 'z':
        page?.addBorder(NextOrPrevious.next);
        index++;
        break;
      case 'x':
        page?.addBorder(NextOrPrevious.previous);
        index--;
        break;
      case 'Enter':
        final String thumbnailLink = page?.currentThumbnailLink;
        thumbnailLink != null ? window.open(thumbnailLink, '') : null;
        break;
    }
  });
}
