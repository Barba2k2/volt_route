part of 'auth_bloc.dart';

/// Base class for all authentication events
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to sign in with email and password
final class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

/// Event to sign up with email, password, and name
final class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, name];
}

/// Event to sign in anonymously
final class SignInAnonymouslyRequested extends AuthEvent {
  const SignInAnonymouslyRequested();
}

/// Event to sign out
final class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}

/// Event to restore session
final class RestoreSessionRequested extends AuthEvent {
  const RestoreSessionRequested();
}

/// Event to update user profile
final class UpdateProfileRequested extends AuthEvent {
  final String? name;
  final String? email;

  const UpdateProfileRequested({
    this.name,
    this.email,
  });

  @override
  List<Object?> get props => [name, email];
}
