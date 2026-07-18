import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:sky_router/sky_router.dart';
import 'package:splittr/core/router/route_paths.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/groups/presentation/blocs/join_group/join_group_cubit.dart';
import 'package:splittr/utils/extensions/extensions.dart';

class JoinGroupPage extends BasePage<JoinGroupCubit, JoinGroupState> {
  const JoinGroupPage({required this.inviteCode, super.key});

  final String inviteCode;

  @override
  JoinGroupCubit createBloc() {
    final cubit = getIt<JoinGroupCubit>();
    unawaited(cubit.joinGroup(inviteCode: inviteCode));
    return cubit;
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: BlocConsumer<JoinGroupCubit, JoinGroupState>(
            listener: (context, state) {
              switch (state) {
                case JoinGroupSuccess():
                  unawaited(
                    RouteHandler.push<void>(
                      context,
                      RoutePaths.groupDetails,
                      extra: {'group': state.group},
                    ),
                  );
                case JoinGroupFailure(:final failure):
                  AppSnackBar.show(context, message: failure.message);
                case _:
                  break;
              }
            },
            builder: (context, state) {
              if (state is JoinGroupFailure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon.lg(
                      Icons.error_outline_rounded,
                      color: context.colorScheme.error,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppText.titleMedium(
                      context.strings.failedToJoinGroup,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppText.bodyMedium(
                      state.failure.message,
                      color: context.colorScheme.error,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton.primary(
                      text: context.strings.goToDashboard,
                      onPressed: () {
                        RouteHandler.go(context, RoutePaths.dashboard);
                      },
                    ),
                  ],
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppProgressIndicator.circular(),
                  const SizedBox(height: AppSpacing.xl),
                  AppText.titleMedium(
                    context.strings.joiningGroup,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppText.bodyMedium(
                    context.strings.joiningGroupSubtitle,
                    color: context.colorScheme.onSurfaceVariant,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
