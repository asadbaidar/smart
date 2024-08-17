part of 'utils.dart';

class RouteUri {
  const RouteUri._();

  static String path(
    String path, {
    List<dynamic> routes = const [],
    JsonObject? query,
    bool? reset,
    bool? reload,
    String? title,
  }) {
    final List<String> vRoutes = routes.withoutBlanks();
    final queryParameters = {
      'reset': reset,
      'reload': reload,
      'title': title,
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
    bool? reset,
    bool? reload,
    String? title,
  }) =>
      RouteUri.path(
        'tab/$path',
        routes: routes,
        query: query,
        reset: reset,
        reload: reload,
        title: title,
      );
}

extension GoRouterStateContext on BuildContext {
  GoRouter get router => GoRouter.of(this);

  GoRouterState get routeState => GoRouterState.of(this);

  Uri get routeUri => routeState.uri;

  Map<String, String> get routeQueryParameters => routeUri.queryParameters;

  Map<String, String> get routePathParameters => routeState.pathParameters;

  String getRoute({
    int skip = 0,
    int? take,
  }) {
    if (take == null) {
      return routeUri.pathSegments.skipLast(skip).join('/');
    }
    return routeUri.pathSegments.take(take).skipLast(skip).join('/');
  }

  String get currentRoute => getRoute();

  String get rootRoute => getRoute(take: 2);

  String get previousRoute => getRoute(skip: 1);

  String get currentRoutePath => '/$currentRoute';

  String get previousRoutePath => '/$previousRoute';

  bool get resetRoute => $castBool(routeQueryParameters['reset']) ?? false;

  bool get reloadRoute => $castBool(routeQueryParameters['reload']) ?? false;

  String? get routeTitle => routeQueryParameters['title'];

  /// Navigate to [location] with optional [extra] data
  void goReplace(String location, {Object? extra}) {
    go(location, extra: extra);
    pushReplacement(location, extra: extra);
  }
}

extension GoRouterStateMatch on GoRouterState {
  bool matches(String path) => fullPath?.startsWith(path) ?? false;

  bool contains(String path) => fullPath?.contains(path) ?? false;
}
