import 'package:flutter/material.dart';

import 'main_dev.dart' as dev;
import 'package:unizen/data/repositories/auth/auth_repository_dev.dart';
import 'package:unizen/routing/router.dart';

/// Default main method
/// Launches development config by default
Future main() async => await dev.main();

class UnizenApp extends StatelessWidget {
  const UnizenApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryDev(); // TODO use provider instead
    return MaterialApp.router(routerConfig: router(authRepository));
  }
}
