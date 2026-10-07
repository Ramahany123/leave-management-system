import 'package:leave_management_system/core/networking/api_error_handler.dart';

import 'result.dart';

Future<Result<T>> handleRepositoryCall<T>(Future<T> Function() action) async {
  try {
    final result = await action();
    return SuccessResult(result);
  } catch (e) {
    return FailureResult(ApiErrorHandler.handle(e));
  }
}
