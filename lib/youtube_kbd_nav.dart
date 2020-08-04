import 'dart:html';

import 'package:html/dom.dart';
import 'package:meta/meta.dart';

class YoutubeMainPage {
  final Document _document;
  int _currentThumbnailIndex = -1;

  YoutubeMainPage({
    @required Document input,
  }) : _document = input;

  void addBorderToNext() {
    final Element currentThumbnail = _selectNextThumbnail();
    currentThumbnail.attributes['style'] = _css;
  }

  Element _selectNextThumbnail() {
    final List<Element> thumbnails =
        _document.querySelectorAll('ytd-rich-item-renderer');
    if (_currentThumbnailIndex >= 0) {
      thumbnails[_currentThumbnailIndex].attributes.remove('style');
    }
    _currentThumbnailIndex++;
    return thumbnails[_currentThumbnailIndex];
  }
}

extension ThumbnailCss on YoutubeMainPage {
  String get _css => 'color: red';
}