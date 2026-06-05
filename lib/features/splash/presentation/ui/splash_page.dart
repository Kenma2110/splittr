import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:sky_design_system/sky_design_system.dart' show AppImage;
import 'package:splittr/constants/constants.dart';
import 'package:splittr/core/global/presentation/blocs/global_bloc.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/core/user/domain/models/user.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/splash/presentation/blocs/splash_bloc.dart';
import 'package:splittr/utils/bloc_utils/bloc_utils.dart';

part 'splash_form.dart';

class SplashPage extends BasePage<SplashBloc, SplashState> {
  const SplashPage({required this.args, super.key});

  final Map<String, dynamic>? args;

  @override
  SplashBloc createBloc() => getIt<SplashBloc>()..started(args: args);

  @override
  bool showLoading(SplashState state) {
    return true;
  }

  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold(
      body: _SplashForm(),
    );
  }

  @override
  void handleStateChange(BuildContext context, SplashState state) {
    return switch (state) {
      UserAuthorized(:final user) => _userAuthorized(
        context: context,
        user: user,
      ),
      UserUnauthorized _ => _navigateToAuthLandingPage(context),
      _ => () {},
    };
  }

  void _userAuthorized({required BuildContext context, required User user}) {
    getBloc<GlobalBloc>(context).userUpdated(user);

    _navigateToDashboardPage(context);
  }

  void _navigateToDashboardPage(BuildContext context) {
    unawaited(RouteHandler.pushReplacement(context, RouteId.dashboard));
  }

  void _navigateToAuthLandingPage(BuildContext context) {
    unawaited(RouteHandler.pushReplacement(context, RouteId.authLanding));
  }
}
