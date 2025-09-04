// ignore_for_file: overridden_fields

import 'base_exception.dart';

class ServerException extends BaseException {
  @override
  final String message;
  final String error;
  final String? stackTrace;

  ServerException({
    required this.message,
    required this.error,
    this.stackTrace,
  }) : super(message: message);
}
