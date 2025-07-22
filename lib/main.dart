import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unizen/ui/core/localization/applocalization.dart';
import 'package:unizen/ui/core/themes/theme.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        AppLocalization.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('it'), // Italian
      ],
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router(context.read<AuthRepository>()),
    );
  }
}
