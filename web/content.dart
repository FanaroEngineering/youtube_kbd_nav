import 'dart:html' show document, KeyboardEvent;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show KbdHandler;

void main() {
  final KbdHandler kbdHandler = KbdHandler();

  document.onKeyPress.listen((KeyboardEvent keyboardEvent) =>
      kbdHandler.onKeyPress(keyboardEvent, tags: 'ytd-rich-item-renderer'));
}
