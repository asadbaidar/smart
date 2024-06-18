import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:smart_http/smart_http.dart';

/// The current server instance.
HttpServer? _server;

Encoding requiredEncodingForCharset(String charset) =>
    Encoding.getByName(charset) ??
    (throw FormatException('Unsupported encoding "$charset".'));

/// The URL for the current server instance.
Uri get serverUrl => Uri.parse('http://localhost:${_server?.port}/');

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

const methodKey = 'method';
const pathKey = 'path';
const queryKey = 'query';
const bodyKey = 'body';
const statusCodeKey = 'status-code';
const headersKey = 'headers';
const encodingTypeKey = 'encoding-type';

const mockGet = 'GET';
const mockPost = 'POST';
const mockPut = 'PUT';
const mockDelete = 'DELETE';

const mockBaseHeader = {'user-agent': 'dartisan'};
const mockHeader = {'test': 'hello'};

const mockTest = 'test';
const mockTimeout = 'timeout';
const mockSuccess = '200-success';
const mockList = 'list';
const mockDownload = 'download';
const mockError = '502-error';
const mockInternalServerError = '500-internal-server-error';
const mockBadRequest = '400-bad-request';
const mockUnauthorized401 = '401-unauthorized';
const mockUnauthorized403 = '403-unauthorized';
const mockNotFound = '404-not-found';

final mockBodyJson = {'body': 1};
final mockBodyList = [1, 2, 3];
const mockBodyString = 'body';
const mockDownloadedFile = 'I am a downloaded file';
const mockQuery = {'query': 'hello'};

/// Starts a new HTTP server.
Future<void> startServer() async {
  _server = (await HttpServer.bind('localhost', 0))
    ..listen((request) async {
      var path = request.uri.path;
      path = path.startsWith('/') ? path.substring(1) : path;
      final response = request.response;
      const statusCode = 200;

      if (path.startsWith(RegExp('[0-9]{3}-'))) {
        final content = path;
        response
          ..statusCode = int.tryParse(path.substring(0, 3)) ?? 502
          ..contentLength = content.length
          ..write(content);
        response.close();
        return;
      }

      if (path == mockTimeout) {
        final content = path;
        Future.delayed(const Duration(seconds: 2), () {
          response
            ..statusCode = 200
            ..contentLength = content.length
            ..write(content)
            ..close();
        });
        return;
      }

      if (path == mockList) {
        final content = jsonEncode(mockBodyList);
        response
          ..statusCode = 200
          ..contentLength = content.length
          ..headers.contentType = ContentType('application', 'json')
          ..write(content);
        response.close();
        return;
      }

      if (path == mockDownload) {
        const content = mockDownloadedFile;
        response
          ..statusCode = 200
          ..contentLength = content.length
          ..headers.set('content-encoding', 'plain')
          ..write(content);

        Future.delayed(const Duration(milliseconds: 300), () {
          response.close();
        });
        return;
      }

      final requestBodyBytes = await ByteStream(request).toBytes();
      final encodingName = request.uri.queryParameters[encodingTypeKey];
      final outputEncoding = encodingName == null
          ? ascii
          : requiredEncodingForCharset(encodingName);

      response.headers.contentType =
          ContentType('application', 'json', charset: outputEncoding.name);
      response.headers.set('single', 'value');

      dynamic requestBody;
      if (requestBodyBytes.isEmpty) {
        requestBody = null;
      } else {
        final encoding = requiredEncodingForCharset(
          request.headers.contentType?.charset ?? 'utf-8',
        );
        requestBody = encoding.decode(requestBodyBytes);
      }

      final content = <String, dynamic>{
        methodKey: request.method,
        pathKey: path,
        queryKey: request.uri.queryParameters,
        statusCodeKey: statusCode,
        headersKey: <String, String>{},
      };
      if (requestBody != null) {
        content[bodyKey] =
            requestBody is String ? requestBody.jsonOrString : requestBody;
      }

      request.headers.forEach((name, values) {
        // These headers are automatically generated by dart:io, so we don't
        // want to test them here.
        if (name == 'cookie' || name == 'host') return;
        final headers = content[headersKey] as Map<String, String>;
        headers[name] = values.first;
      });

      final body = json.encode(content);
      response
        ..statusCode = statusCode
        ..contentLength = body.length
        ..write(body);
      response.close();
    });
}

/// Stops the current HTTP server.
void stopServer() {
  if (_server != null) {
    _server!.close();
    _server = null;
  }
}

/// A stream of chunks of bytes representing a single piece of data.
class ByteStream extends StreamView<List<int>> {
  ByteStream(super.stream);

  /// Returns a single-subscription byte stream that will emit the given bytes
  /// in a single chunk.
  factory ByteStream.fromBytes(List<int> bytes) =>
      ByteStream(Stream.fromIterable([bytes]));

  /// Collects the data of this stream in a [Uint8List].
  Future<Uint8List> toBytes() {
    final completer = Completer<Uint8List>();
    final sink = ByteConversionSink.withCallback(
      (bytes) => completer.complete(Uint8List.fromList(bytes)),
    );
    listen(
      sink.add,
      onError: completer.completeError,
      onDone: sink.close,
      cancelOnError: true,
    );
    return completer.future;
  }

  /// Collect the data of this stream in a [String], decoded according to
  /// [encoding], which defaults to `UTF8`.
  Future<String> bytesToString([Encoding encoding = utf8]) =>
      encoding.decodeStream(this);

  Stream<String> toStringStream([Encoding encoding = utf8]) =>
      encoding.decoder.bind(this);
}
