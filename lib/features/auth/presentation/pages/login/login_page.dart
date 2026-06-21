import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:splittr/features/auth/presentation/pages/widgets/apple_sign_in_button.dart';
import 'package:splittr/features/auth/presentation/pages/widgets/auth_form_card.dart';
import 'package:splittr/features/auth/presentation/pages/widgets/google_sign_in_button.dart';
import 'package:splittr/features/auth/presentation/pages/widgets/or_divider.dart';
import 'package:splittr/utils/extensions/extensions.dart';

part 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({required this.args, super.key});

  final Map<String, dynamic>? args;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Guest) {
          unawaited(
            RouteHandler.pushReplacement(context, RouteId.splitHistory),
          );
        } else if (state is Authenticated) {
          unawaited(
            RouteHandler.pushReplacement(context, RouteId.dashboard),
          );
        }
      },
      child: Scaffold(
        appBar: AppTopBar(
          title: context.strings.appName,
          centerTitle: true,
          titleColor: context.colorScheme.primary,
        ),
        body: const _LoginForm(),
      ),
    );
  }
}
