import 'dart:async' show Timer;
import 'dart:html'
    show document, DivElement, Element, InputElement, KeyboardEvent, window;

import 'components/cycle.dart' show Cycle;
import 'components/logo.dart' show Logo;
import 'components/player.dart' show Player;
import 'components/thumbnails.dart' show Thumbnails;
import 'components/url_handler.dart' show UrlHandler;
import 'components/video_buttons.dart' show VideoButtons;

class Kbd {
  String _url = document.baseUri;
  Thumbnails _thumbnails = Thumbnails(tags: UrlHandler.tags(document.baseUri));
  VideoButtons _videoButtons = VideoButtons();
  Player _player = Player();
  KeyboardEvent _keyboardEvent;
  bool _onSwitch = true;
  final Logo _logo = const Logo();

  void _initialLogo() =>
      Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
        final DivElement logoDiv = document.querySelector('div#start');
        if (logoDiv != null) {
          _logo.toggle();
          timer.cancel();
        }
      });

  Kbd() {
    _initialLogo();
    window.onLoad.listen((_) => _completeReset());
    // If we take the `yt-navigate-start` event out, the thumbnails might not be
    // completely loaded at first, but only when everything has been completely
    // loaded (`onLoad`).
    window.addEventListener('yt-navigate-start', (_) => _completeReset());
    document.body.onKeyDown.listen(_handleKeyboardEvent);
    // The user might use his mouse to trigger the events, so we need to
    // recreate the player since it is *immutable*.
    document.addEventListener(
        'enterpictureinpicture', (_) => _player = Player.inPip());
    document.addEventListener(
        'leavepictureinpicture', (_) => _player = Player.outOfPip());
  }

  void _toggleExtension() {
    _onSwitch = !_onSwitch;
    _completeReset();
    _logo.toggle();
  }

  bool get _toggleShortcut =>
      _keyboardEvent.ctrlKey && _keyboardEvent.key == '/';

  void _handleKeyboardEvent(KeyboardEvent keyboardEvent) {
    _keyboardEvent = keyboardEvent;

    if (_toggleShortcut) {
      _toggleExtension();
    } else {
      if (_onSwitch && _noInputFocus) _keySwitch();
    }
  }

  void _completeReset() {
    _resetStylesAndCyclerAndUrl();
    if (_isVideo) {
      _player.decorateFocusedPlayer();
      _player.listenForOtherPlayerFocusEvents();
    }
  }

  void _resetStylesAndCyclerAndUrl() {
    _url = document.baseUri;
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
    if (document.activeElement is InputElement) noInputFocus = false;
    return noInputFocus;
  }

  Future<void> _keySwitch() async {
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
      case 'w':
        _watchLater();
        break;
      case 'e':
        _toggleSubscription();
        break;
      case 'v':
        _like();
        break;
      case 'n':
        _dislike();
        break;
      case 'y':
        _yShortcut();
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
      case 'w':
        _togglePip();
        break;
    }
  }

  void _yShortcut() => _keyboardEvent.ctrlKey
      ? _thumbnails.cycles.uncycled
          ? _isVideo
              ? _videoButtons.addToWatchLater()
              : null
          : _thumbnails.addToWatchLater()
      : _notificationPopUp();

  void _togglePip() {
    if (_isVideo) _player = _player.togglePip();
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

  void _toggleSubscription() {
    if (_isVideo) _videoButtons?.toggleSubscription();
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

  void _togglePlayerFocus() => _player.togglePlayerFocus();

  void _watchLater() {
    const String watchLaterPath = '/playlist?list=WL';
    if (window.location.pathname != watchLaterPath)
      _navigate(UrlHandler.watchLater);
  }
}
