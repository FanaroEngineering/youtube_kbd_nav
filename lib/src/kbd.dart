import 'dart:html' show document, Element, KeyboardEvent, window;

import 'cycler.dart' show Cycler;
import 'thumbnails.dart' show Thumbnails;
import 'url_handler.dart' show UrlHandler;
import 'video_buttons.dart' show VideoButtons;

class Kbd {
  String _url = document.baseUri;
  Cycler _cycler = Cycler();
  Thumbnails _thumbnails = Thumbnails(tags: UrlHandler.tags(document.baseUri));
  VideoButtons _videoButtons = VideoButtons();
  KeyboardEvent _keyboardEvent;

  Kbd() {
    window.addEventListener(
        'yt-navigate-start', (_) => _resetStylesAndCyclerAndUrl());
    document.body.onKeyDown.listen((KeyboardEvent keyboardEvent) {
      _keyboardEvent = keyboardEvent;
      _keySwitch();
    });
  }

  void _resetStylesAndCyclerAndUrl() {
    _url = document.baseUri;
    _cycler = Cycler();
    _thumbnails.resetCurrentThumbnail();
    _thumbnails = Thumbnails(tags: UrlHandler.tags(_url));
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

  // Can't put it inside of `yt-navigate-start` because the active element seems
  // to be activated only after that event occurs.
  void _deactivateFilterButton() {
    if (_url.contains('results'))
      document.activeElement.setAttribute('disabled', 'true');
  }

  Future<void> _keySwitch() async {
    if (_noInputFocus) {
      _deactivateFilterButton();
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
        case 'm':
          _commentBoxFocus();
          break;
        case ';':
          _navigateToChannel();
          break;
        case '\\':
          _navigateToVideoChannel();
          break;
      }
    }
  }

  bool get _isVideo => _url.contains('watch');

  void _thumbnailForwards() {
    if (_cycler.total < _thumbnails.length - 1) _cycler.forwards();
    _addBorder();
  }

  void _addBorder() {
    // The thumnails need to be created here because their HTML won't be fully
    // loaded when `yt-navigate-start` occurs.
    _thumbnails = Thumbnails(tags: UrlHandler.tags(_url));
    _thumbnails.addBorder(index: _cycler.total);
  }

  void _thumbnailBackwards() {
    _cycler.backwards();
    _addBorder();
  }

  void _navigateHome() => _navigate(UrlHandler.youtubeHome);

  void _navigateThumbnailLink() {
    if (_cycler.total >= 0) _navigate(_thumbnails?.thumbnailLink);
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
    if (!_isVideo && _cycler.total >= 0) _navigate(_thumbnails?.channelLink);
  }

  void _navigateToVideoChannel() {
    if (_isVideo) _navigate(_videoButtons?.channelLink);
  }
}
