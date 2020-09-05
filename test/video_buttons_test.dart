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

    final Element subscribeButton =
        document.querySelector('#subscribe-button.style-scope > '
            'ytd-subscribe-button-renderer > paper-button');

    subscribeButton.onClick
        .listen((_) => changesOnSubscribe = ChangesOnClick.subscribed);

    videoButtons.subscribe();

    expect(changesOnSubscribe, ChangesOnClick.subscribed);
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
            <button>
          </yt-icon-button>
        </a>
      </ytd-toggle-button-renderer>
      <ytd-toggle-button-renderer>
        <a>
          <yt-icon-button>
            <button>
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

//       test('Like', () {
//         ChangesOnClick changesOnLike;

//         buttons['like']
//             .onClick
//             .listen((_) => changesOnLike = ChangesOnClick.like);

//         ui.like(query: 'button.${buttonsClasses['like']}');

//         expect(changesOnLike, ChangesOnClick.like);
//       });

//       test('Dislike', () {
//         ChangesOnClick changesOnDislike;

//         buttons['dislike']
//             .onClick
//             .listen((_) => changesOnDislike = ChangesOnClick.dislike);

//         ui.dislike(query: 'button.${buttonsClasses['dislike']}');

//         expect(changesOnDislike, ChangesOnClick.dislike);
//       });

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
