import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env.dev");
  });

  test('Ensure .env.dev file loaded properly', () {
    expect(dotenv.env['ENVIRONMENT'], 'dev');
  });
}
