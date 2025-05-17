import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dev environment', _testDevEnv);
  group('Staging environment', _testStagingEnv);
  group('Prod environment', _testProdEnv);
}

void _testDevEnv() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env.dev");
  });

  test('Ensure .env.dev file loaded properly', () {
    expect(dotenv.env['ENVIRONMENT'], 'dev');
  });
}

void _testStagingEnv() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env.staging");
  });

  test('Ensure .env.staging file loaded properly', () {
    expect(dotenv.env['ENVIRONMENT'], 'staging');
  });
}

void _testProdEnv() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env.prod");
  });

  test('Ensure .env.prod file loaded properly', () {
    expect(dotenv.env['ENVIRONMENT'], 'prod');
  });
}
