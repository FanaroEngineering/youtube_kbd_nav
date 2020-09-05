import 'dart:html' show Document, DomParser;

import 'package:test/test.dart' show expect, test;

import 'package:youtube_kbd_nav/src/video_buttons.dart' show VideoButtons;

void main() {
  final Document document =
      DomParser().parseFromString(buttonsHtmlAsString, 'text/html');

  VideoButtons videoButtons;

  test('', () {
    
  });
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
''';

//     group('Clicking Buttons |', () {
//       const Map<String, String> buttonsClasses = {
//         'subscribe': 'subscribe',
//         'like': 'likeDislike',
//         'dislike': 'likeDislike',
//         'notificationPopUp': 'notificationPopUp',
//       };

//       final Map<String, ButtonElement> buttons = {};
//       buttonsClasses.forEach((String key, String className) =>
//           buttons.addAll({key: ButtonElement()..className = className}));

//       buttons
//           .forEach((_, ButtonElement button) => document.body.append(button));

//       test('Subscribe', () {
//         ChangesOnClick changesOnSubscribe;

//         buttons['subscribe']
//             .onClick
//             .listen((_) => changesOnSubscribe = ChangesOnClick.subscribed);

//         ui.subscribe(query: 'button.${buttonsClasses['subscribe']}');

//         expect(changesOnSubscribe, ChangesOnClick.subscribed);
//       });

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

// enum ChangesOnClick {
//   subscribed,
//   like,
//   dislike,
//   notificationPopUp,
// }
