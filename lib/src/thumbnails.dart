import 'dart:html' show AnchorElement, Document, document, Element;

import 'package:meta/meta.dart' show required;

import 'cycle.dart';

class Thumbnails {
  final List<Element> _thumbnails;
  Cycle _cycles;

  /// [doc] is a parameter mainly for injecting a `Document` during tests.
  Thumbnails({@required String tags, Cycle cycles, Document doc})
      : _thumbnails = (doc ?? document).querySelectorAll(tags) {
    _cycles = cycles ?? Cycle(max: _thumbnails.length);
  }

  Cycle get cycles => _cycles;

  void operator +(Cycle cycle) {
    _cycles += Cycle();
    print(_cycles.total);
    _addBorder();
  }

  void operator -(Cycle cycle) {
    _cycles -= Cycle();
    _addBorder();
  }

  void _addBorder() {
    _deleteNeighborsStyles();
    _changeCurrentThumbnailStyle();
    _currentThumbnail?.scrollIntoView();
  }

  void _deleteNeighborsStyles() {
    final List<int> neighborsIndices = [_cycles.total - 1, _cycles.total + 1];

    neighborsIndices.forEach((int neighborIndex) {
      if (_neighborIndexValidRange(neighborIndex))
        _thumbnails[neighborIndex].attributes.remove('style');
    });
  }

  bool _neighborIndexValidRange(int neighborIndex) =>
      neighborIndex >= 0 && neighborIndex < _cycles.max;

  void _changeCurrentThumbnailStyle() {
    _currentThumbnail.style.outline = 'red solid';
    _currentThumbnail.style.outlineOffset = '-1px';
  }

  Element get _currentThumbnail => _thumbnails[_cycles.total];

  void resetCurrentThumbnail() =>
      _currentThumbnail?.attributes?.remove('style');

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
}
