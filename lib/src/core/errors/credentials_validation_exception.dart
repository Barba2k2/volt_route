import 'base_exception.dart';

/// Exception for credential validation errors
class CredentialsValidationException extends BaseException {
  final List<String> validationErrors;

  const CredentialsValidationException({
    required super.message,
    this.validationErrors = const [],
  });

  @override
  String toString() =>
      'CredentialsValidationException: $message\nErrors: ${validationErrors.join(', ')}';
}
