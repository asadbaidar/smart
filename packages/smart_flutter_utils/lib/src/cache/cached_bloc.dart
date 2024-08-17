// ignore_for_file: avoid_catching_errors

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_flutter_utils/src/cache/cache.dart';

/// {@template cached_bloc}
/// Specialized [Bloc] which handles initializing the [Bloc] state
/// based on the persisted state. This allows state to be persisted
/// across hot restarts as well as complete app restarts.
///
/// ```dart
/// abstract class CounterEvent {}
/// class CounterIncrementPressed extends CounterEvent {}
/// class CounterDecrementPressed extends CounterEvent {}
///
/// class CounterBloc extends CachedBloc<CounterEvent, int> {
///   CounterBloc() : super(0) {
///     on<CounterIncrementPressed>((event, emit) => emit(state + 1));
///     on<CounterDecrementPressed>((event, emit) => emit(state - 1));
///   }
///
///   @override
///   int fromJson(Map<String, dynamic> json) => json['value'] as int;
///
///   @override
///   Map<String, int> toJson(int state) => {'value': state};
/// }
/// ```
///
/// {@endtemplate}
abstract class CachedBloc<Event, State> extends Bloc<Event, State>
    with CachedMixin {
  /// {@macro cached_bloc}
  CachedBloc(super.state) {
    cache();
  }

  static StorageClient? _storage;

  /// Initialize the instance of [Storage] which will be used to
  /// manage persisting/restoring the [Bloc] state.
  static void initialize({StorageClient? storage}) =>
      _storage = storage ?? CacheStorage();

  /// Instance of [Storage] which will be used to
  /// manage persisting/restoring the [Bloc] state.
  static StorageClient get storage {
    if (_storage == null) throw const StorageNotFound();
    return _storage!;
  }

  @visibleForTesting
  static void write<T>(CachedMixin<T> bloc) {
    storage.write(
      bloc.storageToken,
      value: bloc.toJson(bloc.state) ?? {},
    );
  }
}

/// {@template cached_cubit}
/// Specialized [Cubit] which handles initializing the [Cubit] state
/// based on the persisted state. This allows state to be persisted
/// across application restarts.
///
/// ```dart
/// class CounterCubit extends CachedCubit<int> {
///   CounterCubit() : super(0);
///
///   void increment() => emit(state + 1);
///   void decrement() => emit(state - 1);
///
///   @override
///   int fromJson(Map<String, dynamic> json) => json['value'] as int;
///
///   @override
///   Map<String, int> toJson(int state) => {'value': state};
/// }
/// ```
///
/// {@endtemplate}
abstract class CachedCubit<State> extends Cubit<State> with CachedMixin<State> {
  /// {@macro cached_cubit}
  CachedCubit(super.state) {
    cache();
  }
}

/// A mixin which enables automatic state persistence
/// for [Bloc] and [Cubit] classes.
///
/// The [cache] method must be invoked in the constructor body
/// when using the [CachedMixin] directly.
///
/// If a mixin is not necessary, it is recommended to
/// extend [CachedBloc] and [CachedCubit] respectively.
///
/// ```dart
/// class CounterBloc extends Bloc<CounterEvent, int> with CachedMixin {
///  CounterBloc() : super(0) {
///    cache();
///  }
///  ...
/// }
/// ```
///
/// See also:
///
/// * [CachedBloc] to enable automatic state persistence/restoration with [Bloc]
/// * [CachedCubit] to enable automatic state persistence/restoration with [Cubit]
///
mixin CachedMixin<State> on BlocBase<State> {
  /// Populates the internal state storage with the latest state.
  /// This should be called when using the [CachedMixin]
  /// directly within the constructor body.
  ///
  /// ```dart
  /// class CounterBloc extends Bloc<CounterEvent, int> with CachedMixin {
  ///  CounterBloc() : super(0) {
  ///    cache();
  ///  }
  ///  ...
  /// }
  /// ```
  void cache() {
    final storage = CachedBloc.storage;
    try {
      final stateJson = storage.read<Map<dynamic, dynamic>>(storageToken);
      _state = stateJson != null ? _fromJson(stateJson) : super.state;
    } catch (error, stackTrace) {
      onError(error, stackTrace);
      _state = super.state;
    }

    try {
      final stateJson = _toJson(state);
      if (stateJson != null) {
        storage
            .write(storageToken, value: stateJson)
            .then((_) {}, onError: onError);
      }
    } catch (error, stackTrace) {
      onError(error, stackTrace);
      if (error is StorageNotFound) rethrow;
    }
  }

  State? _state;

  @override
  State get state => _state ?? super.state;

  @override
  void onChange(Change<State> change) {
    super.onChange(change);
    final storage = CachedBloc.storage;
    final state = change.nextState;
    try {
      final stateJson = _toJson(state);
      if (stateJson != null) {
        storage
            .write(storageToken, value: stateJson)
            .then((_) {}, onError: onError);
      }
    } catch (error, stackTrace) {
      onError(error, stackTrace);
      rethrow;
    }
    _state = state;
  }

  State? _fromJson(dynamic json) {
    final dynamic traversedJson = _traverseRead(json);
    final castJson = _cast<Map<String, dynamic>>(traversedJson);
    return fromJson(castJson ?? <String, dynamic>{});
  }

  Map<String, dynamic>? _toJson(State state) {
    return _cast<Map<String, dynamic>>(_traverseWrite(toJson(state)).value);
  }

  dynamic _traverseRead(dynamic value) {
    if (value is Map) {
      return value.map<String, dynamic>((dynamic key, dynamic value) {
        return MapEntry<String, dynamic>(
          _cast<String>(key) ?? '',
          _traverseRead(value),
        );
      });
    }
    if (value is List) {
      for (var i = 0; i < value.length; i++) {
        value[i] = _traverseRead(value[i]);
      }
    }
    return value;
  }

  T? _cast<T>(dynamic x) => x is T ? x : null;

  _Traversed _traverseWrite(Object? value) {
    final dynamic traversedAtomicJson = _traverseAtomicJson(value);
    if (traversedAtomicJson is! NIL) {
      return _Traversed.atomic(traversedAtomicJson);
    }
    final dynamic traversedComplexJson = _traverseComplexJson(value);
    if (traversedComplexJson is! NIL) {
      return _Traversed.complex(traversedComplexJson);
    }
    try {
      _checkCycle(value);
      final dynamic customJson = _toEncodable(value);
      final dynamic traversedCustomJson = _traverseJson(customJson);
      if (traversedCustomJson is NIL) {
        throw CachedUnsupportedError(value);
      }
      _removeSeen(value);
      return _Traversed.complex(traversedCustomJson);
    } on CachedCyclicError catch (e) {
      throw CachedUnsupportedError(value, cause: e);
    } on CachedUnsupportedError {
      rethrow; // do not stack `CachedUnsupportedError`
    } catch (e) {
      throw CachedUnsupportedError(value, cause: e);
    }
  }

  dynamic _traverseAtomicJson(dynamic object) {
    if (object is num) {
      if (!object.isFinite) return const NIL();
      return object;
    } else if (identical(object, true)) {
      return true;
    } else if (identical(object, false)) {
      return false;
    } else if (object == null) {
      return null;
    } else if (object is String) {
      return object;
    }
    return const NIL();
  }

  dynamic _traverseComplexJson(dynamic object) {
    if (object is List) {
      if (object.isEmpty) return object;
      _checkCycle(object);
      List<dynamic>? list;
      for (var i = 0; i < object.length; i++) {
        final traversed = _traverseWrite(object[i]);
        list ??= traversed.outcome == _Outcome.atomic
            ? object.sublist(0)
            : (<dynamic>[]..length = object.length);
        list[i] = traversed.value;
      }
      _removeSeen(object);
      return list;
    } else if (object is Map) {
      _checkCycle(object);
      final map = <String, dynamic>{};
      object.forEach((dynamic key, dynamic value) {
        final castKey = _cast<String>(key);
        if (castKey != null) {
          map[castKey] = _traverseWrite(value).value;
        }
      });
      _removeSeen(object);
      return map;
    }
    return const NIL();
  }

  dynamic _traverseJson(dynamic object) {
    final dynamic traversedAtomicJson = _traverseAtomicJson(object);
    return traversedAtomicJson is! NIL
        ? traversedAtomicJson
        : _traverseComplexJson(object);
  }

  // ignore: avoid_dynamic_calls
  dynamic _toEncodable(dynamic object) => object.toJson();

  final _seen = <dynamic>[];

  void _checkCycle(Object? object) {
    for (var i = 0; i < _seen.length; i++) {
      if (identical(object, _seen[i])) {
        throw CachedCyclicError(object);
      }
    }
    _seen.add(object);
  }

  void _removeSeen(dynamic object) {
    assert(_seen.isNotEmpty, 'seen must not be empty');
    assert(identical(_seen.last, object), 'last seen object must be identical');
    _seen.removeLast();
  }

  /// [id] is used to uniquely identify multiple instances
  /// of the same [CachedBloc] type.
  /// In most cases it is not necessary;
  /// however, if you wish to intentionally have multiple instances
  /// of the same [CachedBloc], then you must override [id]
  /// and return a unique identifier for each [CachedBloc] instance
  /// in order to keep the caches independent of each other.
  String get id => '';

  /// Storage prefix which can be overridden to provide a custom
  /// storage namespace.
  /// Defaults to [runtimeType] but should be overridden in cases
  /// where stored data should be resilient to obfuscation or persist
  /// between debug/release builds.
  String get storagePrefix => runtimeType.toString();

  /// `storageToken` is used as registration token for cached storage.
  /// Composed of [storagePrefix] and [id].
  @nonVirtual
  String get storageToken => '$storagePrefix$id';

  /// [clear] is used to wipe or invalidate the cache of a [CachedBloc].
  /// Calling [clear] will delete the cached state of the bloc
  /// but will not modify the current state of the bloc.
  Future<void> clear() => CachedBloc.storage.delete(storageToken);

  /// Responsible for converting the `Map<String, dynamic>` representation
  /// of the bloc state into a concrete instance of the bloc state.
  State? fromJson(Map<String, dynamic> json);

  /// Responsible for converting a concrete instance of the bloc state
  /// into the the `Map<String, dynamic>` representation.
  ///
  /// If [toJson] returns `null`, then no state changes will be persisted.
  Map<String, dynamic>? toJson(State state);
}

/// Reports that an object could not be serialized due to cyclic references.
/// When the cycle is detected, a [CachedCyclicError] is thrown.
class CachedCyclicError extends CachedUnsupportedError {
  /// The first object that was detected as part of a cycle.
  CachedCyclicError(super.object);

  @override
  String toString() => 'Cyclic error while state traversing';
}

/// {@template storage_not_found}
/// Exception thrown if there was no [CachedStorage] specified.
/// This is most likely due to forgetting to setup the [CachedStorage]:
///
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   CachedCubit.storage = await CachedStorage.build();
///   runApp(MyApp());
/// }
/// ```
///
/// {@endtemplate}
class StorageNotFound implements Exception {
  /// {@macro storage_not_found}
  const StorageNotFound();

  @override
  String toString() {
    return 'Storage was accessed before it was initialized.\n'
        'Please ensure that storage has been initialized.\n\n'
        'For example:\n\n'
        'CachedBloc.storage = await CachedStorage.build();';
  }
}

/// Reports that an object could not be serialized.
/// The [unsupportedObject] field holds object that failed to be serialized.
///
/// If an object isn't directly serializable, the serializer calls the `toJson`
/// method on the object. If that call fails, the error will be stored in the
/// [cause] field. If the call returns an object that isn't directly
/// serializable, the [cause] is null.
class CachedUnsupportedError extends Error {
  /// The object that failed to be serialized.
  /// Error of attempt to serialize through `toJson` method.
  CachedUnsupportedError(
    this.unsupportedObject, {
    this.cause,
  });

  /// The object that could not be serialized.
  final Object? unsupportedObject;

  /// The exception thrown when trying to convert the object.
  final Object? cause;

  @override
  String toString() {
    final safeString = Error.safeToString(unsupportedObject);
    final prefix = cause != null
        ? 'Converting object to an encodable object failed:'
        : 'Converting object did not return an encodable object:';
    return '$prefix $safeString';
  }
}

/// {@template NIL}
/// Type which represents objects that do not support json encoding
///
/// This should never be used and is exposed only for testing purposes.
/// {@endtemplate}
@visibleForTesting
class NIL {
  /// {@macro NIL}
  const NIL();
}

enum _Outcome { atomic, complex }

class _Traversed {
  _Traversed._({required this.outcome, required this.value});
  _Traversed.atomic(dynamic value)
      : this._(outcome: _Outcome.atomic, value: value);
  _Traversed.complex(dynamic value)
      : this._(outcome: _Outcome.complex, value: value);
  final _Outcome outcome;
  final dynamic value;
}
