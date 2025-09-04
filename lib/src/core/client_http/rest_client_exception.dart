import 'rest_client_http_message.dart';
import 'rest_client_response.dart';
import '../errors/base_exception.dart';

class RestClientException extends BaseException
    implements RestClientHttpMessage {
  final dynamic error;
  final RestClientResponse? response;
  final String? statusCode;

  RestClientException({
    required super.message,
    this.statusCode,
    required this.error,
    this.response,
  });
}
