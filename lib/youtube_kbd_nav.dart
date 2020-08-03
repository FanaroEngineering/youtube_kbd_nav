import 'dart:html';

import 'package:meta/meta.dart';

@immutable
class Thumbnails {
  final String _input;

  const Thumbnails({
    @required String input,
  }) : _input = input;

  ElementList<Element> get recommendedThumbnails =>
      document.querySelectorAll('ytd-rich-item-renderer');
}
