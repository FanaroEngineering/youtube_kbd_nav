import 'dart:html' show document, KeyboardEvent, ParagraphElement;

import 'package:mockito/mockito.dart' show Mock;
import 'package:test/test.dart' show expect, group, setUp, setUpAll, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart'
    show Cycler, KbdHandler, Ui;

void main() {
  setUpAll(() {
    for (int i = 0; i < 4; i++) {
      document.body.append(ParagraphElement());
    }
  });

  group('Thumbnail Cycling |', () {
    Cycler cycler;
    KbdHandler kbdHandler;

    setUp(() {
      cycler = Cycler();
      kbdHandler = KbdHandler(cycler: cycler);
    });

    test('Pressing `z` moves the cycler forwards', () {
      final KeyboardEvent keyboardEvent = MockKeyboardEvent(key: 'z');

      kbdHandler.onKeyPress(keyboardEvent);

      expect(cycler.index, 0);
    });

    test('Pressing `x` moves the cycler backwards', () {
      final KeyboardEvent keyboardEventForwards = MockKeyboardEvent(key: 'z');
      final KeyboardEvent keyboardEventBackwards = MockKeyboardEvent(key: 'x');

      kbdHandler.onKeyPress(keyboardEventForwards);
      kbdHandler.onKeyPress(keyboardEventForwards);
      kbdHandler.onKeyPress(keyboardEventForwards);
      kbdHandler.onKeyPress(keyboardEventBackwards);

      expect(cycler.index, 1);
    });
  });

  group('UI |', () {
    test('Testing if it indeed changes the UI', () {
      final Ui ui = Ui(tag: 'p');
      final KbdHandler kbdHandler = KbdHandler(ui: ui);

      final KeyboardEvent keyboardEventForwards = MockKeyboardEvent(key: 'z');

      kbdHandler.onKeyPress(keyboardEventForwards);
      kbdHandler.onKeyPress(keyboardEventForwards);

      final String newStyle = document.querySelector('p').attributes['style'];

      expect(newStyle, 'outline: red solid; outline-offset: -1px;');
    });
  });
}

class MockKeyboardEvent extends Mock implements KeyboardEvent {
  final String _key;

  MockKeyboardEvent({String key}) : _key = key;

  String get key => _key;
}
