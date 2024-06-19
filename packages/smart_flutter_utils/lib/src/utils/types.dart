part of 'utils.dart';

/// Signature for function that return updated value [T] from the
/// [previous] value of same type passed.
typedef UpdateFromPrevious<T> = T Function(T previous);

typedef OnValue<T> = void Function(T value);

typedef OnValue2<V1, V2> = void Function(V1 v1, V2 v2);

typedef OnString = OnValue<String>;

typedef Callback<T> = T Function();

typedef StringCallback = Callback<String>;

typedef BoolCallback = Callback<bool>;

typedef FutureCallback<T> = Callback<Future<T>>;

typedef FutureOrCallback<T> = Callback<FutureOr<T>>;

typedef OnValueCallback<R, T> = R Function(T value);

typedef OnStringCallback<R> = OnValueCallback<R, String>;

typedef OnValueReturn<T> = T Function(T value);

typedef OnStringReturn = OnValueReturn<String>;
