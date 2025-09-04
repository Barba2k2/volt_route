/// Base exception class for all custom exceptions
class BaseException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  const BaseException({
    required this.message,
    this.code,
    this.data,
  });

  @override
  String toString() => 'BaseException: $message';
}
