import 'package:test/test.dart';
import 'package:smart_http/smart_http.dart';

import '../mocks.dart';

void main() {
  late HttpApi httpApi;

  setUp(() async {
    await startServer();
    httpApi = HttpApi();
    HttpApiConfig.baseUrl = serverUrl.toString();
    HttpApiConfig.headers = mockBaseHeader;
    HttpApiConfig.connectTimeout = const Duration(seconds: 1);
    HttpApiConfig.receiveTimeout = const Duration(seconds: 5);
    HttpApiConfig.enableLogs = true;
  });

  tearDown(stopServer);

  group('HttpApi.delete() request', () {
    group('works with', () {
      test('json body', () async {
        final result = await httpApi.delete(
          path: mockTest,
          body: mockBodyJson,
        );
        expect(result, isA<Map<String, dynamic>>());
        expect(result[pathKey], mockTest);
        expect(result[statusCodeKey], 200);
        expect(result[methodKey], HttpMethod.delete());
        expect(result[bodyKey], mockBodyJson);
      });

      test('list body', () async {
        final result = await httpApi.delete(
          path: mockTest,
          body: mockBodyList,
        );
        expect(result, isA<Map<String, dynamic>>());
        expect(result[pathKey], mockTest);
        expect(result[statusCodeKey], 200);
        expect(result[methodKey], HttpMethod.delete());
        expect(result[bodyKey], mockBodyList);
      });

      test('string body', () async {
        final result = await httpApi.delete(
          path: mockTest,
          body: mockBodyString,
        );
        expect(result, isA<Map<String, dynamic>>());
        expect(result[pathKey], mockTest);
        expect(result[statusCodeKey], 200);
        expect(result[methodKey], HttpMethod.delete());
        expect(result[bodyKey], mockBodyString);
      });

      test('no body', () async {
        final result = await httpApi.delete(
          path: mockTest,
        );
        expect(result, isA<Map<String, dynamic>>());
        expect(result[pathKey], mockTest);
        expect(result[statusCodeKey], 200);
        expect(result[methodKey], HttpMethod.delete());
        expect(result[bodyKey], null);
      });

      test('query parameters', () async {
        final result = await httpApi.delete(
          path: mockTest,
          query: mockQuery,
        );
        expect(result, isA<Map<String, dynamic>>());
        expect(result[pathKey], mockTest);
        expect(result[statusCodeKey], 200);
        expect(result[methodKey], HttpMethod.delete());
        expect(result[queryKey], mockQuery);
      });

      test('string response', () async {
        final result = await httpApi.delete(
          path: mockSuccess,
        );
        expect(result, isA<String>());
        expect(result, mockSuccess);
      });

      test('list response', () async {
        final result = await httpApi.delete(
          path: mockList,
        );
        expect(result, isA<List>());
        expect(result, mockBodyList);
      });
    });

    group('headers check', () {
      test('passes if default headers are set', () async {
        final result = await httpApi.delete(
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
        final result = await httpApi.delete(
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
          'throws FetchDataException if the '
          'http call completes with an error', () async {
        final result = httpApi.delete(
          path: mockError,
        );
        expect(result, throwsA(isA<NoDataException>()));
      });

      test(
          'throws BadRequestException if the '
          'http call completes with a 400 error', () async {
        final result = httpApi.delete(
          path: mockBadRequest,
        );
        expect(result, throwsA(isA<BadRequestException>()));
      });

      test(
          'throws UnauthorisedException if the '
          'http call completes with a 401 error', () async {
        final result = httpApi.delete(
          path: mockUnauthorized401,
        );
        expect(result, throwsA(isA<UnauthorisedException>()));
      });

      test(
          'throws UnauthorisedException if the '
          'http call completes with a 403 error', () async {
        final result = httpApi.delete(
          path: mockUnauthorized403,
        );
        expect(result, throwsA(isA<UnauthorisedException>()));
      });

      test(
          'throws FetchDataException if the '
          'http call completes with a 404 error', () async {
        final result = httpApi.delete(
          path: mockNotFound,
        );
        expect(result, throwsA(isA<NoDataException>()));
      });

      test('throws FetchDataException if no connection', () async {
        final result = httpApi.delete(
          baseUrl: '',
          path: '',
        );
        expect(result, throwsA(isA<NoDataException>()));
      });

      test('throws CancelException if cancelled manually', () async {
        final result = httpApi.delete(
          path: mockTest,
        );
        httpApi.cancel();
        expect(result, throwsA(isA<CancelException>()));
      });
    });

    group('timeout check', () {
      test('passess if the http call returns before the given timeout time',
          () async {
        final result = await httpApi.delete(
          path: mockTimeout,
          receiveTimeout: const Duration(seconds: 3),
        );
        expect(result, isA<String>());
        expect(result, mockTimeout);
      });

      test(
          'throws TimeoutException if the http '
          'call timesout by the given timeout time', () async {
        final result = httpApi.delete(
          path: mockTimeout,
          receiveTimeout: const Duration(seconds: 1),
        );
        expect(result, throwsA(isA<TimeoutException>()));
      });
    });
  });
}
