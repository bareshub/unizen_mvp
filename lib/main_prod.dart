import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unizen/main.dart';

/// Development config entry point.
/// Launch with `flutter run --target lib/main_prod.dart`.
Future main() async {
  await dotenv.load(fileName: '.env.prod');
  // TODO setup logging based on env variable
  // TODO setup providers
  runApp(const UnizenApp());
}
