import 'dart:html' show document, Element, KeyboardEvent, window;

import 'cycle.dart' show Cycle;
import 'thumbnails.dart' show Thumbnails;
import 'url_handler.dart' show UrlHandler;
import 'video_buttons.dart' show VideoButtons;

class Kbd {
  String _url = document.baseUri;
  Thumbnails _thumbnails = Thumbnails(tags: UrlHandler.tags(document.baseUri));
  VideoButtons _videoButtons = VideoButtons();
  KeyboardEvent _keyboardEvent;

  Kbd() {
    window.onLoad.listen((_) => _completeReset());
    // If we take the `yt-navigate-start` event out, the thumbnails might not be
    // completely loaded at first, but only when everything has been completely
    // loaded (`onLoad`).
    window.addEventListener('yt-navigate-start', (_) => _completeReset());
    document.body.onKeyDown.listen((KeyboardEvent keyboardEvent) {
      _keyboardEvent = keyboardEvent;
      _keySwitch();
    });
  }

  void _completeReset() {
    _resetStylesAndCyclerAndUrl();
    _deactivateFilterButton();
    if (_isVideo) {
      _decorateFocusedPlayer();
      _listenForOtherPlayerFocusEvents();
    }
  }

  void _listenForOtherPlayerFocusEvents() {
    _player?.onBlur?.listen((_) => _decorateUnfocusedPlayer());
    _player?.onFocus?.listen((_) => _decorateFocusedPlayer());
  }

  void _togglePlayerFocus() =>
      document.activeElement == _player ? _player?.blur() : _player?.focus();

  Element get _player => document.querySelector('#movie_player');

  void _decorateUnfocusedPlayer() {
    _player?.style?.borderBottom = '#483D8B solid';
    _player?.style?.borderWidth = '0.5px';
  }

  void _decorateFocusedPlayer() {
    _player?.style?.borderBottom = '#FF8C00 solid';
    _player?.style?.borderWidth = '0.5px';
  }

  void _resetStylesAndCyclerAndUrl() {
    _url = document.baseUri;
    _thumbnails.resetCurrentThumbnail();
    _thumbnails = Thumbnails(tags: UrlHandler.tags(_url));
  }

  void _deactivateFilterButton() {
    if (_url.contains('results')) document.activeElement.blur();
  }

  bool get _noInputFocus {
    const String commentBoxQuery = 'yt-formatted-string.ytd-commentbox > div';
    bool noInputFocus = true;
    <Element>[
      document.querySelector('input#search'),
      document.querySelector('iron-input > input'),
      document.querySelectorAll(commentBoxQuery)[0],
      document.querySelectorAll(commentBoxQuery)[1],
    ].forEach((Element element) {
      if (element == document.activeElement) noInputFocus = false;
    });
    return noInputFocus;
  }

  Future<void> _keySwitch() async {
    if (_noInputFocus) {
      switch (_keyboardEvent.key) {
        case 'z':
          _thumbnailForwards();
          break;
        case 'x':
          _thumbnailBackwards();
          break;
        case 'q':
          _navigateHome();
          break;
        case 'Enter':
          _navigateThumbnailLink();
          break;
        case 'h':
          _navigateHistory();
          break;
        case 'e':
          _subscribe();
          break;
        case 'v':
          _like();
          break;
        case 'n':
          _dislike();
          break;
        case 'y':
          _notificationPopUp();
          break;
        case 'b':
          await _copyVideoUrl();
          break;
        case '[':
          _commentBoxFocus();
          break;
        case ']':
          _toggleDescription();
          break;
        case ';':
          _navigateToChannel();
          break;
        case '=':
          _navigateToVideoChannel();
          break;
        case '\\':
          _togglePlayerFocus();
          break;
      }
    }
  }

  bool get _isVideo => _url.contains('watch');

  void _thumbnailForwards() => _thumbnails = _thumbnails + const Cycle();

  void _thumbnailBackwards() => _thumbnails = _thumbnails - const Cycle();

  void _navigateHome() => _navigate(UrlHandler.youtubeHome);

  void _navigateThumbnailLink() {
    if (_thumbnails.thumbnailLink != null)
      _navigate(_thumbnails?.thumbnailLink);
  }

  void _navigate(String url) {
    final bool modifierKey = window.navigator.appVersion.contains('Mac')
        ? _keyboardEvent.metaKey
        : _keyboardEvent.ctrlKey;

    modifierKey
        ? window.open(url, '_blank', 'noreferrer')
        : window.location.href = url;
  }

  void _navigateHistory() => _navigate(UrlHandler.history);

  void _subscribe() {
    if (_isVideo) _videoButtons?.subscribe();
  }

  void _like() {
    if (_isVideo) _videoButtons?.like();
  }

  void _dislike() {
    if (_isVideo) _videoButtons?.dislike();
  }

  void _notificationPopUp() => _videoButtons?.notiticationPopUp();

  Future<void> _copyVideoUrl() async {
    if (_isVideo)
      await window.navigator.clipboard.writeText(UrlHandler.shortenLink(_url));
  }

  void _commentBoxFocus() {
    if (_isVideo && _keyboardEvent.ctrlKey) _videoButtons.commentBoxFocus();
  }

  void _navigateToChannel() {
    if (!_isVideo && _thumbnails.channelLink != null)
      _navigate(_thumbnails?.channelLink);
  }

  void _navigateToVideoChannel() {
    if (_isVideo) _navigate(_videoButtons?.channelLink);
  }

  void _toggleDescription() {
    if (_isVideo && _keyboardEvent.ctrlKey)
      _videoButtons = _videoButtons.toggleDescription();
  }
}
