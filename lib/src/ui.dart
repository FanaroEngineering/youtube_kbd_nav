import 'dart:html' show document, Element, Node;

import 'package:meta/meta.dart' show required;

class Ui {
  List<Node> _nodes;
  int _currentIndex;

  Ui({@required String tags}) : _nodes = document.getElementsByTagName(tags);

  void addBorder({@required int currentIndex}) {
    _currentIndex = currentIndex;
    _deleteNeighborsStyles();
    _changeCurrentThumbnailStyle();
  }

  void _changeCurrentThumbnailStyle() {
    if (_currentIndex >= 0) {
      final Element thumbnail = _nodes[_currentIndex] as Element;
      thumbnail.style.outline = 'red solid';
      thumbnail.style.outlineOffset = '-1px';
    }
  }

  void _deleteNeighborsStyles() {
    _nodes?.forEach((Node node) {
      final Element element = node as Element;
      element.attributes.remove('style');
    });
  }
}
