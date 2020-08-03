import 'dart:html' as html;
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'package:youtube_kbd_nav/export.dart';

void main() {
  final String youtubeHtml =
      io.File('fixtures/youtube.html').readAsStringSync();

  group('Thumbnail selector', () {
    test('Tests if we extract the correct amount of thumbnails', () {
      final Thumbnails thumbnails = Thumbnails(input: youtubeHtml);
      // final ElementList<Element> recommendedThumbnails =
      //     thumbnails.recommendedThumbnails;

      expect(thumbnails.recommendedThumbnails.length, 104);
    });
  });
}
