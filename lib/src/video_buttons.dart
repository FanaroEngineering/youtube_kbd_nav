import 'dart:html' show document, Element;

class VideoButtons {
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
