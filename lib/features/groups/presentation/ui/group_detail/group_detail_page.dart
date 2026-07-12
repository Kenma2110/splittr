import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:sky_design_system/sky_design_system.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/groups/domain/entities/group.dart';
import 'package:splittr/features/groups/presentation/blocs/group_detail/group_detail_bloc.dart';

part 'group_detail_form.dart';

class GroupDetailPage extends BasePage<GroupDetailBloc, GroupDetailState> {
  const GroupDetailPage({required this.args, super.key});

  final Map<String, dynamic>? args;

  @override
  GroupDetailBloc createBloc() => getIt<GroupDetailBloc>()..started(args: args);

  @override
  Widget buildPage(BuildContext context) {
    final group = args?['group'] as Group?;
    return Scaffold(body: _GroupDetailForm(group: group!));
  }
}
