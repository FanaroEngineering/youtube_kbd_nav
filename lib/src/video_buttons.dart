import 'dart:html' show AnchorElement, Document, document, Element;

enum DescriptionState { showMore, showLess }

class VideoButtons {
  final Document _document;
  DescriptionState _descriptionState = DescriptionState.showLess;

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
        _document.querySelectorAll(_likeDislikeButtonsQuery).first;
    likeButton?.click();
  }

  static const String _likeDislikeButtonsQuery = 'ytd-menu-renderer > div > '
      'ytd-toggle-button-renderer > a > yt-icon-button > button';

  void dislike() {
    final Element dislikeButton =
        _document.querySelectorAll(_likeDislikeButtonsQuery).last;
    dislikeButton?.click();
  }

  void notiticationPopUp() {
    const String notificationPopUpButtonQuery =
        'ytd-notification-topbar-button-renderer > '
        'div > a > yt-icon-button > button';
    final Element notificationPopUpButton =
        _document.querySelector(notificationPopUpButtonQuery);
    notificationPopUpButton?.click();
  }

  /// This has not been incorporated via TDD. (Couldn't make it work with
  /// `focus()` this time.)
  void commentBoxFocus() {
    final List<Element> commentBoxes = _document
        .querySelectorAll('#simplebox-placeholder, div.yt-formatted-string');
    final Element commentBox =
        commentBoxes.length == 1 ? commentBoxes.first : commentBoxes.last;
    commentBox == document.activeElement
        ? commentBox?.blur() // currently not working...
        : commentBox?.focus();
    commentBox?.scrollIntoView();
  }

  String get channelLink {
    final AnchorElement channelAnchorElement =
        _document.querySelector('.ytd-channel-name > a') as AnchorElement;
    return channelAnchorElement?.href;
  }

  void toggleDescription() {
    switch (_descriptionState) {
      case DescriptionState.showLess:
        final Element showMoreButton =
            _document.querySelector('paper-button#more');
        showMoreButton.click();
        _descriptionState = DescriptionState.showMore;
        break;
      case DescriptionState.showMore:
        final Element showLessButton =
            _document.querySelector('paper-button#less');
        showLessButton.click();
        _descriptionState = DescriptionState.showLess;
        break;
    }
  }
}
