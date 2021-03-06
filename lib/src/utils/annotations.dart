import 'package:meta/meta.dart' show immutable;

@immutable
class VisibleForTesting {
  final String description;

  const VisibleForTesting([this.description = '']);

  const VisibleForTesting.document()
      : this('Makes it easier/possible for testing.');
}

@immutable
class NecessaryInterop {
  final String description;

  const NecessaryInterop([this.description = '']);
}
