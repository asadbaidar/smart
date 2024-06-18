// ignore_for_file: avoid_print

import 'package:smart_http/smart_http.dart';

void main() async {
  final http = HttpClient(
    clientConfig: const HttpClientConfig(enableLogs: true),
  );

  final result = await http.get<String>(
    baseUrl: 'https://pub.dev',
    path: '/packages/smart_http',
  );

  print(result);
}
