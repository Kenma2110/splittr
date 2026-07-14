part of 'group_details_bloc.dart';

@freezed
class GroupDetailsEvent extends BaseEvent with _$GroupDetailsEvent {
  const GroupDetailsEvent._();

  const factory GroupDetailsEvent.started() = _Started;
  const factory GroupDetailsEvent.inviteCodeChanged({
    required String inviteCode,
  }) = _InviteCodeChanged;
  const factory GroupDetailsEvent.joinGroupButtonClicked() =
      _JoinGroupButtonClicked;
}
