part of 'sign_up_bloc.dart';

@freezed
sealed class SignUpState extends BaseState with _$SignUpState {
  const SignUpState._();

  const factory SignUpState.initial({
    required SignUpStateStore store,
  }) = Initial;

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
  });

  @override
  final bool loading;
}
