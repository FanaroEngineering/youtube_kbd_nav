import 'dart:html';

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart';

void main() {
  final KbdHandler kbdHandler = KbdHandler();

  document.onKeyPress.listen(
      (KeyboardEvent keyboardEvent) => kbdHandler.onKeyPress(keyboardEvent));
}
