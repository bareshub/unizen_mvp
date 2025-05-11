import 'package:flutter/material.dart';

import 'main_dev.dart' as dev;

/// Default main method
/// Launches development config by default
Future main() async => await dev.main();

class UnizenApp extends StatelessWidget {
  const UnizenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniZen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: Container(),
    );
  }
}
