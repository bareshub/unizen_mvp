import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    // Add your localized strings here
    // 'en': {
    //    'hello': 'Hello',
    //    'login': 'Login',
    // },
    // 'it': {
    //   'hello': 'Ciao',
    //   'login': 'Accedi',
    // },
  };

  String _get(String key) =>
      _localizedValues[locale.languageCode]?[key] ?? '[${key.toUpperCase()}]';

  // Add your string getters here
  // String get hello => _get('hello');
  // String get login => _get('login');
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
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
