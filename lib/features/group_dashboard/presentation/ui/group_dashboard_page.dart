import 'package:flutter/material.dart';
import 'package:sky_bloc/sky_bloc.dart';
import 'package:splittr/di/injection.dart';
import 'package:splittr/features/group_dashboard/presentation/blocs/group_dashboard_bloc.dart';

part 'group_dashboard_form.dart';

class GroupDashboardPage
    extends BasePage<GroupDashboardBloc, GroupDashboardState> {
  const GroupDashboardPage({required this.args, super.key});

  final Map<String, dynamic>? args;

  @override
  GroupDashboardBloc createBloc() =>
      getIt<GroupDashboardBloc>()..started(args: args);

  @override
  Widget buildPage(BuildContext context) {
    return const Scaffold(body: _GroupDashboardForm());
  }
}
