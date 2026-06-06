import 'package:flutter/material.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_design_system/sky_design_system.dart' show AppTextField;
import 'package:splittr/utils/extensions/l10n_extensions.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({required this.onChanged, super.key});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: context.strings.fullName,
      hintText: context.strings.fullNameHintText,
      onChanged: onChanged,
      validator: (name) {
        if (name?.isNotEmpty ?? false) {
          return Name(
            name ?? '',
          ).value.fold((failure) => failure.message, (_) => null);
        }

        return null;
      },
    );
  }
}
