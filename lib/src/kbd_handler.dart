import 'dart:html';

import 'package:meta/meta.dart';

import 'cycler.dart';

@immutable
class KbdHandler {
  final Cycler _cycler;

  /// The [Cycler] is a parameter just so we can inject it during testing and
  /// check if everything happened as expected.
  KbdHandler({Cycler cycler}) : _cycler = cycler ?? Cycler();

  void onKeyPress(KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.key) {
      case 'z':
        _cycler.forwards();
        break;
      case 'x':
        _cycler.backwards();
        break;
    }
  }
}
