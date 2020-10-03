import 'dart:html' show DivElement, Document, document;

import 'package:meta/meta.dart' show immutable;

import '../utils/annotations.dart' show NecessaryInterop, VisibleForTesting;
import '../utils/player_interop.dart'
    show exitPictureInPicture, requestPictureInPicture;

@immutable
class Player {
  final Document _document;
  final bool _inPip;

  Player({bool inPip = false, @VisibleForTesting.document() Document doc})
      : _inPip = inPip,
        _document = doc ?? document;

  DivElement get _playerDiv => _document.querySelector('#movie_player');

  @NecessaryInterop()
  Player togglePip() {
    _inPip ? exitPictureInPicture() : requestPictureInPicture();
    return Player(inPip: _inPip ? false : true, doc: _document);
  }

  void togglePlayerFocus() {
    if (_document.activeElement == _playerDiv) {
      _playerDiv.blur();
      decorateUnfocusedPlayer();
    } else {
      _playerDiv.focus();
      decorateFocusedPlayer();
    }
  }

  void decorateUnfocusedPlayer() {
    _playerDiv?.style?.borderBottom = '#483D8B solid';
    _playerDiv?.style?.borderWidth = '0.5px';
  }

  void decorateFocusedPlayer() {
    _playerDiv?.style?.borderBottom = '#FF8C00 solid';
    _playerDiv?.style?.borderWidth = '0.5px';
  }

  void listenForOtherPlayerFocusEvents() {
    _playerDiv?.onBlur?.listen((_) => decorateUnfocusedPlayer());
    _playerDiv?.onFocus?.listen((_) => decorateFocusedPlayer());
  }
}
