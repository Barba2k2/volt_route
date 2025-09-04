import 'base_exception.dart';

class DefaultException extends BaseException {
  const DefaultException({
    required super.message,
    super.code,
    super.data,
  });
}
