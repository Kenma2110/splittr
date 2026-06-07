import 'package:flutter/material.dart';
import 'package:sky_architecture/sky_architecture.dart';
import 'package:sky_design_system/sky_design_system.dart' show AppTextField;
import 'package:splittr/utils/extensions/l10n_extensions.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({required this.onChanged, super.key});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: context.strings.password,
      hintText: context.strings.passwordHintText,
      obscureText: true,
      onChanged: onChanged,
      validator: (password) {
        if (password?.isNotEmpty ?? false) {
          return Password(
            password ?? '',
          ).value.fold((failure) => failure.message, (_) => null);
        }
        return null;
      },
    );
  }
}
