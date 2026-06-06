import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart'
    show AppDivider, AppSpacing, AppText, SkyDesignSystemContextExtension;
import 'package:splittr/utils/extensions/l10n_extensions.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        spacing: AppSpacing.md,
        children: [
          const Expanded(child: AppDivider.horizontal()),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.6,
            ),
            child: AppText.labelMedium(
              context.strings.orContinueWith,
              color: context.colorScheme.onSurfaceVariant,
              textAlign: .center,
            ),
          ),
          const Expanded(child: AppDivider.horizontal()),
        ],
      ),
    );
  }
}
