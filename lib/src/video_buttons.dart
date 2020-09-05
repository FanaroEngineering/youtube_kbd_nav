import 'dart:html' show Document, document, Element;

class VideoButtons {
  final Document _document;

  /// [doc] is a parameter mainly for injecting a [Document] during tests.
  VideoButtons({Document doc}) : _document = doc ?? document;

  /// The [query] parameter is here for 2 reasons:
  ///
  /// 1. The HTML hierarchy changes when you're signed in or not, apparently.
  /// 1. With a parameter, we can inject a simpler tag when testing.
  void subscribe() {
    const String subscribeQuery = '#subscribe-button.style-scope > '
        'ytd-subscribe-button-renderer > paper-button';
    final Element subscribeButton = _document.querySelector(subscribeQuery);
    subscribeButton?.click();
  }

  static const String _likeDislikeButtons =
      'ytd-menu-renderer > div > ytd-toggle-button-renderer > '
      'a > yt-icon-button > button';

  /// Check out the [subscribe] method for more info.
  void like({String query = _likeDislikeButtons}) {
    final Element likeButton = _document.querySelectorAll(query)[0];

    likeButton?.click();
  }

  /// Check out the [subscribe] method for more info.
  void dislike({String query = _likeDislikeButtons}) {
    final Element dislikeButton = _document.querySelectorAll(query)[1];

    dislikeButton?.click();
  }

  static const String _notificationPopUpButton =
      'ytd-notification-topbar-button-renderer > div > a > '
      'yt-icon-button > button';

  /// Check out the [subscribe] method for more info.
  void notiticationPopUp({String query = _notificationPopUpButton}) {
    final Element notificationPopUpButton = _document.querySelector(query);

    notificationPopUpButton?.click();
  }
}
