import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:leave_management_system/core/networking/dio_factory.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';
import 'package:leave_management_system/features/auth/data/web_services/auth_web_services.dart';
import 'package:leave_management_system/features/auth/logic/cubit/auth_cubit.dart';
import 'package:leave_management_system/features/employee_dashboard/data/repo/employee_dashboard_repo.dart';
import 'package:leave_management_system/features/employee_dashboard/data/web_services/employee_dashboard_web_services.dart';
import 'package:leave_management_system/features/employee_dashboard/logic/cubit/employee_dashboard_cubit.dart';
import '../networking/api_service.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => DioFactory().getDio);
  sl.registerLazySingleton(() => ApiService(sl<Dio>()));

  //Auth dpenedencies
  setupAuthDependencies();
  //Employee Dashboard dpenedencies
  setupEmployeeDashboardDependencies();
}

void setupAuthDependencies() {
  sl.registerLazySingleton(() => AuthWebServices(apiService: sl()));
  sl.registerLazySingleton(() => AuthRepo(authWebServices: sl()));
  sl.registerFactory(() => AuthCubit(authRepo: sl()));
}

void setupEmployeeDashboardDependencies() {
  sl.registerLazySingleton(
    () => EmployeeDashboardWebServices(apiService: sl()),
  );
  sl.registerLazySingleton(
    () => EmployeeDashboardRepo(employeeDashboardWebServices: sl()),
  );
  sl.registerFactory(() => EmployeeDashboardCubit(employeeDashboardRepo: sl()));
}
