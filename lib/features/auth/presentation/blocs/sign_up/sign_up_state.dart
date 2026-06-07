part of 'sign_up_bloc.dart';

@freezed
sealed class SignUpState extends BaseState with _$SignUpState {
  const SignUpState._();

  const factory SignUpState.initial({
    required SignUpStateStore store,
  }) = Initial;

  const factory SignUpState.onNameChange({
    required SignUpStateStore store,
  }) = OnNameChange;

  const factory SignUpState.onEmailChange({
    required SignUpStateStore store,
  }) = OnEmailChange;

  const factory SignUpState.onPasswordChange({
    required SignUpStateStore store,
  }) = OnPasswordChange;

  const factory SignUpState.onConfirmPasswordChange({
    required SignUpStateStore store,
  }) = OnConfirmPasswordChange;

  const factory SignUpState.onSignUpSuccess({
    required SignUpStateStore store,
  }) = OnSignUpSuccess;

  const factory SignUpState.onLoadingStateChange({
    required SignUpStateStore store,
  }) = OnLoadingStateChange;

  const factory SignUpState.onFailure({
    required SignUpStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  SignUpState getLoadingState({required bool loading}) {
    return SignUpState.onLoadingStateChange(
      store: store.copyWith(loading: loading),
    );
  }

  @override
  SignUpState getFailureState({required Failure failure}) {
    return SignUpState.onFailure(
      store: store.copyWith(loading: false),
      failure: failure,
    );
  }
}

@freezed
class SignUpStateStore with _$SignUpStateStore {
  const SignUpStateStore({
    this.loading = false,
    this.name,
    this.emailAddress,
    this.password,
    this.confirmPassword,
  });

  @override
  final bool loading;
  @override
  final Name? name;
  @override
  final EmailAddress? emailAddress;
  @override
  final Password? password;
  @override
  final Password? confirmPassword;
}
