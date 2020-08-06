import 'dart:html';

import 'package:meta/meta.dart';

class MainPage {
  final Document _document;
  List<Element> _thumbnails;
  int _currentThumbnailIndex = -1;

  /// The `tag` parameter only exists because the `document.registerElement()`
  /// doesn't work as expected in Dart apparently &mdash; and neither does the
  /// other more up-to-date option: `window.customElements.define()`. That all 
  /// makes testing kind of a pain. However, having a `tag` parameter might be 
  /// useful for making this class more versatile.
  MainPage({
    @required Document input,
    String tag = 'ytd-rich-item-renderer',
  }) : _document = input {
    _thumbnails = _document.querySelectorAll(tag);
  }

  Element get _currentThumbnail => _thumbnails[_currentThumbnailIndex];

  void addBorderToNext() {
    _deleteCurrentThumbnailCss();
    _selectNextThumbnail();
    _changeCurrentThumbnailStyle();
  }

  void _deleteCurrentThumbnailCss() => _currentThumbnailIndex >= 0
      ? _currentThumbnail.attributes.remove('style')
      : null;

  void _selectNextThumbnail() => _currentThumbnailIndex++;

  void _changeCurrentThumbnailStyle() {
    _currentThumbnail.style.outline = 'solid red';
    _currentThumbnail.style.outlineOffset = '-1px';
  }

  String get currentThumbnailLink {
    if (_currentThumbnailIndex >= 0) {
      return _currentThumbnail.querySelector('a').attributes['href'];
    } else {
      return '';
    }
  }
}