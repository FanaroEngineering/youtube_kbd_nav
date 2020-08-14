import 'dart:html';

import 'package:meta/meta.dart';

enum NextOrPrevious {
  previous,
  next,
}

class Page {
  final Document _document;
  List<Element> _thumbnails;
  int _currentThumbnailIndex = -1;

  /// The `tag` parameter only exists because the `document.registerElement()`
  /// doesn't work as expected in Dart apparently &mdash; and neither does the
  /// other more up-to-date option: `window.customElements.define()`. That all
  /// makes testing kind of a pain. However, having a `tag` parameter might be
  /// useful for making this class more versatile.
  Page({
    @required Document input,
    String tag = 'ytd-rich-item-renderer',
  }) : _document = input {
    _thumbnails = _document.querySelectorAll(tag);
  }

  Element get _currentThumbnail => _thumbnails[_currentThumbnailIndex];

  void addBorder(NextOrPrevious nextOrPrevious) {
    print(_thumbnails.length);
    _deleteCurrentThumbnailCss();
    _selectPreviousOrNextThumbnail(nextOrPrevious);
    _changeCurrentThumbnailStyle();
  }

  void _deleteCurrentThumbnailCss() => _currentThumbnailIndex >= 0
      ? _currentThumbnail.attributes.remove('style')
      : null;

  void _selectPreviousOrNextThumbnail(NextOrPrevious nextOrPrevious) {
    switch (nextOrPrevious) {
      case NextOrPrevious.next:
        _selectNextThumbnail();
        break;
      case NextOrPrevious.previous:
        _selectPreviousThumbnail();
        break;
    }
  }

  void _selectNextThumbnail() => _currentThumbnailIndex < _thumbnails.length - 1
      ? _currentThumbnailIndex++
      : null;
  void _selectPreviousThumbnail() =>
      _currentThumbnailIndex > 0 ? _currentThumbnailIndex-- : null;

  void _changeCurrentThumbnailStyle() {
    if (_currentThumbnailIndex >= 0) {
      _currentThumbnail.style.outline = 'solid red';
      _currentThumbnail.style.outlineOffset = '-1px';
    }
  }

  String get currentThumbnailLink {
    if (_currentThumbnailIndex >= 0) {
      return _currentThumbnail.querySelector('a').attributes['href'];
    } else {
      return '';
    }
  }
}
