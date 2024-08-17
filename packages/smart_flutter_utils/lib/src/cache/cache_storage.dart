import 'dart:async';

import 'package:get_storage/get_storage.dart';

abstract class AsyncStorageClient {
  /// Writes the provide [key], [value] pair to the storage.
  Future<void> write(String key, {required Object value});

  /// Looks up the value for the provided [key] asynchrounously.
  FutureOr<T?> read<T extends Object>(String key);

  /// Deletes the value for the provided [key].
  Future<void> delete(String key);

  /// Deletes all keys from the storage.
  Future<void> clear();

  /// Closes the storage.
  Future<void> close() => Future.value();
}

abstract class StorageClient extends AsyncStorageClient {
  /// Looks up the value for the provided [key].
  @override
  T? read<T extends Object>(String key);
}

const _kCacheStorageName = 'cache_storage';

/// {@template cache_storage}
/// A persistant cache storage client.
/// {@endtemplate}
class CacheStorage extends StorageClient {
  /// {@macro cache_storage}
  CacheStorage() : _storage = GetStorage(_kCacheStorageName);

  final GetStorage _storage;

  static Future<bool> initialize() => GetStorage.init(_kCacheStorageName);

  /// Writes the provide [key], [value] pair to the local storage cache.
  @override
  Future<void> write(String key, {required Object value}) =>
      _storage.write(key, value);

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  @override
  T? read<T extends Object>(String key) {
    final value = _storage.read<T>(key);
    if (value is T) return value;
    return null;
  }

  /// Deletes the value for the provided [key].
  @override
  Future<void> delete(String key) => _storage.remove(key);

  /// Deletes all keys from the local storage cache.
  @override
  Future<void> clear() => _storage.erase();
}

/// {@template memory_storage}
/// A memory storage client.
/// {@endtemplate}
class MemoryStorage extends StorageClient {
  /// {@macro memory_storage}
  MemoryStorage() : _storage = {};

  final Map<String, dynamic> _storage;

  /// Writes the provide [key], [value] pair to the memory storage.
  @override
  Future<void> write(String key, {required Object value}) async =>
      _storage[key] = value;

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  @override
  T? read<T extends Object>(String key) {
    final value = _storage[key];
    if (value is T) return value;
    return null;
  }

  /// Deletes the value for the provided [key].
  @override
  Future<void> delete(String key) async => _storage.remove(key);

  /// Deletes all keys from the memory storage.
  @override
  Future<void> clear() async => _storage.clear();
}

typedef CacheWriter<T, Cache> = Cache Function(T value);
typedef CacheReader<T, Cache> = T Function(Cache value);

/// {@macro cache_value}
class CacheValue<T extends Object> extends ConvertableCacheValue<T, T> {
  /// {@macro cache_value}
  CacheValue({
    required super.key,
    required super.fallback,
    super.cache,
    super.controller,
  }) : super(
          writer: (value) => value,
          reader: (value) => value,
        );
}

/// {@template cache_value}
/// An observable cache value.
/// {@endtemplate}
class ConvertableCacheValue<T extends Object, Cache extends Object> {
  /// {@macro cache_value}
  ConvertableCacheValue({
    required this.key,
    required this.fallback,
    required this.writer,
    required this.reader,
    CacheStorage? cache,
    StreamController<T>? controller,
  })  : _cache = cache ?? CacheStorage(),
        _controller = controller ?? StreamController.broadcast();

  final String key;
  final T fallback;
  final CacheWriter<T, Cache> writer;
  final CacheReader<T, Cache> reader;

  final CacheStorage _cache;
  final StreamController<T> _controller;

  void update(T value) => _controller.add(value);

  Stream<T> get stream async* {
    yield value;
    yield* _controller.stream.map((v) {
      _cache.write(key, value: writer(v));
      return v;
    });
  }

  T get value {
    final value = _cache.read<Cache>(key);
    return value != null ? reader(value) : fallback;
  }

  void dispose() => _controller.close();
}
