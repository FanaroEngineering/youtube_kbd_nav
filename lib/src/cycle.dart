import 'package:meta/meta.dart' show immutable;

/// When an operation of `+` or `-` is made, the new [Cycle] will carry on the
/// previous [max] value.
@immutable
class Cycle {
  final int total, max;

  const Cycle({this.total = -1, this.max = 10000});

  Cycle operator +(Cycle cycle) =>
      Cycle(total: total < max ? total + 1 : total, max: max);

  Cycle operator -(Cycle cycle) =>
      Cycle(total: total > -1 ? total - 1 : total, max: max);

  @override
  bool operator ==(Object cycle) => cycle is Cycle && total == cycle.total;

  @override
  int get hashCode => total.hashCode;

  @override
  String toString() => 'Cycle: total: $total, max: $max';
}
