import 'dart:html' show DivElement, Document, document;

import 'package:meta/meta.dart' show immutable;

import 'utils/annotations.dart' show NecessaryInterop, VisibleForTesting;
import 'utils/player_interop.dart'
    show exitPictureInPicture, requestPictureInPicture;

@immutable
class Player {
  final Document _document;

  Player({@VisibleForTesting.document() Document doc})
      : _document = doc ?? document;

  DivElement get _playerDiv =>
      _document.querySelector('#movie_player');

  @NecessaryInterop()
  void reqPip() => requestPictureInPicture();

  @NecessaryInterop()
  void exitPip() => exitPictureInPicture();

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
}
