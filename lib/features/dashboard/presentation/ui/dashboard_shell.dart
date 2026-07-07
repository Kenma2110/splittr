import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart' show AppNavigationBar;
import 'package:sky_router/sky_router.dart';
import 'package:splittr/core/router/route_paths.dart';
import 'package:splittr/utils/extensions/l10n_extensions.dart';

class DashboardShell extends StatelessWidget {
  const DashboardShell({
    required this.child,
    required this.currentLocation,
    super.key,
  });

  final Widget child;
  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: _getSelectedIndex(),
        onDestinationSelected: (index) =>
            _onDestinationSelected(context, index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: context.strings.dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.group_outlined),
            selectedIcon: const Icon(Icons.group),
            label: context.strings.groups,
          ),
          NavigationDestination(
            icon: const Icon(Icons.notifications_active_outlined),
            selectedIcon: const Icon(Icons.notifications_active),
            label: context.strings.activities,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex() {
    return switch (currentLocation) {
      RoutePaths.groups => 1,
      RoutePaths.profile => 2,
      _ => 0,
    };
  }

  void _onDestinationSelected(BuildContext context, int index) {
    final path = switch (index) {
      0 => RoutePaths.dashboard,
      1 => RoutePaths.groups,
      2 => RoutePaths.profile,
      _ => RoutePaths.dashboard,
    };
    RouteHandler.go(context, path);
  }
}
