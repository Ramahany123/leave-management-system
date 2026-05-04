import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../networking/api_endpoints.dart';
import '../networking/api_service.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  sl.registerLazySingleton(() => dio);

  sl.registerLazySingleton(() => ApiService(sl<Dio>()));
}
