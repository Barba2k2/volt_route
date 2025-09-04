import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/authenticate_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// BLoC for authentication functionality
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticateUser _authenticateUser;
  final AuthRepository _authRepository;

  AuthBloc({
    required AuthenticateUser authenticateUser,
    required AuthRepository authRepository,
  })  : _authenticateUser = authenticateUser,
        _authRepository = authRepository,
        super(const AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInAnonymouslyRequested>(_onSignInAnonymouslyRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<RestoreSessionRequested>(_onRestoreSessionRequested);
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result = await _authenticateUser(
        AuthenticateUserParams.email(
          email: event.email,
          password: event.password,
        ),
      );

      if (result.isError()) {
        emit(
          AuthError(
            message: result.exceptionOrNull()?.toString() ?? 'Unknown error',
          ),
        );
        return;
      }

      final user = result.getOrThrow();
      emit(
        AuthAuthenticated(user: user),
      );
    } catch (e) {
      emit(
        AuthError(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result = await _authenticateUser(AuthenticateUserParams.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      ));

      if (result.isError()) {
        emit(
          AuthError(
            message: result.exceptionOrNull()?.toString() ?? 'Unknown error',
          ),
        );
        return;
      }

      final user = result.getOrThrow();
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(
        AuthError(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onSignInAnonymouslyRequested(
    SignInAnonymouslyRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result =
          await _authenticateUser(AuthenticateUserParams.anonymous());

      if (result.isError()) {
        emit(
          AuthError(
            message: result.exceptionOrNull()?.toString() ?? 'Unknown error',
          ),
        );
        return;
      }

      final user = result.getOrThrow();
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(
        AuthError(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final result = await _authRepository.signOut();

      if (result.isError()) {
        emit(
          AuthError(
            message: result.exceptionOrNull()?.toString() ?? 'Unknown error',
          ),
        );
        return;
      }

      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(
        AuthError(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onRestoreSessionRequested(
    RestoreSessionRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result = await _authRepository.restoreSession();

      if (result.isError()) {
        emit(
          AuthError(
            message: result.exceptionOrNull()?.toString() ?? 'Unknown error',
          ),
        );
        return;
      }

      final user = result.getOrThrow();
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(
        AuthError(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> _onUpdateProfileRequested(
    UpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state is! AuthAuthenticated) return;

    try {
      final result = await _authRepository.updateProfile(
        name: event.name,
        email: event.email,
      );

      if (result.isError()) {
        emit(
          AuthError(
            message: result.exceptionOrNull()?.toString() ?? 'Unknown error',
          ),
        );
        return;
      }

      final updatedUser = result.getOrThrow();
      emit(AuthAuthenticated(user: updatedUser));
    } catch (e) {
      emit(
        AuthError(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
