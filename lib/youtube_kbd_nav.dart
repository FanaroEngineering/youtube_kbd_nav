import 'dart:html';

import 'package:meta/meta.dart';

class YoutubeMainPage {
  final Document _document;
  List<Element> _thumbnails;
  int _currentThumbnailIndex = -1;

  /// The `tag` parameter only exists because the `document.registerElement`
  /// doesn't work as expected in Dart apparently &mdash; and neither does the
  /// other more up-to-date option: `window.customElements.define`.
  YoutubeMainPage({
    @required Document input,
    String tag = 'ytd-rich-item-renderer',
  }) : _document = input {
    _thumbnails = _document.querySelectorAll(tag);
  }

  Element get _thumbnailFromCurrentIndex => _thumbnails[_currentThumbnailIndex];

  void addBorderToNext() {
    _deleteCurrentThumbnailCss();
    _selectNextThumbnail();
    _changeCurrentThumbnailStyle();
  }

  void _deleteCurrentThumbnailCss() => _currentThumbnailIndex >= 0
      ? _thumbnailFromCurrentIndex.attributes.remove('style')
      : null;

  void _selectNextThumbnail() => _currentThumbnailIndex++;

  void _changeCurrentThumbnailStyle() {
    final Element currentThumbnail = _thumbnailFromCurrentIndex;
    currentThumbnail.style.border = 'solid';
    currentThumbnail.style.borderColor = 'red';
  }
}
