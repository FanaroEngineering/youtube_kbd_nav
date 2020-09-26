import 'package:test/test.dart' show expect, group, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Cycle;

void main() {
  group('Logic |', () {
    test('Index starts at -1', () => expect(const Cycle().total, -1));

    test('Going forwards', () {
      Cycle cycles = const Cycle() + const Cycle();

      expect(cycles, const Cycle(total: 0));
    });

    test('Going forwards beyond max keeps it in the max', () {
      Cycle cycles = const Cycle(max: 1);

      cycles += const Cycle();
      cycles += const Cycle();
      cycles += const Cycle();

      expect(cycles, const Cycle(total: 1));
    });

    test('Cannot go before -1', () {
      Cycle cycles = const Cycle();

      cycles -= const Cycle();

      expect(cycles, const Cycle());
    });

    test('Cannot go before -1 even after having added cycles', () {
      Cycle cycles = const Cycle();

      cycles += const Cycle();
      cycles -= const Cycle();
      cycles -= const Cycle();
      cycles -= const Cycle();

      expect(cycles, const Cycle());
    });

    test('Going forwards 3 times and then backwards once returns 1', () {
      Cycle cycles = const Cycle();

      cycles += const Cycle();
      cycles += const Cycle();
      cycles += const Cycle();
      cycles -= const Cycle();

      expect(cycles, Cycle(total: 1));
    });

    test('Getter for being in valid range', () {
      Cycle cycles = const Cycle();

      expect(cycles.isValid, false);

      cycles += const Cycle();

      expect(cycles.isValid, true);
    });
  });

  group('Printing |', () {
    test(
        '`toString`',
        () =>
            expect(const Cycle().toString(), 'Cycle | total: -1 | max: 100'));
  });
}
