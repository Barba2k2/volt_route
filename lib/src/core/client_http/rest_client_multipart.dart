import 'rest_client_http_message.dart';

/// Represents a multipart form data request
class RestClientMultipart implements RestClientHttpMessage {
  final String field;
  final dynamic data;
  final String? filename;
  final String? contentType;

  const RestClientMultipart({
    required this.field,
    required this.data,
    this.filename,
    this.contentType,
  });
}
