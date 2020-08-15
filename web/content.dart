import 'dart:html';

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart';

void main() {
  final Cycler cycler = Cycler();

  document.onKeyPress.listen((KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.key) {
      case 'z':
        cycler.forwards();
        break;
      case 'x':
        cycler.backwards();
        break;
    }
  });
}
