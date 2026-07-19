part of 'upload_signature_cubit.dart';

@immutable
sealed class UploadSignatureState {}

final class UploadSignatureInitial extends UploadSignatureState {}

final class UploadSignatureLoading extends UploadSignatureState {}

final class UploadSignatureSuccess extends UploadSignatureState {
  final UploadSignatureResponseModel uploadSignatureResponse;

  UploadSignatureSuccess({required this.uploadSignatureResponse});
}

final class UploadSignatureError extends UploadSignatureState {
  final Failure failure;

  UploadSignatureError({required this.failure});
}
