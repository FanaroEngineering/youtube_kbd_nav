import 'dart:html' show AnchorElement, Document, document, Element;

import 'package:meta/meta.dart' show immutable, required;

import '../utils/annotations.dart' show VisibleForTesting;
import 'cycle.dart' show Cycle;

@immutable
class Thumbnails {
  final String _tags;
  final List<Element> _thumbnails;
  final Document _document;
  final Cycle _cycles;

  Thumbnails({
    @required tags,
    Cycle cycles,
    @VisibleForTesting.document() Document doc,
  })  : _tags = tags,
        _document = doc ?? document,
        _thumbnails = (doc ?? document).querySelectorAll(tags),
        _cycles = cycles ?? Cycle();

  void addToWatchLater() {
    const String popupRendererQuery = 'ytd-menu-popup-renderer';
    final Element popupRenderer = document.querySelector(popupRendererQuery);
    popupRenderer == document.activeElement
        ? _clickOnWatchLater()
        : _clickOnThreeDots();
  }

  void _clickOnThreeDots() {
    const String threeDotsQuery = 'yt-icon.ytd-menu-renderer';
    final Element threeDotsIconButton =
        _currentThumbnail?.querySelector(threeDotsQuery);
    threeDotsIconButton?.click();
  }

  void _clickOnWatchLater() {
    const String popUpButtonsQuery = 'ytd-menu-popup-renderer > '
        'paper-listbox paper-item > yt-formatted-string';
    final List<Element> popUpButtons =
        document.body.querySelectorAll(popUpButtonsQuery);
    if (popUpButtons.isNotEmpty) {
      popUpButtons?.forEach((Element element) {
        if (element.text.toLowerCase().contains('save to watch later')) {
          element.click();
          document.body.click();
        }
      });
    }
  }

  Cycle get cycles => _cycles;

  Thumbnails operator +(Cycle cycle) {
    final Cycle newCycles = _cycles + const Cycle();
    return _resetThumbnails(newCycles);
  }

  Thumbnails _resetThumbnails(Cycle newCycles) {
    final Thumbnails newThumbnails = Thumbnails(
      tags: _tags,
      cycles: Cycle(total: newCycles.total, max: _thumbnails.length),
      doc: _document,
    );
    newThumbnails._addBorder();
    return newThumbnails;
  }

  Thumbnails operator -(Cycle cycle) {
    final Cycle newCycles = _cycles - const Cycle();
    return _resetThumbnails(newCycles);
  }

  void _addBorder() {
    _deleteNeighborsStyles();
    if (_cycles.isValid) {
      _changeCurrentThumbnailStyle();
      _currentThumbnail?.scrollIntoView();
    }
  }

  void _deleteNeighborsStyles() {
    final List<int> neighborsIndices = [_cycles.total - 1, _cycles.total + 1];

    neighborsIndices.forEach((int neighborIndex) {
      if (_neighborIndexValidRange(neighborIndex))
        _thumbnails[neighborIndex].removeAttribute('style');
    });
  }

  bool _neighborIndexValidRange(int neighborIndex) =>
      neighborIndex >= 0 && neighborIndex < _cycles.max;

  void _changeCurrentThumbnailStyle() {
    _currentThumbnail.style.outline = 'red solid';
    _currentThumbnail.style.outlineOffset = '-1px';
  }

  Element get _currentThumbnail =>
      _cycles.isValid ? _thumbnails[_cycles.total] : null;

  void resetCurrentThumbnail() => _currentThumbnail?.removeAttribute('style');

  String get thumbnailLink => _cycles.isValid
      ? (_currentThumbnail?.querySelector('a') as AnchorElement)?.href
      : null;

  String get channelLink {
    if (_cycles.isValid) {
      final String thumbnailTagName = _currentThumbnail.tagName.toLowerCase();
      final AnchorElement channelLinkElement =
          thumbnailTagName.contains(RegExp('video|rich'))
              ? _currentThumbnail?.querySelectorAll('a')?.last
              : thumbnailTagName.contains('playlist')
                  ? _currentThumbnail?.querySelectorAll('a')[2]
                  : null;
      return channelLinkElement?.href;
    } else {
      return null;
    }
  }
}
