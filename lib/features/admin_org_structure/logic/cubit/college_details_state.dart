part of 'college_details_cubit.dart';

@immutable
sealed class CollegeDetailsState {}

final class CollegeDetailsInitial extends CollegeDetailsState {}

final class CollegeDetailsLoading extends CollegeDetailsState {}

final class CollegeDetailsSuccess extends CollegeDetailsState {
  final CollegeModel college;

  CollegeDetailsSuccess({required this.college});
}

final class CollegeDetailsError extends CollegeDetailsState {
  final Failure failure;

  CollegeDetailsError({required this.failure});
}
