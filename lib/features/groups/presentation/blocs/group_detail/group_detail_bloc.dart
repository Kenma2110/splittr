import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:splittr/features/groups/domain/usecases/join_group_usecase.dart';

part 'group_detail_bloc.freezed.dart';
part 'group_detail_event.dart';
part 'group_detail_state.dart';

@injectable
final class GroupDetailBloc
    extends BaseBloc<GroupDetailEvent, GroupDetailState> {
  GroupDetailBloc(this._joinGroupUseCase)
    : super(
        const GroupDetailState.initial(
          store: GroupDetailStateStore(),
        ),
      );
  final JoinGroupUseCase _joinGroupUseCase;
  @override
  void handleEvents() {
    on<_Started>(_onStarted);
    on<_InviteCodeChanged>(_onInviteCodeChanged);
    on<_JoinGroupButtonClicked>(_onJoinGroupButtonClicked);
  }

  void _onStarted(_Started event, Emitter<GroupDetailState> emit) {}

  Future<void> _onInviteCodeChanged(
    _InviteCodeChanged event,
    Emitter<GroupDetailState> emit,
  ) async {
    emit(
      GroupDetailState.inviteCodeChange(
        store: state.store.copyWith(inviteCode: event.inviteCode),
      ),
    );
  }

  Future<void> _onJoinGroupButtonClicked(
    _JoinGroupButtonClicked event,
    Emitter<GroupDetailState> emit,
  ) async {
    changeLoadingState(emit: emit, loading: true);
    final result = await _joinGroupUseCase.call(
      JoinGroupParams(inviteCode: state.store.inviteCode),
    );
    result.fold(
      (failure) => handleFailure(emit: emit, failure: failure),
      (_) => emit(GroupDetailState.joinGroupSuccess(store: state.store)),
    );
  }

  @override
  void started({Map<String, dynamic>? args}) {
    add(const GroupDetailEvent.started());
  }

  void inviteCodeChanged({required String inviteCode}) {
    add(GroupDetailEvent.inviteCodeChanged(inviteCode: inviteCode));
  }

  void joinGroupButtonClicked() {
    add(const GroupDetailEvent.joinGroupButtonClicked());
  }
}
