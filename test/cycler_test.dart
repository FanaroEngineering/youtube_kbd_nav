import 'package:test/test.dart' show expect, group, setUp, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Cycler;

void main() {
  group('Logic |', () {
    Cycler cycler;

    setUp(() => cycler = Cycler());

    test('Index starts at -1', () => expect(cycler.total, -1));

    test('Going forward adds to the index', () {
      cycler.forwards();

      expect(cycler.total, 0);

      cycler.forwards();

      expect(cycler.total, 1);
    });

    test('Cannot go back -1', () {
      cycler.backwards();

      expect(cycler.total, -1);
    });

    test('Cannot go back 0 after having added', () {
      cycler.forwards();
      cycler.backwards();

      expect(cycler.total, 0);
    });

    test('Going forward 3 times and then backward returns 1', () {
      cycler.forwards();
      cycler.forwards();
      cycler.forwards();
      cycler.backwards();

      expect(cycler.total, 1);
    });
  });

  group('Printing |', () {
    test('`toString`', () {
      final Cycler cycler = Cycler();

      expect(cycler.toString(), 'Cycler: ${cycler.total}');
    });
  });
}
