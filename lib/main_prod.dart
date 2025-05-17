import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:unizen/config/dependencies.dart';
import 'package:unizen/main.dart';

/// Development config entry point.
/// Launch with `flutter run --target lib/main_prod.dart`.
Future main() async {
  await dotenv.load(fileName: '.env.prod');

  Logger.root.level = Level.SEVERE;

  runApp(MultiProvider(providers: providersRemote, child: const UnizenApp()));
}
