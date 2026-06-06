import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:splittr/features/auth/domain/usecases/sign_up_with_email_usecase.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

@injectable
class SignUpBloc extends BaseBloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._signUpWithEmailUseCase)
    : super(const SignUpState.initial(store: SignUpStateStore()));

  final SignUpWithEmailUseCase _signUpWithEmailUseCase;

  @override
  void handleEvents() {
    on<_Started>(_onStarted);
  }

  FutureOr<void> _onStarted(_Started event, Emitter<SignUpState> emit) {}

  @override
  void started({Map<String, dynamic>? args}) {
    add(const SignUpEvent.started());
  }
}
