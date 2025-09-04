import 'package:equatable/equatable.dart';

/// Base class for all failures
abstract class DomainFailure extends Equatable {
  final String message;
  final String? code;
  final dynamic details;

  const DomainFailure({
    required this.message,
    this.code,
    this.details,
  });

  @override
  List<Object?> get props => [message, code, details];
}

/// Network-related failures
class NetworkFailure extends DomainFailure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.details,
  });
}

/// Authentication-related failures
class AuthFailure extends DomainFailure {
  const AuthFailure({
    required super.message,
    super.code,
    super.details,
  });
}

/// Calculation-related failures
class CalculationFailure extends DomainFailure {
  const CalculationFailure({
    required super.message,
    super.code,
    super.details,
  });
}

/// Not found failures
class NotFoundFailure extends DomainFailure {
  const NotFoundFailure({
    required super.message,
    super.code,
    super.details,
  });
}

/// Server-related failures
class ServerFailure extends DomainFailure {
  const ServerFailure({
    required super.message,
    super.code,
    super.details,
  });
}

/// Cache-related failures
class CacheFailure extends DomainFailure {
  const CacheFailure({
    required super.message,
    super.code,
    super.details,
  });
}

/// Validation failures
class ValidationFailure extends DomainFailure {
  const ValidationFailure({
    required super.message,
    super.code,
    super.details,
  });
}

/// Generic failures
class GenericFailure extends DomainFailure {
  const GenericFailure({
    required super.message,
    super.code,
    super.details,
  });
}
