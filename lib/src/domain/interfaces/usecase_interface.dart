import 'package:result_dart/result_dart.dart';

/// Base interface for use cases
abstract class UseCase<S extends Object, P extends Object> {
  Future<Result<S>> call(P params);
}

/// Use case with no parameters
abstract class UseCaseNoParams<S extends Object> {
  Future<Result<S>> call();
}
