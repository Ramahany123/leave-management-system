import 'package:dio/dio.dart';
import 'package:leave_management_system/core/cache/secure_storage_helper.dart';
import 'package:leave_management_system/core/constants/app_constants.dart';
import 'package:leave_management_system/core/networking/api_endpoints.dart';

class DioFactory {
  late final Dio _dio;

  DioFactory() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );
    _addDioInterceptor();
  }

  Dio get getDio => _dio;

  void _addDioInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? token = await SecureStorageHelper.getData(
            key: CacheKeys.userToken,
          );

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );
  }
}
