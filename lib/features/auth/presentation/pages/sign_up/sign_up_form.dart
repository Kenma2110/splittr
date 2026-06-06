part of 'sign_up_page.dart';

class _SignUpForm extends StatelessWidget {
  const _SignUpForm();

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      crossAxisAlignment: .center,
      children: [
        AppText.titleLarge(
          context.strings.createAccount,
          color: context.colorScheme.onSurface,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppText.bodyMedium(
          context.strings.joinUs,
          color: context.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: AppSpacing.xl),
        AuthFormCard(
          children: [
            NameTextField(
              onChanged: (_) {},
            ),
            EmailTextField(
              onChanged: (_) {},
            ),
            PasswordTextField(
              onChanged: (_) {},
            ),
            ConfirmPasswordTextField(
              onChanged: (_) {},
              password: '',
            ),
            AppButton.primary(
              text: context.strings.signUp,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        const _AlreadyHaveAccountSection(),
        const SizedBox(height: AppSpacing.lg),
        const OrDivider(),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          alignment: .center,
          spacing: AppSpacing.md,
          children: [
            GoogleSignInButton(onPressed: () {}),
            AppleSignInButton(onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

class _AlreadyHaveAccountSection extends StatefulWidget {
  const _AlreadyHaveAccountSection();

  @override
  State<_AlreadyHaveAccountSection> createState() =>
      _AlreadyHaveAccountSectionState();
}

class _AlreadyHaveAccountSectionState
    extends State<_AlreadyHaveAccountSection> {
  late final GestureRecognizer _signInTapRecognizer;

  @override
  void initState() {
    super.initState();
    _signInTapRecognizer = TapGestureRecognizer()
      ..onTap = () => RouteHandler.pop(context);
  }

  @override
  void dispose() {
    _signInTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppRichText(
      spans: [
        AppTextSpan.bodyMedium(context.strings.alreadyHaveAccount),
        const AppTextSpan(' '),
        AppTextSpan.labelLarge(
          context.strings.signIn,
          color: context.colorScheme.primary,
          recognizer: _signInTapRecognizer,
        ),
      ],
    );
  }
}
