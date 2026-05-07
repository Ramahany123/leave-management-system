sealed class Failure {
  final String message;

  const Failure(this.message);
}

// TODO: localize the error messages
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection detected.']);
}

final class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure([
    super.message = 'Wrong Credentials. Please login again.',
  ]);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
