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

  Element get _searchBar => document.querySelector('input#search');
  Element get _playlistName => document.querySelector('iron-input > input');
  Element get _commentBox => document.querySelectorAll(_commentBoxQuery)[0];
  Element get _editCommentBox => document.querySelectorAll(_commentBoxQuery)[1];
  String get _commentBoxQuery => 'yt-formatted-string.ytd-commentbox > div';

  bool get _noInputFocus => !(_searchBar == document.activeElement ||
      _commentBox == document.activeElement ||
      _editCommentBox == document.activeElement ||
      _playlistName == document.activeElement);

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
          if (_cycler.total >= 0) _navigate(_thumbnails?.thumbnailLink);
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
        case 'y':
          _videoButtons?.notiticationPopUp();
          break;
        case 'b':
          if (_isVideo)
            await window.navigator.clipboard
                .writeText(UrlHandler.shortenLink(_url));
          break;
      }
    }
  }

  // This is necessary because the thumbnails won't be fully loaded when
  // `yt-navigate-start`.
  void _addBorder() {
    _thumbnails = Thumbnails(tags: UrlHandler.tags(_url));
    _thumbnails.addBorder(index: _cycler.total);
  }

  bool get _isVideo => _url.contains('watch');

  void _navigate(String url) {
    final bool modifierKey = window.navigator.appVersion.contains('Mac')
        ? _keyboardEvent.metaKey
        : _keyboardEvent.ctrlKey;

    modifierKey
        ? window.open(url, '_blank', 'noreferrer')
        : window.location.href = url;
  }
}
