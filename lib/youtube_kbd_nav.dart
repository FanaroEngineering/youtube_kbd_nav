import 'dart:html';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';

@immutable
class Thumbnails {
  final Document _document;

  Thumbnails({
    @required String input,
  }) : _document = parse(input);

  List<Element> get recommendedThumbnails =>
      _document.querySelectorAll('ytd-rich-item-renderer');
}
