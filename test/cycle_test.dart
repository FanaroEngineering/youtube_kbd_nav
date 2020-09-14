import 'package:test/test.dart' show expect, group, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Cycle;

void main() {
  group('Logic |', () {
    test('Index starts at -1', () => expect(Cycle().total, -1));

    test('Going forwards', () {
      Cycle cycles = Cycle() + Cycle();

      expect(cycles, Cycle(total: 0));
    });

    test('Going forwards beyond max keeps it in the max', () {
      Cycle cycles = Cycle(max: 1);

      cycles += Cycle();
      cycles += Cycle();
      cycles += Cycle();

      expect(cycles, Cycle(total: 1));
    });

    test('Cannot go before -1', () {
      Cycle cycles = Cycle();

      cycles -= Cycle();

      expect(cycles, Cycle());
    });

    test('Cannot go before -1 even after having added cycles', () {
      Cycle cycles = Cycle();

      cycles += Cycle();
      cycles -= Cycle();
      cycles -= Cycle();
      cycles -= Cycle();

      expect(cycles, Cycle());
    });

    test('Going forwards 3 times and then backwards once returns 1', () {
      Cycle cycles = Cycle();

      cycles += Cycle();
      cycles += Cycle();
      cycles += Cycle();
      cycles -= Cycle();

      expect(cycles, Cycle(total: 1));
    });

    test('Getter for being in valid range', () {
      Cycle cycles = Cycle();

      expect(cycles.isValid, false);

      cycles += Cycle();

      expect(cycles.isValid, true);
    });
  });

  group('Printing |', () {
    test('`toString`',
        () => expect(Cycle().toString(), 'Cycle: total: -1, max: 10000'));
  });
}
