/// Configure Http properties to be used later on
/// thoroughout Http calls
///
/// Though for a specific use case these can also be
/// overriden in http request functions
class HttpClientConfig {
  const HttpClientConfig({
    this.baseUrl = '',
    this.headers,
    this.connectTimeout = const Duration(seconds: 10),
    this.sendTimeout = const Duration(seconds: 60),
    this.receiveTimeout = const Duration(seconds: 60),
    this.enableLogs = false,
  });

  HttpClientConfig copyWith({
    String? baseUrl,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? sendTimeout,
    Duration? receiveTimeout,
    bool? enableLogs,
  }) {
    return HttpClientConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      headers: headers ?? this.headers,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      enableLogs: enableLogs ?? this.enableLogs,
    );
  }

  /// Base url for the project
  final String baseUrl;

  /// Header for the project
  final Map<String, String>? headers;

  /// Project timeout duration for request connection
  /// Defaults to `10` seconds
  final Duration connectTimeout;

  /// Project timeout duration for uploading data request
  /// Defaults to `60` seconds
  final Duration sendTimeout;

  /// Project timeout duration for downloading data request
  /// Defaults to `60` seconds
  final Duration receiveTimeout;

  /// Enable logs for the api calls in the project
  /// Defaults to `false`
  final bool enableLogs;
}
