import 'dart:html'
    show
        CustomEvent,
        Document,
        document,
        DomParser,
        Element,
        KeyboardEvent,
        KeyEvent;

import 'package:meta/meta.dart' show required;
import 'package:mockito/mockito.dart' show Mock;
import 'package:test/test.dart' show expect, group, test;

void main() {
  group('Cycling Thumbnails |', () {
    final Document doc =
        DomParser().parseFromString('<button></button>', 'text/html');

    final Element button = doc.querySelector('button');

    test('', () {
      button.onKeyDown
          .listen((KeyboardEvent keyboardEvent) => print(keyboardEvent.key));

      // 1. Create custom event listener with keypress handling logic
      button.on['keypress'].listen((data) {
        print('Heyyy! ${(data as CustomEvent).detail['keyCode']}');
      });

      // 2. Create custom keypress event
      final customKeypress =
          CustomEvent('keypress', detail: {'keyCode': 65, 'charCode': 97});

      // 3. Amend original onKeyPress handling logic
      button.onKeyPress.listen((data) {
        document.dispatchEvent(customKeypress);
      });
    });
  });
}

class MockKeyboardEvent extends Mock implements KeyboardEvent {
  // @override
  final String _key;

  MockKeyboardEvent({String key}) : _key = key;

  // @override
  String get key => _key;
}
