part of 'group_detail_bloc.dart';

@freezed
class GroupDetailEvent extends BaseEvent with _$GroupDetailEvent {
  const GroupDetailEvent._();

  const factory GroupDetailEvent.started() = _Started;
  const factory GroupDetailEvent.inviteCodeChanged({
    required String inviteCode,
  }) = _InviteCodeChanged;
  const factory GroupDetailEvent.joinGroupButtonClicked() =
      _JoinGroupButtonClicked;
}
