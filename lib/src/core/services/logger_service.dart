import 'package:logger/logger.dart';
import '../errors/base_exception.dart';

/// Logger service for handling application logging, especially exceptions
class LoggerService {
  late final Logger _logger;

  LoggerService() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        noBoxingByDefault: false, // Disable the boxing of log messages
        excludeBox: const {}, // Exclude specific log levels from boxing
      ),
    );
  }

  /// Log debug message
  void debug(String message, {dynamic data, StackTrace? stackTrace}) {
    _logger.d(message, error: data, stackTrace: stackTrace);
  }

  /// Log info message
  void info(String message, {dynamic data, StackTrace? stackTrace}) {
    _logger.i(message, error: data, stackTrace: stackTrace);
  }

  /// Log warning message
  void warning(String message, {dynamic data, StackTrace? stackTrace}) {
    _logger.w(message, error: data, stackTrace: stackTrace);
  }

  /// Log error message
  void error(String message, {dynamic data, StackTrace? stackTrace}) {
    _logger.e(message, error: data, stackTrace: stackTrace);
  }

  /// Log critical error (What a Terrible Failure)
  void wtf(String message, {dynamic data, StackTrace? stackTrace}) {
    _logger.f(message, error: data, stackTrace: stackTrace);
  }

  /// Log exception with detailed information
  void logException(
    Exception exception, {
    String? context,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalData,
  }) {
    final StringBuffer logMessage = StringBuffer();

    // Add context if provided
    if (context != null) {
      logMessage.writeln('Context: $context');
    }

    // Handle BaseException with additional details
    if (exception is BaseException) {
      logMessage.writeln('Exception Type: ${exception.runtimeType}');
      logMessage.writeln('Message: ${exception.message}');

      if (exception.code != null) {
        logMessage.writeln('Code: ${exception.code}');
      }

      if (exception.data != null) {
        logMessage.writeln('Data: ${exception.data}');
      }
    } else {
      logMessage.writeln('Exception Type: ${exception.runtimeType}');
      logMessage.writeln('Message: ${exception.toString()}');
    }

    // Add additional data if provided
    if (additionalData != null && additionalData.isNotEmpty) {
      logMessage.writeln('Additional Data: $additionalData');
    }

    _logger.e(
      logMessage.toString().trim(),
      error: exception,
      stackTrace: stackTrace,
    );
  }

  /// Log HTTP exception with request/response details
  void logHttpException(
    dynamic exception, {
    String? method,
    String? url,
    int? statusCode,
    Map<String, dynamic>? requestData,
    dynamic responseData,
    Map<String, dynamic>? headers,
    StackTrace? stackTrace,
  }) {
    final StringBuffer logMessage = StringBuffer();

    logMessage.writeln('🛑 HTTP Exception Occurred');
    logMessage.writeln(
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    if (method != null && url != null) {
      logMessage.writeln('🔹 Request: $method $url');
    }

    if (statusCode != null) {
      logMessage.writeln('🔹 Status Code: $statusCode');
    }

    if (headers != null && headers.isNotEmpty) {
      logMessage.writeln('🔹 Headers: $headers');
    }

    if (requestData != null) {
      logMessage.writeln('🔹 Request Data: $requestData');
    }

    if (responseData != null) {
      logMessage.writeln('🔹 Response Data: $responseData');
    }

    logMessage.writeln('🔹 Exception: ${exception.toString()}');
    logMessage.writeln(
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

    _logger.e(
      logMessage.toString().trim(),
      error: exception,
      stackTrace: stackTrace,
    );
  }

  /// Log authentication exception
  void logAuthException(
    Exception exception, {
    String? operation,
    String? userId,
    Map<String, dynamic>? metadata,
    StackTrace? stackTrace,
  }) {
    final StringBuffer logMessage = StringBuffer();

    logMessage.writeln('🔐 Authentication Exception');

    if (operation != null) {
      logMessage.writeln('Operation: $operation');
    }

    if (userId != null) {
      logMessage.writeln('User ID: $userId');
    }

    if (metadata != null && metadata.isNotEmpty) {
      logMessage.writeln('Metadata: $metadata');
    }

    logException(
      exception,
      context: logMessage.toString().trim(),
      stackTrace: stackTrace,
    );
  }

  /// Log cache operation exception
  void logCacheException(
    Exception exception, {
    String? operation,
    String? key,
    dynamic value,
    StackTrace? stackTrace,
  }) {
    final Map<String, dynamic> additionalData = {};

    if (operation != null) additionalData['operation'] = operation;
    if (key != null) additionalData['key'] = key;
    if (value != null) additionalData['value'] = value.toString();

    logException(
      exception,
      context: '💾 Cache Operation Exception',
      additionalData: additionalData,
      stackTrace: stackTrace,
    );
  }

  /// Log database operation exception
  void logDatabaseException(
    Exception exception, {
    String? operation,
    String? table,
    Map<String, dynamic>? data,
    StackTrace? stackTrace,
  }) {
    final Map<String, dynamic> additionalData = {};

    if (operation != null) additionalData['operation'] = operation;
    if (table != null) additionalData['table'] = table;
    if (data != null) additionalData['data'] = data;

    logException(
      exception,
      context: '🗄️ Database Operation Exception',
      additionalData: additionalData,
      stackTrace: stackTrace,
    );
  }

  /// Log validation exception
  void logValidationException(
    Exception exception, {
    String? field,
    dynamic value,
    List<String>? validationErrors,
    StackTrace? stackTrace,
  }) {
    final Map<String, dynamic> additionalData = {};

    if (field != null) additionalData['field'] = field;
    if (value != null) additionalData['value'] = value.toString();
    if (validationErrors != null && validationErrors.isNotEmpty) {
      additionalData['validation_errors'] = validationErrors;
    }

    logException(
      exception,
      context: '✅ Validation Exception',
      additionalData: additionalData,
      stackTrace: stackTrace,
    );
  }

  /// Log performance metrics
  void logPerformance(
    String operation, {
    required Duration duration,
    Map<String, dynamic>? metadata,
  }) {
    final StringBuffer logMessage = StringBuffer();

    logMessage.writeln('⏱️ Performance Metric');
    logMessage.writeln('Operation: $operation');
    logMessage.writeln('Duration: ${duration.inMilliseconds}ms');

    if (metadata != null && metadata.isNotEmpty) {
      logMessage.writeln('Metadata: $metadata');
    }

    _logger.i(logMessage.toString().trim());
  }

  /// Close the logger (if needed for cleanup)
  void close() {
    _logger.close();
  }
}
