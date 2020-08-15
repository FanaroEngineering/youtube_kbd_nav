import 'package:test/test.dart';

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart';

void main() {
  group('Cycler\'s Logic |', () {
    Cycler cycler;

    setUp(() => cycler = Cycler());

    test('Index starts at -1', () {
      expect(cycler.index, -1);
    });

    test('Going forward adds to the index', () {
      cycler.forward();

      expect(cycler.index, 0);

      cycler.forward();

      expect(cycler.index, 1);
    });

    test('Cannot go back -1', () {
      cycler.backward();

      expect(cycler.index, -1);
    });

    test('Cannot go back 0 after having added', () {
      cycler.forward();
      cycler.backward();

      expect(cycler.index, 0);
    });

    test('Going forward 3 times and then backward returns 1', () {
      cycler.forward();
      cycler.forward();
      cycler.forward();
      cycler.backward();

      expect(cycler.index, 1);
    });
  });
}