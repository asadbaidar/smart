import 'package:alice/alice.dart';

/// Configure REST API properties to be used later on
/// thoroughout API calls
///
/// Though for a specific use case these can also be
/// overriden in API call functions it [getRequest()]
/// and [postRequest()]
class HttpApiConfig {
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

  static Alice? alice;
}
