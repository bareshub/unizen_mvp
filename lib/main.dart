import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unizen/ui/core/localization/applocalization.dart';

import 'main_dev.dart' as dev;
import 'package:unizen/data/repositories/auth/auth_repository.dart';
import 'package:unizen/routing/router.dart';

/// Default main method
/// Launches development config by default
Future main() async => await dev.main();

class UnizenApp extends StatelessWidget {
  const UnizenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalization.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('it'), // Italian
      ],
      routerConfig: router(context.read<AuthRepository>()),
    );
  }
}
