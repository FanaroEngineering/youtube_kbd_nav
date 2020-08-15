import 'dart:html';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart';

void main() {
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
}

class MockKeyboardEvent extends Mock implements KeyboardEvent {
  final String _key;

  MockKeyboardEvent({String key}): _key = key;

  String get key => _key;
}