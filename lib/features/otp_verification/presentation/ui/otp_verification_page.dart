import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:sky_design_system/sky_design_system.dart' show AppSnackBar;
import 'package:splittr/core/designs/designs.dart';
import 'package:splittr/core/global/presentation/blocs/global_bloc.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/otp_verification/presentation/blocs/otp_verification_bloc.dart';
import 'package:splittr/utils/utils.dart';

part 'otp_verification_form.dart';

class OtpVerificationPage
    extends BasePage<OtpVerificationBloc, OtpVerificationState> {
  const OtpVerificationPage({required this.args, super.key});

  final Map<String, dynamic>? args;

  @override
  OtpVerificationBloc createBloc() =>
      getIt<OtpVerificationBloc>()..started(args: args);

  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold(
      body: _OtpVerificationForm(),
    );
  }

  @override
  void handleStateChange(BuildContext context, OtpVerificationState state) {
    return switch (state) {
      UserAuthenticateSuccessful() => _onUserAuthenticateSuccessful(
        context: context,
        state: state,
      ),
      _ => null,
    };
  }

  void _showSnackBar(BuildContext context) {
    AppSnackBar.show(context, message: 'Otp Verified');
  }

  void _onUserAuthenticateSuccessful({
    required BuildContext context,
    required UserAuthenticateSuccessful state,
  }) {
    getBloc<GlobalBloc>(context).userUpdated(state.user);

    _showSnackBar(context);

    _navigateToDashboard(context);
  }

  void _navigateToDashboard(BuildContext context) {
    unawaited(RouteHandler.pushAndRemoveUntil(context, RouteId.dashboard));
  }
}
