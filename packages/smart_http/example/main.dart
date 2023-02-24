import 'package:smart_http/smart_http.dart';

void main() async {
  final http = SmartHttp();

  final result = await http.get(
    baseUrl: 'https://pub.dev',
    path: '/packages/smart_http',
  );

  print(result);
}
