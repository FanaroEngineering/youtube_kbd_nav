import 'dart:html' show document, Element, Node;

import 'package:meta/meta.dart' show immutable, required;

@immutable
class Ui {
  final List<Node> _tagNodes;

  Ui({@required String tag}) : _tagNodes = document.getElementsByTagName(tag);

  void addBorder({@required int nthChild}) {
    if (nthChild >= 0) {
      final Element thumbnail = _tagNodes.elementAt(nthChild) as Element;
      thumbnail.style.outline = 'red solid';
      thumbnail.style.outlineOffset = '-1px';
    }
  }
}
