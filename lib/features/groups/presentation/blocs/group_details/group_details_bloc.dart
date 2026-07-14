import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:splittr/features/groups/domain/usecases/join_group_usecase.dart';

part 'group_details_bloc.freezed.dart';
part 'group_details_event.dart';
part 'group_details_state.dart';

@injectable
final class GroupDetailsBloc
    extends BaseBloc<GroupDetailsEvent, GroupDetailsState> {
  GroupDetailsBloc(this._joinGroupUseCase)
    : super(
        const GroupDetailsState.initial(
          store: GroupDetailsStateStore(),
        ),
      );
  final JoinGroupUseCase _joinGroupUseCase;
  @override
  void handleEvents() {
    on<_Started>(_onStarted);
    on<_InviteCodeChanged>(_onInviteCodeChanged);
    on<_JoinGroupButtonClicked>(_onJoinGroupButtonClicked);
  }

  void _onStarted(_Started event, Emitter<GroupDetailsState> emit) {}

  Future<void> _onInviteCodeChanged(
    _InviteCodeChanged event,
    Emitter<GroupDetailsState> emit,
  ) async {
    emit(
      GroupDetailsState.inviteCodeChange(
        store: state.store.copyWith(inviteCode: event.inviteCode),
      ),
    );
  }

  Future<void> _onJoinGroupButtonClicked(
    _JoinGroupButtonClicked event,
    Emitter<GroupDetailsState> emit,
  ) async {
    changeLoadingState(emit: emit, loading: true);
    final result = await _joinGroupUseCase.call(
      JoinGroupParams(inviteCode: state.store.inviteCode),
    );
    result.fold(
      (failure) => handleFailure(emit: emit, failure: failure),
      (_) => emit(GroupDetailsState.joinGroupSuccess(store: state.store)),
    );
  }

  @override
  void started({Map<String, dynamic>? args}) {
    add(const GroupDetailsEvent.started());
  }

  void inviteCodeChanged({required String inviteCode}) {
    add(GroupDetailsEvent.inviteCodeChanged(inviteCode: inviteCode));
  }

  void joinGroupButtonClicked() {
    add(const GroupDetailsEvent.joinGroupButtonClicked());
  }
}
