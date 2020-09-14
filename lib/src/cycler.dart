class Cycler {
  static const int _start = -1;

  int _total = _start;

  int get total => _total;

  void forwards() => _total++;

  void backwards() {
    if (_total > _start) _total--;
  }

  @override
  String toString() => 'Cycler: $_total';
}
