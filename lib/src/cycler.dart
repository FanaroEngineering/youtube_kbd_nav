class Cycler {
  int _index = -1;

  int get index => _index;

  void forward() => _index++;

  void backward() => _index <= 0 ? null : _index--;
}
