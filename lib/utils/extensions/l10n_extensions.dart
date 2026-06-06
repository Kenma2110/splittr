import 'package:flutter/widgets.dart';
import 'package:splittr/l10n/generated/app_localizations.dart';

extension LocalizedContext on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
