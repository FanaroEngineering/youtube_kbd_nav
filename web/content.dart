import 'dart:html' show document, KeyboardEvent, window, Event;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show KbdHandler;

void main() async {
  final KbdHandler kbdHandler = KbdHandler();

  window.addEventListener(
      'yt-navigate-start', (Event event) => kbdHandler.resetStylesAndCycler());

  document.onKeyPress.listen((KeyboardEvent keyboardEvent) async =>
      await kbdHandler.onKeyPress(keyboardEvent, newUrl: document.baseUri));
}
