import 'dart:html' show AnchorElement, Document, document, Element;

import 'package:meta/meta.dart' show required;

import 'cycle.dart';

class Thumbnails {
  List<Element> _thumbnails;
  Cycle _cycles;
  int _currentIndex;

  /// [doc] is a parameter mainly for injecting a [Document] during tests.
  Thumbnails({@required String tags, Document doc})
      : _thumbnails = (doc ?? document).querySelectorAll(tags);

  void addBorder({@required int index}) {
    _currentIndex = index;
    _deleteNeighborsStyles();
    _changeCurrentThumbnailStyle();
    _currentThumbnail?.scrollIntoView();
  }

  void _deleteNeighborsStyles() {
    final List<int> neighborsIndices = [_currentIndex - 1, _currentIndex + 1];

    neighborsIndices.forEach((int neighborIndex) {
      if (_neighborIndexValidRange(neighborIndex))
        _thumbnails[neighborIndex].attributes.remove('style');
    });
  }

  bool _neighborIndexValidRange(int neighborIndex) =>
      neighborIndex >= 0 && neighborIndex < _thumbnails.length;

  void _changeCurrentThumbnailStyle() {
    if (_currentIndex >= 0 && _currentIndex < _thumbnails.length) {
      _currentThumbnail.style.outline = 'red solid';
      _currentThumbnail.style.outlineOffset = '-1px';
    }
  }

  Element get _currentThumbnail => (_currentIndex != null && _currentIndex >= 0)
      ? _thumbnails[_currentIndex]
      : null;

  void resetCurrentThumbnail() {
    _currentThumbnail?.attributes?.remove('style');
    _currentIndex = null;
  }

  String get thumbnailLink {
    final AnchorElement thumbnailLinkElement =
        _currentThumbnail?.querySelector('a');
    return thumbnailLinkElement?.href;
  }

  String get channelLink {
    final String thumbnailTagName = _currentThumbnail.tagName.toLowerCase();
    final AnchorElement channelLinkElement =
        thumbnailTagName.contains(RegExp('video|rich'))
            ? _currentThumbnail?.querySelectorAll('a')?.last
            : thumbnailTagName.contains('playlist')
                ? _currentThumbnail?.querySelectorAll('a')[2]
                : null;
    return channelLinkElement?.href;
  }

  int get length => _thumbnails.length;
}
