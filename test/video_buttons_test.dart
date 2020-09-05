import 'dart:html' show Document, DomParser, Element;

import 'package:test/test.dart' show expect, setUp, test;

import 'package:youtube_kbd_nav/src/video_buttons.dart' show VideoButtons;

void main() {
  final Document document =
      DomParser().parseFromString(buttonsHtmlAsString, 'text/html');

  VideoButtons videoButtons;

  setUp(() => videoButtons = VideoButtons(doc: document));

  test('Subscribe', () {
    ChangesOnClick changesOnSubscribe;

    final Element subscribeButton = document.querySelector('paper-button');

    subscribeButton.onClick
        .listen((_) => changesOnSubscribe = ChangesOnClick.subscribed);

    videoButtons.subscribe();

    expect(changesOnSubscribe, ChangesOnClick.subscribed);
  });

  test('Like', () {
    ChangesOnClick changesOnLike;

    final Element likeButton = document.querySelectorAll('button')[0];

    likeButton.onClick.listen((_) => changesOnLike = ChangesOnClick.like);

    videoButtons.like();

    expect(changesOnLike, ChangesOnClick.like);
  });

  test('Dislike', () {
    ChangesOnClick changesOnDislike;

    final Element likeButton = document.querySelectorAll('button')[1];

    likeButton.onClick.listen((_) => changesOnDislike = ChangesOnClick.dislike);

    videoButtons.dislike();

    expect(changesOnDislike, ChangesOnClick.dislike);
  });
}

enum ChangesOnClick {
  subscribed,
  like,
  dislike,
  notificationPopUp,
}

const String buttonsHtmlAsString = '''
  <ytd-menu-renderer>
    <div>
      <ytd-toggle-button-renderer>
        <a>
          <yt-icon-button>
            <button></button>
          </yt-icon-button>
        </a>
      </ytd-toggle-button-renderer>
      <ytd-toggle-button-renderer>
        <a>
          <yt-icon-button>
            <button></button>
          </yt-icon-button>
        </a>
      </ytd-toggle-button-renderer>
    </div>
  </ytd-menu-renderer>
  <div id="subscribe-button" class="style-scope">
    <ytd-subscribe-button-renderer>
      <paper-button>
    </ytd-subscribe-button-renderer>
  </div>
''';

//       test('Notification Pop Up', () {
//         ChangesOnClick changesOnNotificationPopUp;

//         buttons['notificationPopUp'].onClick.listen((Event _) =>
//             changesOnNotificationPopUp = ChangesOnClick.notificationPopUp);

//         ui.notiticationPopUp(
//             query: 'button.${buttonsClasses['notificationPopUp']}');

//         expect(changesOnNotificationPopUp, ChangesOnClick.notificationPopUp);
//       });
//     });
//   });
