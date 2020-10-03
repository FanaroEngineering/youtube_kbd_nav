import 'dart:html' show DivElement, Document, DomParser;

import 'package:test/test.dart' show expect, group, setUp, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Player;

void main() {
  final Document document =
      DomParser().parseFromString(videoPlayerHtmlsAsString, 'text/html');
  final DivElement playerDiv = document.querySelector('div');

  Player player;

  setUp(() => player = Player(doc: document));

  group('Player Decoration |', () {
    test('Decorate unfocused player', () {
      player.decorateUnfocusedPlayer();

      expect(playerDiv.style.borderBottom, '0.5px solid rgb(72, 61, 139)');
      expect(playerDiv.style.borderWidth, '0.5px');
    });

    test('Decorate focused player', () {
      player.decorateFocusedPlayer();

      expect(playerDiv.style.borderBottom, '0.5px solid rgb(255, 140, 0)');
      expect(playerDiv.style.borderWidth, '0.5px');
    });
  });
}

const String videoPlayerHtmlsAsString = '''
  <div id="movie_player">
    <video></video>
  </div>
''';
