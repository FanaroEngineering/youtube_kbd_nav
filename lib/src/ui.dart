import 'dart:html' show AnchorElement, document, Element;

import 'package:meta/meta.dart' show required;

class Ui {
  List<Element> _elements;
  int _currentIndex;

  Ui({@required String tags}) : _elements = document.querySelectorAll(tags);

  void addBorder({@required int currentIndex}) {
    _currentIndex = currentIndex;
    _deleteNeighborsStyles();
    _changeCurrentThumbnailStyle();
    _currentThumbnail?.scrollIntoView();
  }

  Element get _currentThumbnail => (_currentIndex != null && _currentIndex >= 0)
      ? _elements[_currentIndex]
      : null;

  String get thumbnailLink {
    final AnchorElement anchorElement = _currentThumbnail?.querySelector('a');
    return anchorElement?.href;
  }

  void resetCurrentThumbnail() {
    _currentThumbnail?.attributes?.remove('style');
    _currentIndex = null;
  }

  void _changeCurrentThumbnailStyle() {
    if (_currentIndex >= 0) {
      _currentThumbnail.style.outline = 'red solid';
      _currentThumbnail.style.outlineOffset = '-1px';
    }
  }

  void _deleteNeighborsStyles() {
    final List<int> neighborsIndices = [_currentIndex - 1, _currentIndex + 1];

    neighborsIndices.forEach((int neighborIndex) {
      if (_neighborIndexInValidRange(neighborIndex))
        _elements[neighborIndex].attributes.remove('style');
    });
  }

  bool _neighborIndexInValidRange(int neighborIndex) =>
      neighborIndex >= 0 && neighborIndex < _elements.length;

  static const String _subscribeButton =
      '#subscribe-button.style-scope > ytd-subscribe-button-renderer > '
      'paper-button';

  /// The [query] parameter is here for 2 reasons:
  ///
  /// 1. The HTML hierarchy changes when you're signed in or not, apparently.
  /// 1. With a parameter, we can inject a simpler tag when testing.
  void subscribe({String query = _subscribeButton}) {
    final Element subscribeButton = document.querySelector(query);

    subscribeButton?.click();
  }

  static const String _likeDislikeButtons =
      'ytd-menu-renderer > div > ytd-toggle-button-renderer > '
      'a > yt-icon-button > button';

  /// Check out the [subscribe] method for more info.
  void like({String query = _likeDislikeButtons}) {
    final Element likeButton = document.querySelectorAll(query)[0];

    likeButton?.click();
  }

  /// Check out the [subscribe] method for more info.
  void dislike({String query = _likeDislikeButtons}) {
    final Element dislikeButton = document.querySelectorAll(query)[1];

    dislikeButton?.click();
  }

  static const String _notificationPopUpButton =
      'ytd-notification-topbar-button-renderer > div > a > '
      'yt-icon-button > button';

  /// Check out the [subscribe] method for more info.
  void notiticationPopUp({String query = _notificationPopUpButton}) {
    final Element notificationPopUpButton = document.querySelector(query);

    notificationPopUpButton?.click();
  }
}
