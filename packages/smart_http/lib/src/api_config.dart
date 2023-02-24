
/// Configure Http properties to be used later on
/// thoroughout Http calls
///
/// Though for a specific use case these can also be
/// overriden in http request functions
class SmartHttpConfig {
  /// Base url for the project
  static String baseUrl = '';

  /// Header for the project
  static Map<String, String>? headers;

  /// Project timeout duration for request connection
  /// Defaults to `10` seconds
  static Duration connectTimeout = const Duration(seconds: 30);

  /// Project timeout duration for uploading data request
  /// Defaults to `60` seconds
  static Duration sendTimeout = const Duration(seconds: 60);

  /// Project timeout duration for downloading data request
  /// Defaults to `60` seconds
  static Duration receiveTimeout = const Duration(seconds: 60);

  /// Enable logs for the api calls in the project
  /// Defaults to [false]
  static bool enableLogs = false;
}
