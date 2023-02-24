import 'package:test/test.dart';
import 'package:smart_http/smart_http.dart';

import '../mocks.dart';

void main() {
  late SmartHttp http;

  setUp(() async {
    await startServer();
    http = SmartHttp();
    SmartHttpConfig.baseUrl = serverUrl.toString();
    SmartHttpConfig.headers = mockBaseHeader;
    SmartHttpConfig.connectTimeout = const Duration(seconds: 1);
    SmartHttpConfig.receiveTimeout = const Duration(seconds: 5);
    SmartHttpConfig.enableLogs = true;
  });

  tearDown(stopServer);

  group('SmartHttp.get() request', () {
    group('works with', () {
      test('query parameters', () async {
        final result = await http.get(
          path: mockTest,
          query: mockQuery,
        );
        expect(result, isA<Map<String, dynamic>>());
        expect(result[pathKey], mockTest);
        expect(result[statusCodeKey], 200);
        expect(result[methodKey], SmartHttpMethod.get());
        expect(result[queryKey], mockQuery);
      });

      test('string response', () async {
        final result = await http.get(
          path: mockSuccess,
        );
        expect(result, isA<String>());
        expect(result, mockSuccess);
      });

      test('list response', () async {
        final result = await http.get(
          path: mockList,
        );
        expect(result, isA<List>());
        expect(result, mockBodyList);
      });
    });

    group('headers check', () {
      test('passes if default headers are set', () async {
        final result = await http.get(
          path: mockTest,
        );
        expect(result, isA<Map<String, dynamic>>());
        expect(
          result[headersKey],
          containsPair(
            mockBaseHeader.keys.first,
            mockBaseHeader.values.first,
          ),
        );
      });

      test('passes if default headers are overriden by provided ones',
          () async {
        final result = await http.get(
          path: mockTest,
          headers: mockHeader,
        );
        expect(result, isA<Map<String, dynamic>>());
        expect(
          result[headersKey],
          isNot(containsPair(
            mockBaseHeader.keys.first,
            mockBaseHeader.values.first,
          )),
        );
        expect(
          result[headersKey],
          containsPair(
            mockHeader.keys.first,
            mockHeader.values.first,
          ),
        );
      });
    });

    group('invalid response', () {
      test(
          'throws NoDataException if the '
          'http call completes with an error', () async {
        final result = http.get(
          path: mockError,
        );
        expect(result, throwsA(isA<NoDataException>()));
      });

      test(
          'throws BadRequestException if the '
          'http call completes with a 400 error', () async {
        final result = http.get(
          path: mockBadRequest,
        );
        expect(result, throwsA(isA<BadRequestException>()));
      });

      test(
          'throws UnauthorisedException if the '
          'http call completes with a 401 error', () async {
        final result = http.get(
          path: mockUnauthorized401,
        );
        expect(result, throwsA(isA<UnauthorisedException>()));
      });

      test(
          'throws UnauthorisedException if the '
          'http call completes with a 403 error', () async {
        final result = http.get(
          path: mockUnauthorized403,
        );
        expect(result, throwsA(isA<UnauthorisedException>()));
      });

      test(
          'throws NoDataException if the '
          'http call completes with a 404 error', () async {
        final result = http.get(
          path: mockNotFound,
        );
        expect(result, throwsA(isA<NoDataException>()));
      });

      test('throws NoDataException if no connection', () async {
        final result = http.get(
          baseUrl: '',
          path: '',
        );
        expect(result, throwsA(isA<NoDataException>()));
      });

      test('throws CancelException if cancelled manually', () async {
        final result = http.get(
          path: mockTest,
        );
        http.cancel();
        expect(result, throwsA(isA<CancelException>()));
      });
    });

    group('timeout check', () {
      test('passess if the http call returns before the given timeout time',
          () async {
        final result = await http.get(
          path: mockTimeout,
          receiveTimeout: const Duration(seconds: 3),
        );
        expect(result, isA<String>());
        expect(result, mockTimeout);
      });

      test(
          'throws TimeoutException if the http '
          'call timesout by the given timeout time', () async {
        final result = http.get(
          path: mockTimeout,
          receiveTimeout: const Duration(seconds: 1),
        );
        expect(result, throwsA(isA<TimeoutException>()));
      });
    });
  });
}
