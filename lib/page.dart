import 'dart:html';

import 'package:meta/meta.dart';

enum NextOrPrevious {
  previous,
  next,
}

class Page {
  final Document _document;
  List<Element> _thumbnails;
  int _currentThumbnailIndex;

  Page({
    @required Document input,
    String tag = 'ytd-rich-item-renderer',
    int index = -1,
  }) : _document = input {
    _thumbnails = _document.querySelectorAll(tag);
    _thumbnails
        .forEach((Element element) => element.attributes.remove('style'));
    _currentThumbnailIndex = index < -1 ? -1 : index;
  }

  Element get _currentThumbnail => _thumbnails[_currentThumbnailIndex];

  void addBorder(NextOrPrevious nextOrPrevious) {
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

  String get currentThumbnailLink => _currentThumbnailIndex >= 0
      ? _prefixOrNot(_currentThumbnail.querySelector('a')?.attributes['href'])
      : '';

  String _prefixOrNot(String link) =>
      link.contains('http') ? link : 'https://www.youtube.com' + link;
}
