part of 'colleges_cubit.dart';

@immutable
sealed class CollegesState {}

final class CollegesInitial extends CollegesState {}

final class CollegesLoading extends CollegesState {}

final class CollegesSuccess extends CollegesState {
  final List<CollegeModel> colleges;

  CollegesSuccess({required this.colleges});
}

final class CollegesError extends CollegesState {
  final Failure failure;

  CollegesError({required this.failure});
}
