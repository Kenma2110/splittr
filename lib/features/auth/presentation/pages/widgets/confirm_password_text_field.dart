import 'package:flutter/material.dart';
import 'package:sky_design_system/sky_design_system.dart' show AppTextField;
import 'package:splittr/utils/extensions/l10n_extensions.dart';

class ConfirmPasswordTextField extends StatelessWidget {
  const ConfirmPasswordTextField({
    required this.onChanged,
    required this.password,
    super.key,
  });

  final ValueChanged<String> onChanged;
  final String password;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: context.strings.confirmPassword,
      hintText: context.strings.passwordHintText,
      obscureText: true,
      onChanged: onChanged,
      validator: (confirmPassword) {
        if (confirmPassword?.isNotEmpty ?? false) {
          if (confirmPassword != password) {
            return 'Passwords do not match';
          }
        }
        return null;
      },
    );
  }
}
