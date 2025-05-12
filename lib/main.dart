import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      routerConfig: router(context.read<AuthRepository>()),
    );
  }
}
