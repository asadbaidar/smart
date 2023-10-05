import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:smart_http/smart_http.dart';
import 'dart:developer' as developer;

import 'package:uuid/uuid.dart';

/// FormData builder helps to build `multipart/form-data` requests.
typedef HttpFormDataBuilder = FormData Function(
  Map<String, dynamic> body,
  List<MultipartFile>? files,
);

/// An enum that represents HTTP methods
enum SmartHttpMethod {
  /// HTTP `DELETE` method.
  delete,

  /// HTTP `GET` method.
  get,

  /// HTTP `PATCH` method.
  patch,

  /// HTTP `POST` method.
  post,

  /// HTTP `PUT` method.
  put,
  ;

  String call() => name.toUpperCase();
}

const _uuid = Uuid();

/// General Repository to interact with any REST API
class SmartHttp {
  SmartHttp() : id = _uuid.v4();

  /// Unique id for this repository
  final String id;

  /// Base url for this repository
  /// Defaults to [SmartHttpConfig.baseUrl]
  String get baseUrl => SmartHttpConfig.baseUrl;

  /// Headers for this repository
  /// Defaults to [SmartHttpConfig.headers]
  Map<String, String>? get headers => SmartHttpConfig.headers;

  /// Repository timeout duration for request connection
  /// Defaults to [SmartHttpConfig.connectTimeout]
  Duration get timeout => SmartHttpConfig.connectTimeout;

  /// Repository timeout duration for uploading data request
  /// Defaults to [SmartHttpConfig.sendTimeout]
  Duration get sendTimeout => SmartHttpConfig.sendTimeout;

  /// Repository timeout duration for downloading data request
  /// Defaults to [SmartHttpConfig.receiveTimeout]
  Duration get receiveTimeout => SmartHttpConfig.receiveTimeout;

  /// Enable logs for the api calls in this repository
  /// Defaults to [SmartHttpConfig.enableLogs]
  bool get enableLogs => SmartHttpConfig.enableLogs;

  /// Used to initiate a HTTP `DELETE` request.
  ///
  /// - [path] is end point that will be attached to the [baseUrl].
  /// - [query] parameters will be attached to [path] with `?`.
  /// - [body] sets Map, List or any http supported type as body of the request.
  ///
  /// [baseUrl] defaults to [SmartHttpConfig.baseUrl] and can be overidden in
  /// this function or in this repository. Same applies to the [headers],
  /// [timeout], and [enableLogs] parameters.
  Future<T> delete<T>({
    String? baseUrl,
    required String path,
    Map<String, dynamic> query = const {},
    dynamic body,
    ProgressCallback? onReceiveProgress,
    Map<String, String>? headers,
    Duration? timeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: SmartHttpMethod.delete,
        query: query,
        body: body,
        onReceiveProgress: onReceiveProgress,
        headers: headers,
        timeout: timeout,
        receiveTimeout: receiveTimeout,
        enableLogs: enableLogs,
      );

  /// Used to initiate a HTTP `GET` request.
  ///
  /// - [path] is end point that will be attached to the [baseUrl].
  /// - [query] parameters will be attached to [path] with `?`.
  /// - [onReceiveProgress] delievers progress updates for downloading requests.
  ///
  /// [baseUrl] defaults to [SmartHttpConfig.baseUrl] and can be overidden in
  /// this function or in this repository. Same applies to the [headers],
  /// [timeout], [receiveTimeout], and [enableLogs] parameters
  Future<T> get<T>({
    String? baseUrl,
    required String path,
    Map<String, dynamic> query = const {},
    ProgressCallback? onReceiveProgress,
    Map<String, String>? headers,
    Duration? timeout,
    Duration? receiveTimeout,
    ResponseType? responseType,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: SmartHttpMethod.get,
        query: query,
        onReceiveProgress: onReceiveProgress,
        headers: headers,
        timeout: timeout,
        receiveTimeout: receiveTimeout,
        enableLogs: enableLogs,
        responseType: responseType,
      );

  /// Used to initiate a HTTP `PATCH` request.
  ///
  /// {@macro request}
  Future<T> patch<T>({
    String? baseUrl,
    required String path,
    Map<String, dynamic> query = const {},
    dynamic body,
    List<SmartHttpFile>? files,
    FormData? formData,
    HttpFormDataBuilder? formDataBuilder,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, String>? headers,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: SmartHttpMethod.patch,
        query: query,
        body: body,
        files: files,
        formData: formData,
        formDataBuilder: formDataBuilder,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        headers: headers,
        timeout: timeout,
        sendTimeout: sendTimeout,
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
    List<SmartHttpFile>? files,
    FormData? formData,
    HttpFormDataBuilder? formDataBuilder,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, String>? headers,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: SmartHttpMethod.post,
        query: query,
        body: body,
        files: files,
        formData: formData,
        formDataBuilder: formDataBuilder,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        headers: headers,
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
    List<SmartHttpFile>? files,
    FormData? formData,
    HttpFormDataBuilder? formDataBuilder,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, String>? headers,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) =>
      request<T>(
        baseUrl: baseUrl,
        path: path,
        method: SmartHttpMethod.put,
        query: query,
        body: body,
        files: files,
        formData: formData,
        formDataBuilder: formDataBuilder,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        headers: headers,
        timeout: timeout,
        sendTimeout: sendTimeout,
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
  /// - [files] List of http files to be automatically converted to multipart files
  ///   and recieve in [formDataBuilder] for `multipart/form-data` requests.
  /// - [formData] custom form data for `multipart/form-data` requests.
  ///
  /// [baseUrl] defaults to [SmartHttpConfig.baseUrl] and can be overidden in
  /// this function or in this repository. Same applies to the [headers],
  /// [timeout], [sendTimeout], [receiveTimeout], and [enableLogs] parameters.
  /// {@endtemplate}
  Future<T> request<T>({
    String? baseUrl,
    required String path,
    required SmartHttpMethod method,
    Map<String, dynamic> query = const {},
    dynamic body,
    List<SmartHttpFile>? files,
    FormData? formData,
    HttpFormDataBuilder? formDataBuilder,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, String>? headers,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    ResponseType? responseType,
    bool? enableLogs,
  }) async {
    baseUrl ??= this.baseUrl;
    headers ??= this.headers;
    timeout ??= this.timeout;
    sendTimeout ??= this.sendTimeout;
    receiveTimeout ??= this.receiveTimeout;
    enableLogs ??= this.enableLogs;
    try {
      final parcel = HttpRequestParcel(
        id: id,
        baseUrl: baseUrl,
        path: path,
        method: method,
        query: query,
        body: body,
        files: files,
        formData: formData,
        formDataBuilder: formDataBuilder,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        headers: headers,
        timeout: timeout,
        sendTimeout: sendTimeout,
        receiveTimeout: receiveTimeout,
        responseType: responseType,
        enableLogs: enableLogs,
      );
      return await httpRequestFromParcel<T>(parcel);
    } catch (e) {
      if (e is SmartHttpException) {
        rethrow;
      } else {
        log(json, path, enableLogs);
        throw SmartHttpException(e.toString());
      }
    }
  }

  /// Used to convert a locally provided [json] String to json Map/List
  Future<T> local<T>(
    String json, {
    bool? enableLogs,
  }) async {
    enableLogs ??= this.enableLogs;
    log(json, 'local.json', enableLogs);
    dynamic rawResponse;
    try {
      rawResponse = jsonDecode(json);
    } catch (e) {
      throw SmartHttpException(e.toString());
    } finally {
      log(rawResponse, 'local.json.raw', enableLogs);
    }
    return rawResponse;
  }

  log(object, [name, bool? enable]) =>
      _log(object, (name ?? runtimeType).toString(), enable ?? enableLogs);

  Future<void> cancel() {
    return httpCancel(id);
  }

  static final Map<String, CancelToken> _cancelTokens = {};

  static Future<void> httpCancel(String id) async {
    await (_cancelTokens.remove(id)?..cancel())?.whenCancel;
  }

  static Future<T> httpRequestFromParcel<T>(HttpRequestParcel parcel) =>
      httpRequest<T>(
        id: parcel.id,
        baseUrl: parcel.baseUrl,
        path: parcel.path,
        method: parcel.method,
        query: parcel.query,
        body: parcel.body,
        files: parcel.files,
        formData: parcel.formData,
        formDataBuilder: parcel.formDataBuilder,
        onSendProgress: parcel.onSendProgress,
        onReceiveProgress: parcel.onReceiveProgress,
        headers: parcel.headers,
        timeout: parcel.timeout,
        sendTimeout: parcel.sendTimeout,
        receiveTimeout: parcel.receiveTimeout,
        responseType: parcel.responseType,
        enableLogs: parcel.enableLogs,
      );

  static Future<T> httpRequest<T>({
    required String id,
    required String baseUrl,
    required String path,
    required SmartHttpMethod method,
    Map<String, dynamic> query = const {},
    dynamic body,
    List<SmartHttpFile>? files,
    FormData? formData,
    HttpFormDataBuilder? formDataBuilder,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, String>? headers,
    Duration? timeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    ResponseType? responseType,
    bool enableLogs = false,
  }) async {
    Dio? dio;
    try {
      dio = Dio();
      dio.interceptors.add(LogInterceptor(
        request: enableLogs,
        requestHeader: enableLogs,
        requestBody: enableLogs,
        responseHeader: enableLogs,
        responseBody: enableLogs,
        error: enableLogs,
        logPrint: (object) => _log(object, path, enableLogs),
      ));
      final isMultipart = formData != null ||
          files?.isNotEmpty == true && formDataBuilder != null;
      dio.options
        ..baseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/'
        ..validateStatus = (status) => status == 200 || status == 201;
      if (timeout != null) {
        dio.options.connectTimeout = timeout;
      }
      if (sendTimeout != null) {
        dio.options.sendTimeout = sendTimeout;
      }
      if (receiveTimeout != null) {
        dio.options.receiveTimeout = receiveTimeout;
      }
      final cancelToken = _cancelTokens[id] = CancelToken();
      query = query.replaceNullWithEmpty;
      _log(formData?.files, 'form-data-files', enableLogs);
      _log(formData?.fields, 'form-data', enableLogs);
      body = body is Map
          ? body.replaceNullWithEmpty
          : body is List
              ? body.replaceNullWithEmpty
              : body;
      _log(id, 'request.id', enableLogs);
      final response = await dio.request<T>(
        path.startsWith('/') ? path.substring(1) : path,
        queryParameters: query,
        data: isMultipart
            ? formData ??
                formDataBuilder!(body, await SmartHttpFile.toMultipart(files!))
            : body,
        options: Options(
          method: method(),
          responseType: responseType,
          contentType: isMultipart ? "multipart/form-data" : null,
          headers: headers,
        ),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
      _log(response.data?.runtimeType, 'response.type', enableLogs);
      return _decodeData<T>(response.data);
    } on DioException catch (e) {
      _log(e, path, enableLogs);
      switch (e.type) {
        case DioExceptionType.cancel:
          throw CancelException();

        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw TimeoutException();

        case DioExceptionType.connectionError:
          throw NoInternetException();

        case DioExceptionType.badCertificate:
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          throw await _invalidResponse(e);
      }
    } catch (e) {
      _log(e, path, enableLogs);
      throw SmartHttpException(e.toString());
    } finally {
      dio?.close();
      _cancelTokens.remove(id);
    }
  }

  /// decode valid/invalid responses based on their types
  static T _decodeData<T>(data) {
    return data is String
        ? data.jsonOrString
        : data is Map<dynamic, dynamic>
            ? data.map((key, value) => MapEntry(key.toString(), value))
            : data;
  }

  /// HTTP error codes - invalid responses
  static Future<SmartHttpException> _invalidResponse(DioException e) async {
    final response = e.response;
    final error = e.error;
    final data = response != null ? _decodeData(response.data) : null;
    final message =
        data is Map<String, dynamic> ? data["message"]?.toString() : null;
    final messageOrError = message ?? e.message;
    final statusCode = response?.statusCode;
    switch (statusCode ?? 0) {
      case 400:
        return BadRequestException(messageOrError);
      case 401:
      case 403:
      case 405:
        return UnauthorisedException(messageOrError);
      case 500:
        return InternalServerException(messageOrError);
      default:
        if (error is SocketException) {
          return NoInternetException();
        }
        return NoDataException(
          statusCode != null ? '$statusCode: ' : '',
        );
    }
  }

  static _log(object, String name, [bool? enable]) {
    if (enable ?? SmartHttpConfig.enableLogs) {
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

class HttpCancelParcel {
  HttpCancelParcel(this.id);

  final String id;

  @override
  String toString() => "$runtimeType: ${{"id": id}}";
}

class HttpRequestParcel {
  HttpRequestParcel({
    required this.id,
    required this.baseUrl,
    required this.path,
    required this.method,
    this.query = const {},
    this.body,
    this.files,
    this.formData,
    this.formDataBuilder,
    this.onSendProgress,
    this.onReceiveProgress,
    this.headers,
    this.timeout,
    this.sendTimeout,
    this.receiveTimeout,
    this.responseType,
    this.enableLogs = false,
  });

  final String id;
  final String baseUrl;
  final String path;
  final SmartHttpMethod method;
  final Map<String, dynamic> query;
  final dynamic body;
  final List<SmartHttpFile>? files;
  final FormData? formData;
  final HttpFormDataBuilder? formDataBuilder;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;
  final Map<String, String>? headers;
  final Duration? timeout;
  final Duration? sendTimeout;
  final Duration? receiveTimeout;
  final ResponseType? responseType;
  final bool enableLogs;

  @override
  String toString() => "$runtimeType: ${{
        "id": id,
        "baseUrl": baseUrl,
        "path": path,
        "method": method,
        "query": query,
        "body": body,
        "files": files,
        "formData": formData,
        "formDataBuilder": formDataBuilder,
        "onSendProgress": onSendProgress,
        "onReceiveProgress": onReceiveProgress,
        "headers": headers,
        "timeout": timeout,
        "sendTimeout": sendTimeout,
        "receiveTimeout": receiveTimeout,
        "responseType": responseType,
        "enableLogs": enableLogs,
      }}";
}

extension _MapDynamic<K> on Map<K, dynamic> {
  Map<K, dynamic> get replaceNullWithEmpty => isEmpty
      ? this
      : Map.fromEntries(entries.map((e) => MapEntry(e.key, e.value ?? "")));
}

extension _ListDynamic on List<dynamic> {
  List<dynamic> get replaceNullWithEmpty =>
      isEmpty ? this : map((e) => e ?? "").toList();
}

extension JsonString on String {
  get jsonOrString {
    try {
      return jsonDecode(this);
    } catch (e) {
      return this;
    }
  }
}
