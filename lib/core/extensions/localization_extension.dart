import 'package:flutter/material.dart';
import 'package:flutter_setup_riverpod/l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

extension LocalizationExtension on BuildContext {
  L10n get l10n => L10n.of(this)!;

  String get locale => Localizations.localeOf(this).languageCode;

  bool get isEnglish => locale == 'en';
  bool get isJapanese => locale == 'ja';

  static L10n get current {
    final context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception(
        'Navigator context is null. Ensure router is initialized.',
      );
    }
    return L10n.of(context)!;
  }
}
