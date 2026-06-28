part of 'login_bloc.dart';

@freezed
sealed class LoginState extends BaseState with _$LoginState {
  const LoginState._();

  const factory LoginState.initial({
    required LoginStateStore store,
  }) = Initial;

  const factory LoginState.onEmailChange({
    required LoginStateStore store,
  }) = OnEmailChange;

  const factory LoginState.onPasswordChange({
    required LoginStateStore store,
  }) = OnPasswordChange;

  const factory LoginState.onLoginSuccess({
    required LoginStateStore store,
  }) = OnLoginSuccess;

  const factory LoginState.onLoadingStateChange({
    required LoginStateStore store,
  }) = OnLoadingStateChange;

  const factory LoginState.onFailure({
    required LoginStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  LoginState getLoadingState({required bool loading}) {
    return LoginState.onLoadingStateChange(
      store: store.copyWith(loading: loading),
    );
  }

  @override
  LoginState getFailureState({required Failure failure}) {
    return LoginState.onFailure(
      store: store.copyWith(loading: false),
      failure: failure,
    );
  }
}

@freezed
class LoginStateStore with _$LoginStateStore {
  const LoginStateStore({
    this.loading = false,
    this.emailAddress,
    this.password,
  });

  @override
  final bool loading;
  @override
  final EmailAddress? emailAddress;
  @override
  final Password? password;
}
