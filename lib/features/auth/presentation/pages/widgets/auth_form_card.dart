import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart';

class AuthFormCard extends StatelessWidget {
  const AuthFormCard({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard.outlined(
      color: context.colorScheme.surfaceContainer,
      child: Padding(
        padding: const .all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: AppSpacing.lg,
          children: children,
        ),
      ),
    );
  }
}
