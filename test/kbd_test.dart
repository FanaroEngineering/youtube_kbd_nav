import 'dart:html' show document, KeyboardEvent, ParagraphElement;

import 'package:mockito/mockito.dart' show Mock;
import 'package:test/test.dart' show expect, group, isNull, setUp, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Cycler, Kbd;

void main() {
  for (int i = 0; i < 4; i++) document.body.append(ParagraphElement());

  final KeyboardEvent keyboardEventForwards = MockKeyboardEvent(key: 'z'),
      keyboardEventBackwards = MockKeyboardEvent(key: 'x');

  Cycler cycler;
  Kbd kbdHandler;

  setUp(() {
    cycler = Cycler();
    kbdHandler = Kbd(cycler: cycler);
  });

  group('Thumbnail Cycling |', () {
    test('Pressing `z` moves the cycler forwards', () async {
      await kbdHandler.onKeyDown(keyboardEventForwards);

      print(cycler.total);

      expect(cycler.total, 0);
    });

    test('Pressing `x` moves the cycler backwards', () async {
      await kbdHandler.onKeyDown(keyboardEventForwards);
      await kbdHandler.onKeyDown(keyboardEventForwards);
      await kbdHandler.onKeyDown(keyboardEventForwards);
      await kbdHandler.onKeyDown(keyboardEventBackwards);

      expect(cycler.total, 1);
    });
  }, skip: true);

  group('UI |', () {
    test('Testing if it indeed changes the UI', () async {
      await kbdHandler.onKeyDown(keyboardEventForwards);
      await kbdHandler.onKeyDown(keyboardEventForwards);

      final String style0 =
          document.querySelectorAll('p')[0].attributes['style'];
      final String style1 =
          document.querySelectorAll('p')[1].attributes['style'];

      expect(style0, '');
      expect(style1, 'outline: red solid; outline-offset: -1px;');
    });

    test('Navigating to a new YouTube page resets the UI', () async {
      await kbdHandler.onKeyDown(keyboardEventForwards);

      final String styleBefore =
          document.querySelectorAll('p')[0].attributes['style'];

      expect(styleBefore, 'outline: red solid; outline-offset: -1px;');

      kbdHandler.resetStylesAndCycler();

      final String styleAfter =
          document.querySelectorAll('p')[0].attributes['style'];

      expect(styleAfter, isNull);
    });
  }, skip: true);
}

class MockKeyboardEvent extends Mock implements KeyboardEvent {
  final String _key;

  MockKeyboardEvent({String key}) : _key = key;

  String get key => _key;
}
