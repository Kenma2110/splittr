part of 'groups_page.dart';

class _GroupsForm extends StatelessWidget {
  const _GroupsForm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsBloc, GroupsState>(
      builder: (context, state) {
        return switch (state) {
          Initial() || ChangeLoaderState() => _buildShimmerList(),

          OnFailure(:final failure) => _buildErrorState(
            context,
            failure.message,
          ),

          OnGroupsUpdate() =>
            state.store.groups.isEmpty && !state.store.loading
                ? _buildEmptyState(context)
                : _buildGroupsList(state.store.groups),
        };
      },
    );
  }

  Widget _buildShimmerList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => const GroupBalanceCardShimmer(),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              style: TextStyle(
                color: context.colorScheme.error,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group_off_outlined,
              size: 64,
              color: context.colorScheme.onSurfaceVariant.withValues(
                alpha: 0.5,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'No groups yet',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Create a group to start splitting expenses with your friends.',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupsList(List<Group> groups) {
    final groupIcons = [
      Icons.umbrella_rounded,
      Icons.home_rounded,
      Icons.coffee_rounded,
      Icons.restaurant_rounded,
      Icons.directions_car_rounded,
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: groups.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final group = groups[index];
        final icon = groupIcons[index % groupIcons.length];
        final balanceState =
            BalanceState.values[index % BalanceState.values.length];

        return GroupBalanceCard(
          title: group.name!,
          subtitle: group.description!,
          icon: icon,
          balanceState: balanceState,
          amountText: '1000',
          onTap: () async {
            await RouteHandler.push<void>(
              context,
              RoutePaths.groupDetail,
              extra: {'group': group},
            );
          },
        );
      },
    );
  }
}
