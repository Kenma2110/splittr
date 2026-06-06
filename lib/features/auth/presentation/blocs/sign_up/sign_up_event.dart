part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent extends BaseEvent with _$SignUpEvent {
  const SignUpEvent._();

  const factory SignUpEvent.started() = _Started;
}
