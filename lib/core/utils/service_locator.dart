import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:leave_management_system/core/networking/dio_factory.dart';
import 'package:leave_management_system/features/auth/data/repo/auth_repo.dart';
import 'package:leave_management_system/features/auth/data/web_services/auth_web_services.dart';
import 'package:leave_management_system/features/auth/logic/cubit/auth_cubit.dart';
import 'package:leave_management_system/features/auth/logic/cubit/change_password_cubit.dart';
import 'package:leave_management_system/features/employee_dashboard/data/repo/employee_dashboard_repo.dart';
import 'package:leave_management_system/features/employee_dashboard/data/web_services/employee_dashboard_web_services.dart';
import 'package:leave_management_system/features/employee_dashboard/logic/cubit/employee_dashboard_cubit.dart';
import 'package:leave_management_system/features/leave_history/data/repo/leave_history_repo.dart';
import 'package:leave_management_system/features/leave_history/data/web_services/leave_history_web_services.dart';
import 'package:leave_management_system/features/leave_history/logic/cubit/leave_history_cubit.dart';
import 'package:leave_management_system/features/leave_history/logic/cubit/leave_request_details_cubit.dart';
import 'package:leave_management_system/features/profile/data/repo/profile_repo.dart';
import 'package:leave_management_system/features/profile/logic/cubit/profile_cubit.dart';
import 'package:leave_management_system/features/profile/logic/cubit/update_contact_cubit.dart';
import '../../features/profile/data/web_services/profile_web_services.dart';
import '../networking/api_service.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => DioFactory().getDio);
  sl.registerLazySingleton(() => ApiService(sl<Dio>()));

  //Auth dpenedencies
  setupAuthDependencies();
  //Employee Dashboard dpenedencies
  setupEmployeeDashboardDependencies();

  setupLeaveHistoryDependencies();

  setupProfileDependencies();
}

void setupAuthDependencies() {
  sl.registerLazySingleton(() => AuthWebServices(apiService: sl()));
  sl.registerLazySingleton(() => AuthRepo(authWebServices: sl()));
  sl.registerFactory(() => AuthCubit(authRepo: sl()));
  sl.registerFactory(() => ChangePasswordCubit(authRepo: sl()));
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

void setupLeaveHistoryDependencies() {
  sl.registerLazySingleton(() => LeaveHistoryWebServices(apiService: sl()));
  sl.registerLazySingleton(
    () => LeaveHistoryRepo(leaveHistoryWebServices: sl()),
  );
  sl.registerFactory(() => LeaveHistoryCubit(leaveHistoryRepo: sl()));
  sl.registerFactory(() => LeaveRequestDetailsCubit(leaveHistoryRepo: sl()));
}

void setupProfileDependencies() {
  sl.registerLazySingleton(() => ProfileWebServices(apiService: sl()));
  sl.registerLazySingleton(() => ProfileRepo(profileWebServices: sl()));
  sl.registerFactory(() => ProfileCubit(profileRepo: sl()));
  sl.registerFactory(() => UpdateContactCubit(profileRepo: sl()));
}
