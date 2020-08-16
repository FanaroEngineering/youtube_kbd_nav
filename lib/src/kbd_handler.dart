import 'dart:html' show KeyboardEvent;

import 'cycler.dart' show Cycler;
import 'ui.dart' show Ui;
import 'url_to_tags.dart' show UrlToTags;

class KbdHandler {
  Cycler _cycler;
  String _url;

  /// The [Cycler] is a parameter just so we can inject it during testing and
  /// check if everything happened as expected.
  KbdHandler({Cycler cycler}) : _cycler = cycler ?? Cycler();

  void onKeyPress(KeyboardEvent keyboardEvent, {String url}) {
    if (url != _url) {
      _url = url;
      _cycler = Cycler();
    }

    switch (keyboardEvent.key) {
      case 'z':
        _cycler.forwards();
        break;
      case 'x':
        _cycler.backwards();
        break;
    }
    final UrlToTags urlToTags = UrlToTags(url);
    Ui(tags: urlToTags.tags)..addBorder(currentIndex: _cycler.index);
  }
}
