class Cycler {
  int _total = -1;

  int get total => _total;

  void forwards() => _total++;

  void backwards() {
    if (_total > 0) _total--;
  }
}
