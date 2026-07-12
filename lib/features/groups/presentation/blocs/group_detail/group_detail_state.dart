part of 'group_detail_bloc.dart';

@freezed
sealed class GroupDetailState extends BaseState with _$GroupDetailState {
  const GroupDetailState._();

  const factory GroupDetailState.initial({
    required GroupDetailStateStore store,
  }) = Initial;

  const factory GroupDetailState.joinGroupSuccess({
    required GroupDetailStateStore store,
  }) = JoinGroupSuccess;

  const factory GroupDetailState.changeLoaderState({
    required GroupDetailStateStore store,
  }) = ChangeLoaderState;

  const factory GroupDetailState.inviteCodeChange({
    required GroupDetailStateStore store,
  }) = InviteCodeChange;

  const factory GroupDetailState.onFailure({
    required GroupDetailStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState({required Failure failure}) =>
      GroupDetailState.onFailure(
        store: store.copyWith(loading: false),
        failure: failure,
      );

  @override
  BaseState getLoadingState({required bool loading}) =>
      GroupDetailState.changeLoaderState(
        store: store.copyWith(loading: loading),
      );
}

@freezed
class GroupDetailStateStore with _$GroupDetailStateStore {
  const GroupDetailStateStore({
    this.loading = false,
    this.inviteCode = '',
  });

  @override
  final bool loading;

  @override
  final String inviteCode;
}
