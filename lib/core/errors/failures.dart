/// Sealed hierarchy of typed failures used across the data & BLoC layers.
sealed class Failure {
  final String message;
  const Failure(this.message);
}

/// No internet / socket errors.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}

/// 4xx / 5xx responses from the server.
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

/// Local cache / serialisation errors.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Local cache error.']);
}

/// Anything unexpected.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unexpected error occurred.']);
}
