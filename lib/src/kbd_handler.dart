import 'dart:html' show KeyboardEvent;

import 'package:meta/meta.dart' show immutable;

import 'cycler.dart' show Cycler;
import 'ui.dart' show Ui;

@immutable
class KbdHandler {
  final Cycler _cycler;
  final Ui _ui;

  /// The [Cycler] is a parameter just so we can inject it during testing and
  /// check if everything happened as expected.
  KbdHandler({
    Cycler cycler,
    Ui ui,
  })  : _cycler = cycler ?? Cycler(),
        _ui = ui ?? Ui(tag: 'p');

  void onKeyPress(KeyboardEvent keyboardEvent) {
    switch (keyboardEvent.key) {
      case 'z':
        _cycler.forwards();
        break;
      case 'x':
        _cycler.backwards();
        break;
    }
    _ui.addBorder(nthChild: _cycler.index);
  }
}
