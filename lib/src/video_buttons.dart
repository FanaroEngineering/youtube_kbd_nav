import 'dart:html' show Document, document, Element;

class VideoButtons {
  final Document _document;

  /// [doc] is a parameter mainly for injecting a [Document] during tests.
  VideoButtons({Document doc}) : _document = doc ?? document;

  void subscribe() {
    const String subscribeQuery = '#subscribe-button.style-scope > '
        'ytd-subscribe-button-renderer > paper-button';
    final Element subscribeButton = _document.querySelector(subscribeQuery);
    subscribeButton?.click();
  }

  void like() {
    final Element likeButton =
        _document.querySelectorAll(_likeDislikeButtons)[0];
    likeButton?.click();
  }

  static const String _likeDislikeButtons = 'ytd-menu-renderer > div > '
      'ytd-toggle-button-renderer > a > yt-icon-button > button';

  void dislike() {
    final Element dislikeButton =
        _document.querySelectorAll(_likeDislikeButtons)[1];
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
