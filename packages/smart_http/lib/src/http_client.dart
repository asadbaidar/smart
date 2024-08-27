import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:smart_http/smart_http.dart';
import 'package:uuid/uuid.dart';

typedef HttpResponseType = ResponseType;
typedef HttpProgressCallback = ProgressCallback;

/// An enum that represents HTTP methods
enum HttpMethod {
  /// HTTP `GET` method.
  get,

  /// HTTP `POST` method.
  post,

  /// HTTP `PUT` method.
  put,

  /// HTTP `PATCH` method.
  patch,

  /// HTTP `DELETE` method.
  delete,
  ;

  String call() => name.toUpperCase();
}

const uuid = Uuid();

/// General Repository to interact with any REST API
class HttpClient {
  HttpClient({
    required this.clientConfig,
  }) : id = uuid.v4();

  /// Unique id for this client
  final String id;

  /// Configuration for this client
  final HttpClientConfig clientConfig;

  /// Cancel tokens for this client
  final Map<String, CancelToken> _cancelTokens = {};

  /// Base url for this repository
  /// Defaults to [HttpClientConfig.baseUrl]
  String get baseUrl => clientConfig.baseUrl;

  /// Headers for this repository
  /// Defaults to [HttpClientConfig.headers]
  Map<String, String>? get headers => clientConfig.headers;

  /// Repository timeout duration for request connection
  /// Defaults to [HttpClientConfig.connectTimeout]
  Duration get timeout => clientConfig.connectTimeout;

  /// Repository timeout duration for uploading data request
  /// Defaults to [HttpClientConfig.sendTimeout]
  Duration get sendTimeout => clientConfig.sendTimeout;

  /// Repository timeout duration for downloading data request
  /// Defaults to [HttpClientConfig.receiveTimeout]
  Duration get receiveTimeout => clientConfig.receiveTimeout;

  /// Enable logs for the api calls in this repository
  /// Defaults to [HttpClientConfig.enableLogs]
  bool get enableLogs => clientConfig.enableLogs;

  /// Used to initiate a HTTP `GET` request.
  ///
  /// - [path] is end point that will be attached to the [baseUrl].
  /// - [query] parameters will be attached to [path] with `?`.
  /// - [onReceiveProgress] delievers progress updates for downloading requests.
  ///
  /// [baseUrl] defaults to [HttpClientConfig.baseUrl] and can be overidden in
  /// this function or in this repository. Same applies to the [headers],
  /// [timeout], [receiveTimeout], and [enableLogs] parameters
  Future<T> get<T>({
    String? baseUrl,
    required String path,
    Map<String, dynamic> query = const {},
    Map<String, String>? headers,
    HttpProgressCallback? onReceiveProgress,
    HttpResponseType? responseType,
    Duration? timeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: HttpMethod.get,
        query: query,
        onReceiveProgress: onReceiveProgress,
        responseType: responseType,
        headers: headers,
        timeout: timeout,
        receiveTimeout: receiveTimeout,
        enableLogs: enableLogs,
      );

  /// Used to initiate a HTTP `POST` request.
  ///
  /// {@macro request}
  Future<T> post<T>({
    String? baseUrl,
    required String path,
    Map<String, dynamic> query = const {},
    dynamic body,
    HttpFormData? formData,
    Map<String, String>? headers,
    HttpProgressCallback? onSendProgress,
    HttpProgressCallback? onReceiveProgress,
    HttpResponseType? responseType,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: HttpMethod.post,
        query: query,
        body: body,
        formData: formData,
        headers: headers,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        responseType: responseType,
        timeout: timeout,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        enableLogs: enableLogs,
      );

  /// Used to initiate a HTTP `PUT` request.
  ///
  /// {@macro request}
  Future<T> put<T>({
    String? baseUrl,
    required String path,
    Map<String, dynamic> query = const {},
    dynamic body,
    List<HttpFile>? files,
    HttpFormData? formData,
    Map<String, String>? headers,
    HttpProgressCallback? onSendProgress,
    HttpProgressCallback? onReceiveProgress,
    HttpResponseType? responseType,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: HttpMethod.put,
        query: query,
        body: body,
        formData: formData,
        headers: headers,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        responseType: responseType,
        timeout: timeout,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        enableLogs: enableLogs,
      );

  /// Used to initiate a HTTP `PATCH` request.
  ///
  /// {@macro request}
  Future<T> patch<T>({
    String? baseUrl,
    required String path,
    Map<String, dynamic> query = const {},
    dynamic body,
    HttpFormData? formData,
    Map<String, String>? headers,
    HttpProgressCallback? onSendProgress,
    HttpProgressCallback? onReceiveProgress,
    HttpResponseType? responseType,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: HttpMethod.patch,
        query: query,
        body: body,
        formData: formData,
        headers: headers,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        responseType: responseType,
        timeout: timeout,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        enableLogs: enableLogs,
      );

  /// Used to initiate a HTTP `DELETE` request.
  ///
  /// - [path] is end point that will be attached to the [baseUrl].
  /// - [query] parameters will be attached to [path] with `?`.
  /// - [body] sets Map, List or any http supported type as body of the request.
  ///
  /// [baseUrl] defaults to [HttpClientConfig.baseUrl] and can be overidden in
  /// this function or in this repository. Same applies to the [headers],
  /// [timeout], and [enableLogs] parameters.
  Future<T> delete<T>({
    String? baseUrl,
    required String path,
    Map<String, dynamic> query = const {},
    dynamic body,
    Map<String, String>? headers,
    HttpProgressCallback? onReceiveProgress,
    HttpResponseType? responseType,
    Duration? timeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: HttpMethod.delete,
        query: query,
        body: body,
        headers: headers,
        onReceiveProgress: onReceiveProgress,
        responseType: responseType,
        timeout: timeout,
        receiveTimeout: receiveTimeout,
        enableLogs: enableLogs,
      );

  /// Used to initiate a general HTTP request.
  ///
  /// - [method] sets the HTTP method for the request.
  /// {@template request}
  /// - [path] is end point that will be attached to the [baseUrl].
  /// - [query] parameters will be attached to [path] with `?`.
  /// - [onSendProgress] delievers progress updates for uploading requests.
  /// - [onReceiveProgress] delievers progress updates for downloading response.
  /// - [body] sets Map, List or any http supported type as body of the request.
  /// - [formData] custom form data for `multipart/form-data` requests.
  ///
  /// [baseUrl] defaults to [HttpClientConfig.baseUrl] and can be overidden in
  /// this function or in this repository. Same applies to the [headers],
  /// [timeout], [sendTimeout], [receiveTimeout], and [enableLogs] parameters.
  /// {@endtemplate}
  Future<T> request<T>({
    String? baseUrl,
    required String path,
    required HttpMethod method,
    Map<String, dynamic> query = const {},
    dynamic body,
    HttpFormData? formData,
    Map<String, String>? headers,
    HttpProgressCallback? onSendProgress,
    HttpProgressCallback? onReceiveProgress,
    HttpResponseType? responseType,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) async {
    baseUrl ??= this.baseUrl;
    headers ??= this.headers;
    timeout ??= this.timeout;
    sendTimeout ??= this.sendTimeout;
    receiveTimeout ??= this.receiveTimeout;
    enableLogs ??= this.enableLogs;
    Dio? dio;
    try {
      dio = Dio();
      dio.interceptors.add(
        LogInterceptor(
          request: enableLogs,
          requestHeader: enableLogs,
          requestBody: enableLogs,
          responseHeader: enableLogs,
          responseBody: enableLogs,
          error: enableLogs,
          logPrint: (object) => _log(object, path, enableLogs),
        ),
      );

      dio.options
        ..baseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/'
        ..validateStatus = (status) => successCodes.contains(status);

      dio.options.connectTimeout = timeout;
      dio.options.sendTimeout = sendTimeout;
      dio.options.receiveTimeout = receiveTimeout;

      final cancelToken = _cancelTokens[id] = CancelToken();
      final queryNonNull = query.replaceNullWithEmpty;

      final isMultipart = formData != null;
      final data = formData ?? body;

      _log(id, 'request.id', enableLogs);
      _log(queryNonNull, 'request.query', enableLogs);
      _log(formData?.files, 'request.form-data-files', enableLogs);
      _log(formData?.fields, 'request.form-data', enableLogs);

      final response = await dio.request<T>(
        path.startsWith('/') ? path.substring(1) : path,
        queryParameters: queryNonNull,
        data: data,
        options: Options(
          method: method(),
          responseType: responseType ?? ResponseType.json,
          contentType:
              isMultipart ? Headers.multipartFormDataContentType : null,
          headers: headers,
        ),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );

      _log(queryNonNull, 'request.query', enableLogs);
      _log(formData?.files, 'request.form-data-files', enableLogs);
      _log(formData?.fields, 'request.form-data', enableLogs);
      _log(response.data?.runtimeType, 'response.type', enableLogs);
      return await decodeData(response.data);
    } on DioException catch (e) {
      _log(e, path, enableLogs);
      final error = await catchError(e);
      throw error ?? await decodeError(e);
    } catch (e) {
      _log(e, path, enableLogs);
      throw HttpException(e.toString());
    } finally {
      dio?.close();
      _cancelTokens.remove(id);
    }
  }

  /// List of success status codes
  List<int> get successCodes =>
      [200, 201, 202, 203, 204, 205, 206, 207, 208, 226];

  /// Decode data based on its type
  Future<T> decodeData<T>(dynamic data) async {
    final result = data is String
        ? data.jsonOrString
        : data is Map<dynamic, dynamic>
            ? data.map((key, value) => MapEntry(key.toString(), value))
            : data;
    return (result == null
            ? null
            : result is T
                ? result
                : null) ??
        (throw TypeMismatchException(result));
  }

  /// Catch errors based on their types
  Future<HttpException?> catchError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.cancel:
        return const CancelException();

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NoInternetException();

      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        return null;
    }
  }

  /// Decode error responses based on their status codes
  Future<HttpException> decodeError(DioException error) async {
    final response = error.response;
    final originalError = error.error;
    final statusCode = response?.statusCode ?? 0;
    final data = response != null ? await decodeErrorData(response.data) : null;
    final messageOrError =
        decodeErrorMessage(data, statusCode) ?? error.message;
    switch (statusCode) {
      case 400:
        return BadRequestException(messageOrError);
      case 401:
      case 403:
      case 405:
        return UnauthorisedException(messageOrError);
      case 500:
        return InternalServerException(messageOrError);
      default:
        if (originalError is SocketException) {
          return const NoInternetException();
        }
        return NoDataException(
          statusCode != 0 ? '$statusCode: ' : '',
        );
    }
  }

  /// Decode error data based on its type
  Future<dynamic> decodeErrorData(dynamic data) async {
    return data is String
        ? data.jsonOrString
        : data is Map<dynamic, dynamic>
            ? data.map((key, value) => MapEntry(key.toString(), value))
            : data;
  }

  /// Decode error messages from the response data
  String? decodeErrorMessage(dynamic data, int statusCode) {
    if (data is String && data.trim().isNotEmpty) return data;

    if (data is Map<String, dynamic> && data.isNotEmpty) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) {
        return message;
      }
      final error = data['error'];
      if (error is String && error.trim().isNotEmpty) {
        return error;
      }
    }
    return null;
  }

  /// Used to cancel a request with a specific key or the default id
  Future<void> cancel([String? key]) async {
    try {
      await (_cancelTokens.remove(key ?? id)?..cancel())?.whenCancel;
    } catch (e) {
      log(e);
    }
  }

  void log(dynamic object, [dynamic name, bool? enable]) =>
      _log(object, (name ?? runtimeType).toString(), enable ?? enableLogs);

  void _log(dynamic object, String name, [bool? enable]) {
    if (enable ?? clientConfig.enableLogs) {
      developer.log(
        '$object',
        name: 'http_api.${name.startsWith('/') ? name.replaceFirst(
            RegExp('/*'),
            '',
          ) : name}',
      );
    }
  }
}

extension MapDynamic<K> on Map<K, dynamic> {
  Map<K, dynamic> get replaceNullWithEmpty => isEmpty
      ? this
      : Map.fromEntries(entries.map((e) => MapEntry(e.key, e.value ?? '')));
}

extension ListDynamic on List<dynamic> {
  List<dynamic> get replaceNullWithEmpty =>
      isEmpty ? this : map((e) => e ?? '').toList();
}

extension on String {
  dynamic get jsonOrString {
    try {
      return jsonDecode(this);
    } catch (e) {
      return this;
    }
  }
}
