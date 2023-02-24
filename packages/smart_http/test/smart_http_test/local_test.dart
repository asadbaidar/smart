import 'package:test/test.dart';
import 'package:smart_http/smart_http.dart';

void main() {
  late HttpApi httpApi;

  setUp(() {
    httpApi = HttpApi();
  });

  group('HttpApi.local()', () {
    test('returns a json if the coversion is done successfully', () async {
      final result = await httpApi.local(
        '{"title": "Test"}',
        enableLogs: true,
      );
      expect(result, isA<Map<String, dynamic>>());
    });

    test('throws an Exception if the conversion fails', () async {
      final result = httpApi.local(
        '{"title": "Test"',
        enableLogs: true,
      );
      expect(result, throwsException);
    });
  });
}
