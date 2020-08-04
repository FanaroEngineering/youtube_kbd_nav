import 'dart:html';

import 'package:html/dom.dart';
import 'package:meta/meta.dart';

class YoutubeMainPage {
  final Document _document;
  int currentThumbnailIndex = -1;

  YoutubeMainPage({
    @required Document input,
  }) : _document = input;

  void addBorderToNext() {
    final Element currentThumbnail = _selectNextThumbnail();
    currentThumbnail.attributes['style'] = 'color: red';
  }

  Element _selectNextThumbnail() {
    currentThumbnailIndex++;
    final List<Element> thumbnails =
        _document.querySelectorAll('ytd-rich-item-renderer');
    return thumbnails[currentThumbnailIndex];
  }
}
