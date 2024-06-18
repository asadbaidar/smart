part of 'utils.dart';

class RouteUri {
  const RouteUri._();

  static String path(
    String path, {
    List<dynamic> routes = const [],
    JsonObject? query,
    bool? refresh,
  }) {
    final List<String> vRoutes = routes.withoutBlanks();
    final queryParameters = {
      'refresh': refresh,
      ...?query,
    }.nonBlankStringValues;
    final uri = Uri(
      pathSegments: [...path.split('/'), ...vRoutes],
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
    return '/$uri';
  }

  static String tab(
    String path, {
    List<dynamic> routes = const [],
    JsonObject? query,
    bool? refresh,
  }) =>
      RouteUri.path(
        'tab/$path',
        routes: routes,
        query: query,
        refresh: refresh,
      );
}

extension RouteArguments on BuildContext {
  JsonObject get routeArguments =>
      $cast<JsonObject>(ModalRoute.of(this)?.settings.arguments) ?? {};

  T? getRouteArgument<T>(String key) => $cast<T>(routeArguments[key]);

  String getRoute({int skip = 0}) => GoRouter.of(this)
      .routerDelegate
      .currentConfiguration
      .uri
      .pathSegments
      .skipLast(skip)
      .join('/');

  String get currentRoute => getRoute();

  String get previousRoute => getRoute(skip: 1);

  String get currentRoutePath => '/$currentRoute';

  String get previousRoutePath => '/$previousRoute';
}

extension GoRouteeStateMatch on GoRouterState {
  bool starts(String path) => fullPath?.startsWith(path) ?? false;

  bool contains(String path) => fullPath?.contains(path) ?? false;
}
