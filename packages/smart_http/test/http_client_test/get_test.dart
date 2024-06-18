import 'package:smart_http/smart_http.dart';
import 'package:test/test.dart';

import '../mocks.dart';

void main() {
  late HttpClient http;

  setUp(() async {
    await startServer();
    http = HttpClient(
      clientConfig: HttpClientConfig(
        baseUrl: serverUrl.toString(),
        headers: mockBaseHeader,
        connectTimeout: const Duration(seconds: 1),
        receiveTimeout: const Duration(seconds: 5),
        enableLogs: true,
      ),
    );
  });

  tearDown(stopServer);

  group('HttpClient.get() request', () {
    group('works with', () {
      test('query parameters', () async {
        final result = await http.get<JsonObject>(
          path: mockTest,
          query: mockQuery,
        );
        expect(result, isA<JsonObject>());
        expect(result[pathKey], mockTest);
        expect(result[statusCodeKey], 200);
        expect(result[methodKey], HttpMethod.get());
        expect(result[queryKey], mockQuery);
      });

      test('string response', () async {
        final result = await http.get<String>(
          path: mockSuccess,
        );
        expect(result, isA<String>());
        expect(result, mockSuccess);
      });

      test('list response', () async {
        final result = await http.get<JsonArray>(
          path: mockList,
        );
        expect(result, isA<JsonArray>());
        expect(result, mockBodyList);
      });
    });

    group('headers check', () {
      test('passes if default headers are set', () async {
        final result = await http.get<JsonObject>(
          path: mockTest,
        );
        expect(result, isA<JsonObject>());
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
        final result = await http.get<JsonObject>(
          path: mockTest,
          headers: mockHeader,
        );
        expect(result, isA<JsonObject>());
        expect(
          result[headersKey],
          isNot(
            containsPair(
              mockBaseHeader.keys.first,
              mockBaseHeader.values.first,
            ),
          ),
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
        final result = http.get<String>(
          path: mockError,
        );
        expect(result, throwsA(isA<NoDataException>()));
      });

      test(
          'throws BadRequestException if the '
          'http call completes with a 400 error', () async {
        final result = http.get<String>(
          path: mockBadRequest,
        );
        expect(result, throwsA(isA<BadRequestException>()));
      });

      test(
          'throws UnauthorisedException if the '
          'http call completes with a 401 error', () async {
        final result = http.get<String>(
          path: mockUnauthorized401,
        );
        expect(result, throwsA(isA<UnauthorisedException>()));
      });

      test(
          'throws UnauthorisedException if the '
          'http call completes with a 403 error', () async {
        final result = http.get<String>(
          path: mockUnauthorized403,
        );
        expect(result, throwsA(isA<UnauthorisedException>()));
      });

      test(
          'throws NoDataException if the '
          'http call completes with a 404 error', () async {
        final result = http.get<String>(
          path: mockNotFound,
        );
        expect(result, throwsA(isA<NoDataException>()));
      });

      test('throws HttpException if invalid arguments', () async {
        final result = http.get<String>(
          baseUrl: '',
          path: '',
        );
        expect(result, throwsA(isA<HttpException>()));
      });

      test('throws CancelException if cancelled manually', () async {
        final result = http.get<String>(
          path: mockTest,
        );
        await http.cancel();
        expect(result, throwsA(isA<CancelException>()));
      });
    });

    group('timeout check', () {
      test('passess if the http call returns before the given timeout time',
          () async {
        final result = await http.get<String>(
          path: mockTimeout,
          receiveTimeout: const Duration(seconds: 3),
        );
        expect(result, isA<String>());
        expect(result, mockTimeout);
      });

      test(
          'throws TimeoutException if the http '
          'call timesout by the given timeout time', () async {
        final result = http.get<String>(
          path: mockTimeout,
          receiveTimeout: const Duration(seconds: 1),
        );
        expect(result, throwsA(isA<TimeoutException>()));
      });
    });
  });
}
