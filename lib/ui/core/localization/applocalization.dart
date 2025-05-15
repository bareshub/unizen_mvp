import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalization {
  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {'title': 'Welcome to UniZen!'},
    'it': {'title': 'Benvenuto in UniZen!'},
  };

  String _get(String key) =>
      _localizedValues[locale.languageCode]?[key] ?? '[${key.toUpperCase()}]';

  String get title => _get('title');
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      _supportedLanguages.contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) {
    return false;
  }

  static const _supportedLanguages = ['en', 'it'];
}
