import 'dart:html' show document, KeyboardEvent, window;

import 'cycler.dart' show Cycler;
import 'ui.dart' show Ui;
import 'url_handler.dart' show UrlHandler;

class Kbd {
  Cycler _cycler;
  String _url = '';
  Ui _ui;

  /// The [Cycler] is a parameter just so we can inject it during testing and
  /// check if everything happened as expected.
  Kbd({Cycler cycler}) : _cycler = cycler ?? Cycler();

  Future<void> onKeyPress(KeyboardEvent keyboardEvent,
      {String newUrl = ''}) async {
    _resetCyclerIfUrlChange(newUrl);
    await _keySwitch(keyboardEvent);
  }

  void resetStylesAndCycler() {
    _ui?.resetCurrentThumbnail();
    _cycler = Cycler();
  }

  bool get _inputFocus =>
      document.querySelector('div#contenteditable-root') ==
          document.activeElement ||
      document.querySelector('input#search') == document.activeElement;

  Future<void> _keySwitch(KeyboardEvent keyboardEvent) async {
    if (!_inputFocus) {
      switch (keyboardEvent.key) {
        case 'z':
          _cycler.forwards();
          _addBorder();
          break;
        case 'x':
          _cycler.backwards();
          _addBorder();
          break;
        case 'q':
          window.location.href = UrlHandler.prefixedLink('/');
          break;
        case 'Enter':
          if (_cycler.total >= 0) window.open(_ui?.thumbnailLink, '');
          break;
        case 'e':
          if (_isVideo) _ui?.subscribe();
          break;
        case 'v':
          if (_isVideo) _ui?.like();
          break;
        case 'n':
          if (_isVideo) _ui?.dislike();
          break;
        case 'b':
          if (_isVideo)
            await window.navigator.clipboard
                .writeText(UrlHandler.shortenLink(_url));
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
      _ui.addBorder(currentIndex: _cycler.total);
    }
  }
}
