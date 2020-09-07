import 'dart:html'
    show Document, document, DomParser, Element, KeyboardEvent, KeyEvent;

import 'package:meta/meta.dart' show required;
import 'package:mockito/mockito.dart' show Mock;
import 'package:test/test.dart' show expect, group, test;

void main() {
  group('Cycling Thumbnails |', () {
    final Document doc =
        DomParser().parseFromString('<button></button>', 'text/html');

    final Element button = doc.querySelector('button');

    test('', () {
      // document.onKeyDown
      //     .listen((KeyboardEvent keyboardEvent) => print(keyboardEvent.key));

      // document.dispatchEvent(MockKeyboardEvent(key: 'z'));

      // final KeyboardEvent keyboardEvent = KeyEvent.wrap(KeyboardEvent('keypress', location: 69));

      // final Stream<KeyEvent> stream = KeyEvent.keyPressEvent.forTarget(doc);

      // stream.

      // print(keyboardEvent.key);

      // doc.dispatchEvent(KeyboardEvent('keypress', location: 69));
      // doc.dispatchEvent(keyboardEvent);
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
