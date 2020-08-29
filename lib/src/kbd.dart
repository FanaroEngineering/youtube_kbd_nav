import 'dart:html' show document, Element, KeyboardEvent, window;

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
    _addBorder();
  }

  void resetStylesAndCycler() {
    _ui?.resetCurrentThumbnail();
    _cycler = Cycler();
  }

  Element get _searchBar => document.querySelector('input#search');
  Element get _commentBox => document.querySelector('div#contenteditable-root');

  bool get _inputFocus =>
      _searchBar == document.activeElement ||
      _commentBox == document.activeElement;

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
        case 'y':
          _ui?.notiticationPopUp();
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
