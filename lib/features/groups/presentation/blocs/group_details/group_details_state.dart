part of 'group_details_bloc.dart';

@freezed
sealed class GroupDetailsState extends BaseState with _$GroupDetailsState {
  const GroupDetailsState._();

  const factory GroupDetailsState.initial({
    required GroupDetailsStateStore store,
  }) = Initial;

  const factory GroupDetailsState.joinGroupSuccess({
    required GroupDetailsStateStore store,
  }) = JoinGroupSuccess;

  const factory GroupDetailsState.changeLoaderState({
    required GroupDetailsStateStore store,
  }) = ChangeLoaderState;

  const factory GroupDetailsState.inviteCodeChange({
    required GroupDetailsStateStore store,
  }) = InviteCodeChange;

  const factory GroupDetailsState.onFailure({
    required GroupDetailsStateStore store,
    required Failure failure,
  }) = OnFailure;

  @override
  BaseState getFailureState({required Failure failure}) =>
      GroupDetailsState.onFailure(
        store: store.copyWith(loading: false),
        failure: failure,
      );

  @override
  BaseState getLoadingState({required bool loading}) =>
      GroupDetailsState.changeLoaderState(
        store: store.copyWith(loading: loading),
      );
}

@freezed
class GroupDetailsStateStore with _$GroupDetailsStateStore {
  const GroupDetailsStateStore({
    this.loading = false,
    this.inviteCode = '',
  });

  @override
  final bool loading;

  @override
  final String inviteCode;
}
