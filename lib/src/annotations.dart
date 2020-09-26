class VisibleForTesting {
  final String description;

  const VisibleForTesting([this.description = '']);

  const VisibleForTesting.document()
      : this('Makes it easier/possible for testing.');
}
