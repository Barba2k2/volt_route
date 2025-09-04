import 'package:result_dart/result_dart.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';
import '../interfaces/usecase_interface.dart';
import '../../core/errors/base_exception.dart';
import '../../core/services/logger_service.dart';

/// Use case for authenticating a user
class AuthenticateUser implements UseCase<User, AuthenticateUserParams> {
  final AuthRepository _authRepository;
  final LoggerService _loggerService;

  const AuthenticateUser({
    required AuthRepository authRepository,
    required LoggerService loggerService,
  })  : _authRepository = authRepository,
        _loggerService = loggerService;

  @override
  Future<Result<User>> call(AuthenticateUserParams params) async {
    try {
      Result<User> result;

      switch (params.authType) {
        case AuthType.email:
          result = await _authRepository.signInWithEmail(
            email: params.email!,
            password: params.password!,
          );
          break;
        case AuthType.signUp:
          result = await _authRepository.signUpWithEmail(
            email: params.email!,
            password: params.password!,
            name: params.name!,
          );
          break;
        case AuthType.anonymous:
          result = await _authRepository.signInAnonymously();
          break;
      }

      if (result.isError()) {
        return Failure(result.exceptionOrNull()!);
      }

      return Success(result.getOrThrow());
    } catch (e) {
      final exception = BaseException(
          message: 'Failed to authenticate user: ${e.toString()}');

      _loggerService.logException(
        exception,
        context: 'AuthenticateUser UseCase',
        additionalData: {
          'authType': params.authType.toString(),
          'email': params.email,
        },
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }
}

/// Parameters for authenticating a user
class AuthenticateUserParams {
  final AuthType authType;
  final String? email;
  final String? password;
  final String? name;

  const AuthenticateUserParams({
    required this.authType,
    this.email,
    this.password,
    this.name,
  });

  factory AuthenticateUserParams.email({
    required String email,
    required String password,
  }) {
    return AuthenticateUserParams(
      authType: AuthType.email,
      email: email,
      password: password,
    );
  }

  factory AuthenticateUserParams.signUp({
    required String email,
    required String password,
    required String name,
  }) {
    return AuthenticateUserParams(
      authType: AuthType.signUp,
      email: email,
      password: password,
      name: name,
    );
  }

  factory AuthenticateUserParams.anonymous() {
    return const AuthenticateUserParams(
      authType: AuthType.anonymous,
    );
  }
}

/// Types of authentication
enum AuthType {
  email,
  signUp,
  anonymous,
}
