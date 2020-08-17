import 'dart:html' show document, KeyboardEvent, ParagraphElement;

import 'package:mockito/mockito.dart' show Mock;
import 'package:test/test.dart'
    show expect, group, isNull, setUp, setUpAll, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Cycler, KbdHandler;

void main() {
  setUpAll(() {
    for (int i = 0; i < 4; i++) document.body.append(ParagraphElement());
  });

  final KeyboardEvent keyboardEventForwards = MockKeyboardEvent(key: 'z');
  final KeyboardEvent keyboardEventBackwards = MockKeyboardEvent(key: 'x');

  Cycler cycler;
  KbdHandler kbdHandler;

  setUp(() {
    cycler = Cycler();
    kbdHandler = KbdHandler(cycler: cycler);
  });

  group('Thumbnail Cycling |', () {
    test('Pressing `z` moves the cycler forwards', () {
      kbdHandler.onKeyPress(keyboardEventForwards);

      expect(cycler.index, 0);
    });

    test('Pressing `x` moves the cycler backwards', () {
      kbdHandler.onKeyPress(keyboardEventForwards);
      kbdHandler.onKeyPress(keyboardEventForwards);
      kbdHandler.onKeyPress(keyboardEventForwards);
      kbdHandler.onKeyPress(keyboardEventBackwards);

      expect(cycler.index, 1);
    });
  });

  group('UI |', () {
    test('Testing if it indeed changes the UI', () {
      kbdHandler.onKeyPress(keyboardEventForwards);
      kbdHandler.onKeyPress(keyboardEventForwards);

      final String style0 =
          document.querySelectorAll('p')[0].attributes['style'];
      final String style1 =
          document.querySelectorAll('p')[1].attributes['style'];

      expect(style0, '');
      expect(style1, 'outline: red solid; outline-offset: -1px;');
    });

    test('Navigating to a new YouTube page resets the UI', () {
      kbdHandler.onKeyPress(keyboardEventForwards);

      final String styleBefore =
          document.querySelectorAll('p')[0].attributes['style'];

      expect(styleBefore, 'outline: red solid; outline-offset: -1px;');

      kbdHandler.resetStylesAndCycler();

      final String styleAfter =
          document.querySelectorAll('p')[0].attributes['style'];

      expect(styleAfter, isNull);
    });
  });
}

class MockKeyboardEvent extends Mock implements KeyboardEvent {
  final String _key;

  MockKeyboardEvent({String key}) : _key = key;

  String get key => _key;
}
