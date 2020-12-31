import 'dart:html' show AnchorElement, Document, document, Element;

import 'package:meta/meta.dart' show immutable;

import '../utils/annotations.dart' show VisibleForTesting;

enum DescriptionState { showMore, showLess }

@immutable
class VideoButtons {
  final DescriptionState _descriptionState;
  final Document _document;

  VideoButtons({
    DescriptionState descriptionState = DescriptionState.showLess,
    @VisibleForTesting.document() Document doc,
  })  : _descriptionState = descriptionState,
        _document = doc ?? document;

  void toggleSubscription() {
    const String unsubscribeQuery =
        'paper-button.style-blue-text > yt-formatted-string';
    final Element ytFormattedStrings = document.querySelector(unsubscribeQuery);
    const String subscribedQuery =
        'paper-button.ytd-subscribe-button-renderer > yt-formatted-string';
    final Element subscribed = document.querySelector(subscribedQuery);
    if (subscribed?.text?.toLowerCase() == 'subscribed' &&
        ytFormattedStrings?.text?.toLowerCase() == 'unsubscribe') {
      ytFormattedStrings?.click();
    } else {
      const String subscribeQuery = '#subscribe-button.style-scope > '
          'ytd-subscribe-button-renderer > paper-button';
      final Element subscribeButton = _document.querySelector(subscribeQuery);
      subscribeButton?.click();
    }
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
        _document.querySelectorAll(notificationPopUpButtonQuery)[0];
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

  VideoButtons toggleDescription() {
    DescriptionState newDescriptionState;
    switch (_descriptionState) {
      case DescriptionState.showLess:
        final Element showMoreButton =
            _document.querySelector('paper-button#more');
        showMoreButton?.click();
        newDescriptionState = DescriptionState.showMore;
        break;
      case DescriptionState.showMore:
        final Element showLessButton =
            _document.querySelector('paper-button#less');
        showLessButton?.click();
        newDescriptionState = DescriptionState.showLess;
        break;
    }
    return VideoButtons(doc: _document, descriptionState: newDescriptionState);
  }
}
