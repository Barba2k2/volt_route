import 'base_exception.dart';

class NotFoundException extends BaseException {
  final int statusCode;

  NotFoundException({
    required super.message,
    this.statusCode = 404,
  });
}
