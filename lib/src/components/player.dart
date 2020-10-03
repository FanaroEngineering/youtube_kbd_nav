import 'dart:html' show DivElement, Document, document;

import 'package:meta/meta.dart' show immutable;

import '../utils/annotations.dart' show NecessaryInterop, VisibleForTesting;
import '../utils/player_interop.dart'
    show exitPictureInPicture, isFullScreen, requestPictureInPicture;

@immutable
class Player {
  final Document _document;
  final bool _inPip;

  Player({bool inPip = false, @VisibleForTesting.document() Document doc})
      : _inPip = inPip,
        _document = doc ?? document {
    document.addEventListener('fullscreenchange',
        (_) => isFullScreen ? _playerDiv.blur() : _playerDiv.focus());
  }

  Player.inPip() : this(inPip: true);
  Player.outOfPip() : this(inPip: false);

  DivElement get _playerDiv => _document.querySelector('#movie_player');

  @NecessaryInterop()
  Player togglePip() {
    _inPip ? exitPictureInPicture() : requestPictureInPicture();
    return Player(inPip: _inPip ? false : true, doc: _document);
  }

  void togglePlayerFocus() => _document.activeElement == _playerDiv
      ? _playerDiv.blur()
      : _playerDiv.focus();

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
