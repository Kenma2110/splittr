import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:splittr/features/auth/domain/repositories/auth_repository.dart';
import 'package:splittr/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:splittr/features/auth/domain/usecases/logout_usecase.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc(
    this._checkAuthStatusUseCase,
    this._logoutUseCase,
    this._authRepository,
  ) : super(const AuthState.initial(store: AuthStateStore()));

  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final LogoutUseCase _logoutUseCase;
  final AuthRepository _authRepository;

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
    on<_AuthStatusChecked>(_onAuthStatusChecked);
    on<_LoggedOut>(_onLoggedOut);
    on<_LoginAsGuest>(_onLoginAsGuest);
    on<_Logout>(_onLogout);
  }

  FutureOr<void> _onStarted(_Started event, Emitter<AuthState> emit) {}

  FutureOr<void> _onAuthStatusChecked(
    _AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    final isGuest = await _authRepository.isGuestUser();
    if (isGuest) {
      emit(AuthState.guest(store: state.store));
      return;
    }

    final userOrFailure = await _checkAuthStatusUseCase.call(noParams);

    userOrFailure.fold(
      (failure) => emit(AuthState.onUserUnauthenticated(store: state.store)),
      (user) => emit(AuthState.authenticated(store: state.store)),
    );
  }

  FutureOr<void> _onLoggedOut(_LoggedOut event, Emitter<AuthState> emit) async {
    await _logoutUseCase.call(noParams);

    emit(const AuthState.onLogout(store: AuthStateStore()));
  }

  FutureOr<void> _onLoginAsGuest(
    _LoginAsGuest event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.saveGuestSession();

    result.fold(
      (failure) => emit(
        AuthState.onFailure(store: state.store, failure: failure),
      ),
      (_) => emit(AuthState.guest(store: state.store)),
    );
  }

  FutureOr<void> _onLogout(_Logout event, Emitter<AuthState> emit) async {
    final result = await _authRepository.clearSession();

    result.fold(
      (failure) => emit(
        AuthState.onFailure(store: state.store, failure: failure),
      ),
      (_) => emit(AuthState.onUserUnauthenticated(store: state.store)),
    );
  }

  @override
  void started({Map<String, dynamic>? args}) {
    add(const AuthEvent.started());
  }

  void authStatusChecked() {
    add(const AuthEvent.authStatusChecked());
  }

  void loggedOut() {
    add(const AuthEvent.loggedOut());
  }

  void loginAsGuest() {
    add(const AuthEvent.loginAsGuest());
  }

  void logout() {
    add(const AuthEvent.logout());
  }
}
