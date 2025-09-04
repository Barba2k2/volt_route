part of 'auth_bloc.dart';

/// Base class for all authentication states
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the auth module starts
final class AuthInitial extends AuthState {
  const AuthInitial();
}

/// State when authentication is in progress
final class AuthLoading extends AuthState {
  const AuthLoading();
}

/// State when user is successfully authenticated
final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

/// State when user is authenticated (alias for AuthSuccess)
final class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

/// State when authentication fails
final class AuthFailure extends AuthState {
  final String message;
  final Exception? exception;

  const AuthFailure({
    required this.message,
    this.exception,
  });

  @override
  List<Object?> get props => [message, exception];
}

/// State when authentication has an error (alias for AuthFailure)
final class AuthError extends AuthState {
  final String message;
  final Exception? exception;

  const AuthError({
    required this.message,
    this.exception,
  });

  @override
  List<Object?> get props => [message, exception];
}

/// State when user is signed out / unauthenticated
final class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

/// State when user is unauthenticated (alias for AuthSignedOut)
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// State when session is restored
final class AuthSessionRestored extends AuthState {
  final User user;

  const AuthSessionRestored({required this.user});

  @override
  List<Object> get props => [user];
}

/// State when profile is updated
final class AuthProfileUpdated extends AuthState {
  final User user;

  const AuthProfileUpdated({required this.user});

  @override
  List<Object> get props => [user];
}
