import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/designs/button/app_transparent_button.dart';
import 'package:splittr/core/designs/color/app_colors.dart';
import 'package:splittr/core/designs/designs.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/login/presentation/blocs/login_bloc.dart';
import 'package:splittr/utils/bloc_utils/bloc_utils.dart';
import 'package:splittr/utils/utils.dart';

part 'login_form.dart';

class LoginPage extends BasePage<LoginBloc, LoginState> {
  const LoginPage({required this.args, super.key});

  final Map<String, dynamic>? args;

  @override
  LoginBloc createBloc() => getIt<LoginBloc>()..started(args: args);

  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold(body: _LoginForm());
  }

  @override
  void handleStateChange(BuildContext context, LoginState state) {
    return switch (state) {
      OtpSent _ => _navigateToLoginOtpVerificationPage(
        context: context,
        state: state,
      ),
      _ => () {},
    };
  }

  void _navigateToLoginOtpVerificationPage({
    required BuildContext context,
    required LoginState state,
  }) {
    if (state.store.phoneNumber == null || state.store.verificationId == null) {
      return;
    }
    unawaited(
      RouteHandler.push(
        context,
        RouteId.otpVerification,
        args: {
          StringConstants.phoneNumber: state.store.phoneNumber,
          StringConstants.verificationId: state.store.verificationId,
          StringConstants.forceResendingToken: state.store.forceResendingToken,
        },
      ),
    );
  }
}
