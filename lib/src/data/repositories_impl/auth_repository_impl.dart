import 'package:result_dart/result_dart.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/local/isar_datasource.dart';
import '../models/user_dto.dart';
import '../../core/errors/base_exception.dart';
import '../../core/services/logger_service.dart';

/// Implementation of AuthRepository using local storage
class AuthRepositoryImpl implements AuthRepository {
  final IsarDataSource _localDataSource;
  final LoggerService _loggerService;

  const AuthRepositoryImpl({
    required IsarDataSource localDataSource,
    required LoggerService loggerService,
  })  : _localDataSource = localDataSource,
        _loggerService = loggerService;

  @override
  Future<Result<User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // For now, create a mock user since we don't have a real auth service
      // In a real implementation, this would call Firebase Auth or similar
      final user = User(
        id: _generateUserId(),
        email: email,
        name: email.split('@').first,
        isAnonymous: false,
        createdAt: DateTime.now(),
        lastSignInAt: DateTime.now(),
      );

      await _saveUser(user);
      return Success(user);
    } catch (e) {
      final exception = BaseException(
        message: 'Failed to sign in: ${e.toString()}',
      );

      _loggerService.logAuthException(
        exception,
        operation: 'signInWithEmail',
        userId: email,
        metadata: {'email': email},
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<User>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // For now, create a mock user since we don't have a real auth service
      // In a real implementation, this would call Firebase Auth or similar
      final user = User(
        id: _generateUserId(),
        email: email,
        name: name,
        isAnonymous: false,
        createdAt: DateTime.now(),
        lastSignInAt: DateTime.now(),
      );

      await _saveUser(user);
      return Success(user);
    } catch (e) {
      final exception =
          BaseException(message: 'Failed to sign up: ${e.toString()}');

      _loggerService.logAuthException(
        exception,
        operation: 'signUpWithEmail',
        userId: email,
        metadata: {'email': email, 'name': name},
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<User>> signInAnonymously() async {
    try {
      final user = User(
        id: _generateUserId(),
        email: null,
        name: 'Anonymous User',
        isAnonymous: true,
        createdAt: DateTime.now(),
        lastSignInAt: DateTime.now(),
      );

      await _saveUser(user);
      return Success(user);
    } catch (e) {
      final exception = BaseException(
          message: 'Failed to sign in anonymously: ${e.toString()}');

      _loggerService.logAuthException(
        exception,
        operation: 'signInAnonymously',
        userId: null,
        metadata: null,
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      // Clear current user flag
      final currentUser = await _localDataSource.getCurrentUser();
      if (currentUser != null) {
        currentUser.isCurrentUser = false;
        await _localDataSource.updateUser(currentUser);
      }

      return const Success(());
    } catch (e) {
      final exception =
          BaseException(message: 'Failed to sign out: ${e.toString()}');

      _loggerService.logAuthException(
        exception,
        operation: 'signOut',
        userId: null,
        metadata: null,
        stackTrace: StackTrace.current,
      );

      return Failure(exception);
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final userDto = await _localDataSource.getCurrentUser();
      if (userDto == null) {
        return const Failure(BaseException(message: 'No user found'));
      }

      final user = userDto.toEntity();
      return Success(user);
    } catch (e) {
      return Failure(
        BaseException(
          message: 'Failed to get current user: ${e.toString()}',
          data: e,
        ),
      );
    }
  }

  @override
  Future<Result<User>> restoreSession() async {
    try {
      // For now, just return the current user from local storage
      // In a real implementation, this would validate the session with the server
      return await getCurrentUser();
    } catch (e) {
      return Failure(
        BaseException(
          message: 'Failed to restore session: ${e.toString()}',
          data: e,
        ),
      );
    }
  }

  @override
  Future<Result<void>> resetPassword(String email) async {
    try {
      // For now, just return success since we don't have a real auth service
      // In a real implementation, this would call Firebase Auth or similar
      return const Success(());
    } catch (e) {
      return Failure(
        BaseException(
          message: 'Failed to reset password: ${e.toString()}',
          data: e,
        ),
      );
    }
  }

  @override
  Future<Result<User>> updateProfile({
    String? name,
    String? email,
  }) async {
    try {
      final currentUserResult = await getCurrentUser();
      if (currentUserResult.isError()) {
        return Failure(currentUserResult.exceptionOrNull()!);
      }

      final currentUser = currentUserResult.getOrThrow();

      final updatedUser = currentUser.copyWith(
        name: name ?? currentUser.name,
        email: email ?? currentUser.email,
      );

      await _saveUser(updatedUser);
      return Success(updatedUser);
    } catch (e) {
      return Failure(
        BaseException(
          message: 'Failed to update profile: ${e.toString()}',
          data: e,
        ),
      );
    }
  }

  /// Saves a user to local storage and sets them as current user
  Future<void> _saveUser(User user) async {
    // Clear current user flag from all users
    await _localDataSource.clearAllUsers();

    // Save the new user as current user
    final userDto = UserDto.fromEntity(user);
    userDto.isCurrentUser = true;
    await _localDataSource.saveUser(userDto);
  }

  /// Generates a unique user ID
  String _generateUserId() {
    return 'user_${DateTime.now().millisecondsSinceEpoch}';
  }
}
