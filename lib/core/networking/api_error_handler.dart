import 'package:dio/dio.dart';
import 'errors/failures.dart';

class ApiErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const ServerFailure('Connection timed out. Please try again.');
        case DioExceptionType.badResponse:
          return _handleStatusCode(error.response);
        case DioExceptionType.cancel:
          return const ServerFailure('Request was cancelled by the client.');
        case DioExceptionType.connectionError:
          return const NetworkFailure('No internet connection detected.');
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          return const ServerFailure('An unexpected network error occurred.');
      }
    }
    return ServerFailure('An unknown error occurred: $error');
  }

  static Failure _handleStatusCode(Response? response) {
    if (response == null) {
      return const ServerFailure('Unknown server error occurred.');
    }

    final int statusCode = response.statusCode ?? 0;

    final String apiMessage =
        response.data?["data"]["message"] ?? "Server Error";
    return switch (statusCode) {
      401 => const UnauthenticatedFailure(),
      404 => NotFoundFailure(apiMessage),
      500 || 502 || 503 => const ServerFailure('Internal server error.'),
      _ => ServerFailure('Error $statusCode: $apiMessage'),
    };
  }
}
