import '../networking/errors/failures.dart';

sealed class Result<S> {
  T fold<T>(
    T Function(S success) onSuccess,
    T Function(Failure failure) onFailure,
  ) {
    return switch (this) {
      SuccessResult(data: final d) => onSuccess(d),
      FailureResult(failure: final e) => onFailure(e),
    };
  }
}

class SuccessResult<S> extends Result<S> {
  final S data;

  SuccessResult(this.data);
}

class FailureResult<S> extends Result<S> {
  final Failure failure;

  FailureResult(this.failure);
}
