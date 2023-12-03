abstract class Failure {
  final String message;

  Failure({required this.message});
}

class DataError extends Failure {
  DataError({required super.message});
}
