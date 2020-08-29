import 'dart:html' show document, KeyboardEvent, window, Event;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Kbd;

void main() async {
  final Kbd kbdHandler = Kbd();

  window.addEventListener(
      'yt-navigate-start', (Event event) => kbdHandler.resetStylesAndCycler());

  document.onKeyPress.listen((KeyboardEvent keyboardEvent) =>
      kbdHandler.onKeyPress(keyboardEvent, newUrl: document.baseUri));
}
