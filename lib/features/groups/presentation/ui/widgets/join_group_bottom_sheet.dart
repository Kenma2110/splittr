import 'package:flutter/material.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:sky_router/sky_router.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/groups/presentation/blocs/group_details/group_details_bloc.dart';
import 'package:splittr/utils/extensions/extensions.dart';

class JoinGroupBottomSheet extends StatefulWidget {
  const JoinGroupBottomSheet({super.key});

  @override
  State<JoinGroupBottomSheet> createState() => _JoinGroupBottomSheetState();
}

class _JoinGroupBottomSheetState extends State<JoinGroupBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GroupDetailsBloc>(),
      child: BlocListener<GroupDetailsBloc, GroupDetailsState>(
        listener: (context, state) => switch (state) {
          JoinGroupSuccess _ => RouteHandler.pop<void>(context),
          _ => () {},
        },
        child: const _SheetBody(),
      ),
    );
  }
}

class _SheetBody extends StatelessWidget {
  const _SheetBody();

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      mainAxisSize: .min,
      children: [
        Text(
          context.strings.joinGroup,
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          context.strings.enterCode,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          onChanged: (inviteCode) => getBloc<GroupDetailsBloc>(
            context,
          ).inviteCodeChanged(inviteCode: inviteCode),
          labelText: context.strings.groupCode,
        ),
        const SizedBox(height: AppSpacing.lg),
        BlocSelector<GroupDetailsBloc, GroupDetailsState, bool>(
          selector: (state) => state.store.inviteCode.trim().isNotEmpty,
          builder: (context, isValid) {
            return AppButton.primary(
              text: context.strings.joinGroup,
              // TODO(Chaitanya): add loading condition
              onPressed: isValid
                  ? () => getBloc<GroupDetailsBloc>(
                      context,
                    ).joinGroupButtonClicked()
                  : null,
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
