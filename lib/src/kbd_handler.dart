import 'dart:html' show KeyboardEvent;

import 'package:meta/meta.dart' show immutable;

import 'cycler.dart' show Cycler;
import 'ui.dart' show Ui;

@immutable
class KbdHandler {
  final Cycler _cycler;
  final String _tags;

  /// The [Cycler] is a parameter just so we can inject it during testing and
  /// check if everything happened as expected.
  KbdHandler({
    Cycler cycler,
    String tags = 'p',
  })  : _cycler = cycler ?? Cycler(),
        _tags = tags;

  void onKeyPress(KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.key) {
      case 'z':
        _cycler.forwards();
        break;
      case 'x':
        _cycler.backwards();
        break;
    }
    Ui(tags: _tags)..addBorder(currentIndex: _cycler.index);
  }
}
