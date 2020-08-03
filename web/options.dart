import 'dart:html';

void main() {
  document.body.append(HeadingElement.h1()..text = 'Options page loaded');

  document.head.append(StyleElement()..text = '''
  h1 {
    color: green;
  }
  ''');
}
