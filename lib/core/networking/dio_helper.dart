import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class DioHelper {
  Dio? dio;

  DioHelper() {
    _initDio();
  }

  _initDio() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        },
      ),
    );
  }

  getRequest({required String endpoint}) async {
    try {
      Response response = await dio!.get(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  postRequest({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await dio!.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
