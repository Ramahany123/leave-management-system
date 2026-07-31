// lib/core/errors/exceptions.dart
class UrlLaunchException implements Exception {
  final String url;
  final String message;

  const UrlLaunchException(this.url, [this.message = 'Failed to launch URL']);

  @override
  String toString() => '$message: $url';
}
