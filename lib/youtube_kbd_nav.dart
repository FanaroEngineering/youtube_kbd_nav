import 'dart:html';

import 'package:html/dom.dart';
import 'package:meta/meta.dart';

class YoutubeMainPage {
  final Document _document;
  List<Element> _thumbnails;
  int _currentThumbnailIndex = -1;

  YoutubeMainPage({
    @required Document input,
  }) : _document = input {
    _thumbnails = _document.querySelectorAll('ytd-rich-item-renderer');
  }

  Element get _thumbnailFromCurrentIndex => _thumbnails[_currentThumbnailIndex];

  void addBorderToNext() {
    _deleteCurrentThumbnailCss();
    final Element currentThumbnail = _selectNextThumbnail();
    currentThumbnail.attributes['style'] = _css;
  }

  void _deleteCurrentThumbnailCss() => _currentThumbnailIndex >= 0
      ? _thumbnailFromCurrentIndex.attributes.remove('style')
      : null;

  Element _selectNextThumbnail() {
    _currentThumbnailIndex++;
    return _thumbnailFromCurrentIndex;
  }
}

extension ThumbnailCss on YoutubeMainPage {
  String get _css => 'color: red';
}
