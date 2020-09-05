import 'dart:html' show Document, document, Element, KeyboardEvent, window;

import 'cycler.dart' show Cycler;
import 'thumbnails.dart' show Thumbnails;
import 'url_handler.dart' show UrlHandler;
import 'video_buttons.dart' show VideoButtons;

class Kbd {
  Document _document;
  Cycler _cycler;
  String _url = '';
  Thumbnails _thumbnails = Thumbnails(tags: UrlHandler.tags('watch'));
  VideoButtons _videoButtons = VideoButtons();
  KeyboardEvent _keyboardEvent;

  /// The [Cycler] and [Document] are parameters just so we can inject them 
  /// during testing and check if everything happened as expected.
  Kbd({Document doc}) : _document = doc ?? document {
    window.addEventListener('yt-navigate-start', (_) => _resetStylesAndCycler());
    _document.onKeyDown.listen((KeyboardEvent keyboardEvent) {
      _keyboardEvent = keyboardEvent;
      _onKeyDown(newUrl: _document.baseUri);
    });
  }

  void _resetStylesAndCycler() {
    _thumbnails?.resetCurrentThumbnail();
    _cycler = Cycler();
  }

  Future<void> _onKeyDown({String newUrl = ''}) async {
    _resetCyclerIfUrlChange(newUrl);
    await _keySwitch();
  }

  void _resetCyclerIfUrlChange(String newUrl) {
    if (newUrl != _url) {
      _url = newUrl;
      _cycler = Cycler();
    }
  }

  Element get _searchBar => _document.querySelector('input#search');
  Element get _playlistName => _document.querySelector('iron-input > input');
  Element get _commentBox => _document.querySelectorAll(_commentBoxQuery)[0];
  Element get _editCommentBox => _document.querySelectorAll(_commentBoxQuery)[1];
  String get _commentBoxQuery => 'yt-formatted-string.ytd-commentbox > div';

  bool get _noInputFocus => !(_searchBar == _document.activeElement ||
      _commentBox == _document.activeElement ||
      _editCommentBox == _document.activeElement || _playlistName == _document.activeElement);

  Future<void> _keySwitch() async {
    if (_noInputFocus) {
      switch (_keyboardEvent.key) {
        case 'z':
          _cycler.forwards();
          _addBorder();
          break;
        case 'x':
          _cycler.backwards();
          _addBorder();
          break;
        case 'q':
          _navigate(UrlHandler.youtubeHome);
          break;
        case 'Enter':
          if (_cycler.total >= 0) {
            _navigate(_thumbnails?.thumbnailLink);
          }
          break;
        case 'h':
          _navigate(UrlHandler.history);
          break;
        case 'e':
          if (_isVideo) _videoButtons?.subscribe();
          break;
        case 'v':
          if (_isVideo) _videoButtons?.like();
          break;
        case 'n':
          if (_isVideo) _videoButtons?.dislike();
          break;
        case 'b':
          if (_isVideo)
            await window.navigator.clipboard
                .writeText(UrlHandler.shortenLink(_url));
          break;
        case 'y':
          _videoButtons?.notiticationPopUp();
          break;
        default:
      }
    }
  }

  bool get _isVideo => _url.contains('watch');

  void _addBorder() {
    if (_url != null) {
      final String tags = UrlHandler.tags(_url);
      _thumbnails = Thumbnails(tags: tags);
      _thumbnails.addBorder(index: _cycler.total);
    }
  }

  void _navigate(String url) {
    final bool modifierKey = window.navigator.appVersion.contains('Mac')
        ? _keyboardEvent.metaKey
        : _keyboardEvent.ctrlKey;

    modifierKey
        ? window.open(url, '_blank', 'noreferrer')
        : window.location.href = url;
  }
}
