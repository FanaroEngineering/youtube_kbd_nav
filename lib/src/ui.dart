import 'dart:html' show document, Element;

import 'package:meta/meta.dart' show required;

class Ui {
  List<Element> _elements;
  int _currentIndex;

  Ui({@required String tags}) : _elements = document.querySelectorAll(tags);

  void addBorder({@required int currentIndex}) {
    _currentIndex = currentIndex;
    _deleteNeighborsStyles();
    _changeCurrentThumbnailStyle();
  }

  void _changeCurrentThumbnailStyle() {
    if (_currentIndex >= 0) {
      final Element thumbnail = _elements[_currentIndex];
      thumbnail.style.outline = 'red solid';
      thumbnail.style.outlineOffset = '-1px';
    }
  }

  void _deleteNeighborsStyles() {
    final List<int> neighborsIndices = [_currentIndex - 1, _currentIndex + 1];
    neighborsIndices.forEach((int neighborIndex) {
      neighborIndex >= 0 && neighborIndex < _elements.length
          ? _elements[neighborIndex].attributes.remove('style')
          : null;
    });
  }
}
