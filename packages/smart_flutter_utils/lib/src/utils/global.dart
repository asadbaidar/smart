part of 'utils.dart';

/// Returns [T] if instance of [T], otherwise null
T? $cast<T>(value) => value == null
    ? null
    : value is T
        ? value
        : null;

/// [apply] mapping with [T] as parameter and [R] as return value
R? $mapTo<T, R>(T? object, R? Function(T it) apply) =>
    object != null ? apply(object) : null;

/// [apply] mapping with dynamic parameter and [R] as return value
R? $mapIt<R>(Object? object, R? Function(dynamic it) apply) =>
    object != null ? apply(object) : null;

List<T>? $mapList<T>(list, T Function(dynamic e) apply) =>
    (list as List?)?.map<T>(apply).toList();

extension GlobalObject on Object {
  /// [apply] mapping with [T] as parameter and [R] as return value
  R mapTo<T, R>(R Function(T it) apply) => apply(this as T);

  /// [apply] mapping with dynamic parameter and [R] as return value
  R mapIt<R>(R Function(dynamic it) apply) => apply(this);

  /// Lets [apply] with [T] as parameter
  T let<T>(T Function(T) apply) => apply(this as T);

  /// Lets [apply] with [R] as return value
  R apply<R>(R Function() apply) => apply();

  /// Lets [apply] without any condition
  void lets(void Function() apply) => apply();

  /// Apply the [operation] with [T] as parameter if [condition] is `true`
  T applyIf<T>(bool? condition, T Function(T) operation) {
    return (condition == true) ? operation(this as T) : this as T;
  }

  /// Repeat the [task] with [T] as parameter for [n] times
  T applyFor<T>(int n, T Function(T) task) {
    T value = this as T;
    n.repeatsFor(() => value = task(value));
    return value;
  }

  /// Repeat the [task] with [T] as parameter for [n] times
  T applyForIndexed<T>(int n, T Function(T v, int i) task) {
    T value = this as T;
    n.repeatsForIndexed((i) => value = task(value, i));
    return value;
  }
}
