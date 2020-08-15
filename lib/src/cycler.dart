class Cycler {
  int _index = -1;

  int get index => _index;

  void forwards() => _index++;

  void backwards() => _index <= 0 ? null : _index--;
}
