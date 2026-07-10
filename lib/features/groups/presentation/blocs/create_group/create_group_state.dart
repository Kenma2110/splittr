part of 'create_group_bloc.dart';

@freezed
sealed class CreateGroupState extends BaseState with _$CreateGroupState {
  const CreateGroupState._();

  const factory CreateGroupState.initial({
    required CreateGroupStateStore store,
  }) = Initial;

  const factory CreateGroupState.onCreateGroupSuccess({
    required CreateGroupStateStore store,
  }) = OnCreateGroupSuccess;

  const factory CreateGroupState.onFailure({
    required CreateGroupStateStore store,
    required Failure failure,
  }) = OnFailure;

  const factory CreateGroupState.changeLoaderState({
    required CreateGroupStateStore store,
  }) = ChangeLoaderState;

  @override
  BaseState getFailureState({required Failure failure}) =>
      CreateGroupState.onFailure(
        store: store.copyWith(loading: false),
        failure: failure,
      );

  @override
  BaseState getLoadingState({required bool loading}) =>
      CreateGroupState.changeLoaderState(
        store: store.copyWith(loading: loading),
      );
}

@freezed
class CreateGroupStateStore with _$CreateGroupStateStore {
  const CreateGroupStateStore({
    this.loading = false,
    this.groupName = '',
    this.groupDescription = '',
  });

  @override
  final bool loading;

  @override
  final String groupName;

  @override
  final String groupDescription;
}
