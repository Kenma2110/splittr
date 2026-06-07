part of 'login_page.dart';

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return AppScrollView(
      crossAxisAlignment: .center,
      children: [
        AppText.titleLarge(
          context.strings.welcomeBack,
          color: context.colorScheme.onSurface,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppText.bodyMedium(
          context.strings.enterEmailToContinue,
          color: context.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: AppSpacing.xl),
        AuthFormCard(
          children: [
            AppTextField(
              labelText: context.strings.email,
              hintText: context.strings.emailHintText,
            ),
            AppTextField(
              labelText: context.strings.password,
              hintText: context.strings.passwordHintText,
              obscureText: true,
            ),
            AppButton.primary(
              text: context.strings.login,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        const _DoNotHaveAccountSection(),
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

class _DoNotHaveAccountSection extends StatefulWidget {
  const _DoNotHaveAccountSection();

  @override
  State<_DoNotHaveAccountSection> createState() =>
      _DoNotHaveAccountSectionState();
}

class _DoNotHaveAccountSectionState extends State<_DoNotHaveAccountSection> {
  late final GestureRecognizer _signUpTapRecognizer;

  @override
  void initState() {
    super.initState();
    _signUpTapRecognizer = TapGestureRecognizer()
      ..onTap = () => RouteHandler.push(context, RouteId.signUp);
  }

  @override
  void dispose() {
    _signUpTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppRichText(
      spans: [
        AppTextSpan.bodyMedium(context.strings.doNotHaveAccount),
        const AppTextSpan.bodyMedium(' '),
        AppTextSpan.labelLarge(
          context.strings.signUpWithEmail,
          color: context.colorScheme.primary,
          recognizer: _signUpTapRecognizer,
        ),
      ],
    );
  }
}
