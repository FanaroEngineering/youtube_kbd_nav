import 'dart:html' show KeyboardEvent;

import 'package:meta/meta.dart' show immutable;

import 'cycler.dart' show Cycler;
import 'ui.dart' show Ui;

@immutable
class KbdHandler {
  final Cycler _cycler;

  /// The [Cycler] is a parameter just so we can inject it during testing and
  /// check if everything happened as expected.
  KbdHandler({
    Cycler cycler
  })  : _cycler = cycler ?? Cycler();

  void onKeyPress(KeyboardEvent keyboardEvent, {String tags = 'p'}) {
    switch (keyboardEvent.key) {
      case 'z':
        _cycler.forwards();
        break;
      case 'x':
        _cycler.backwards();
        break;
    }
    Ui(tags: tags)..addBorder(currentIndex: _cycler.index);
  }
}
