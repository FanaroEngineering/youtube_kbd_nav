import 'dart:html' show document, KeyboardEvent, window;

import 'cycler.dart' show Cycler;
import 'ui.dart' show Ui;
import 'url_handler.dart' show UrlHandler;

class KbdHandler {
  Cycler _cycler;
  String _url = '';
  Ui _ui;

  /// The [Cycler] is a parameter just so we can inject it during testing and
  /// check if everything happened as expected.
  KbdHandler({Cycler cycler}) : _cycler = cycler ?? Cycler();

  Future<void> onKeyPress(KeyboardEvent keyboardEvent,
      {String newUrl = ''}) async {
    _resetCyclerIfUrlChange(newUrl);
    await _keySwitch(keyboardEvent);
    _addBorder();
  }

  void resetStylesAndCycler() {
    _ui?.resetCurrent();
    _cycler = Cycler();
  }

  bool get _inputFocus =>
      document.querySelector('div#contenteditable-root, input#search') ==
      document.activeElement;

  Future<void> _keySwitch(KeyboardEvent keyboardEvent) async {
    if (!_inputFocus) {
      switch (keyboardEvent.key) {
        case 'z':
          _cycler.forwards();
          break;
        case 'x':
          _cycler.backwards();
          break;
        case 'q':
          window.location.href = UrlHandler.prefixedLink('/');
          break;
        case 'Enter':
          _cycler.index >= 0 ? window.open(_ui?.thumbnailLink, '') : null;
          break;
        case 'e':
          _isVideo ? _ui?.subscribe() : null;
          break;
        case 'v':
          _isVideo ? _ui?.like() : null;
          break;
        case 'n':
          _isVideo ? _ui?.dislike() : null;
          break;
        case 'b':
          _isVideo
              ? await window.navigator.clipboard
                  .writeText(UrlHandler.shortenLink(_url))
              : null;
          break;
      }
    }
  }

  bool get _isVideo => _url.contains('watch');

  void _resetCyclerIfUrlChange(String newUrl) {
    if (newUrl != _url) {
      _url = newUrl;
      _cycler = Cycler();
    }
  }

  void _addBorder() {
    if (_url != null) {
      final String tags = UrlHandler.tags(_url);
      _ui = Ui(tags: tags);
      _ui.addBorder(currentIndex: _cycler.index);
    }
  }
}
