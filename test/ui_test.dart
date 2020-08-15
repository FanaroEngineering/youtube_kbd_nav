import 'dart:html' show document, ParagraphElement;

import 'package:test/test.dart' show expect, group, test;

import 'package:youtube_kbd_nav/youtube_kbd_nav.dart' show Ui;

void main() {
  group('UI |', () {
    test('Adds border to the thumbnail', () {
      document.body.append(ParagraphElement());

      final Ui ui = Ui(tag: 'p');
      ui.addBorder(nthChild: 0);

      final String newStyle = document.querySelector('p').attributes['style'];

      expect(newStyle, 'outline: red solid; outline-offset: -1px;');
    });
  });
}