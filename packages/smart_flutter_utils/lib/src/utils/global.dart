import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

extension GlobalObject on Object {
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

  /// Returns random integer seeded with [hashCode] and less than [max]
  int random(int max) => Random(hashCode).nextInt(max);
}

extension FocusContext on BuildContext {
  /// Dismiss keyboard
  void unfocus() {
    FocusScope.of(this).requestFocus(FocusNode());
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
