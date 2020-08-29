class Cycler {
  int _index = -1;

  int get index => _index;

  void forwards() => _index++;

  void backwards() {
    if (_index > 0) _index--;
  }
}
