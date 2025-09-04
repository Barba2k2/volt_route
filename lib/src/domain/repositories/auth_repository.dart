import 'package:result_dart/result_dart.dart';
import '../entities/user.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Signs in a user with email and password
  Future<Result<User>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Signs up a new user with email and password
  Future<Result<User>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  /// Signs in anonymously
  Future<Result<User>> signInAnonymously();

  /// Signs out the current user
  Future<Result<void>> signOut();

  /// Gets the current user
  Future<Result<User>> getCurrentUser();

  /// Restores the user session
  Future<Result<User>> restoreSession();

  /// Resets password for email
  Future<Result<void>> resetPassword(String email);

  /// Updates user profile
  Future<Result<User>> updateProfile({
    String? name,
    String? email,
  });
}
