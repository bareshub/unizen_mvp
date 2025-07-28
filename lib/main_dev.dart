import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import 'package:unizen/config/dependencies.dart';
import 'package:unizen/main.dart';

/// Development config entry point.
/// Launch with `flutter run --target lib/main_dev.dart`.
Future main() async {
  await dotenv.load(fileName: '.env.dev');

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });

  Command.globalExceptionHandler = (exception, stackTrace) {
    debugPrint('Global Command Exception: $exception');
  };

  runApp(MultiProvider(providers: providersLocal, child: const UnizenApp()));
}
