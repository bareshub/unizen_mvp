import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void mainDev() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env.dev");
  });

  test('Ensure .env.dev file loaded properly', () {
    expect(dotenv.env['ENVIRONMENT'], 'dev');
  });
}

void mainStaging() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env.staging");
  });

  test('Ensure .env.staging file loaded properly', () {
    expect(dotenv.env['ENVIRONMENT'], 'staging');
  });
}

void mainProd() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env.prod");
  });

  test('Ensure .env.prod file loaded properly', () {
    expect(dotenv.env['ENVIRONMENT'], 'prod');
  });
}
