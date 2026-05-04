import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response<T>> getRequest<T>({
    required String apiEndpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(apiEndpoint, queryParameters: queryParameters);
  }
}
