import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_flutter_utils/src/cache/cache.dart';

/// {@template secure_storage}
/// A secure storage client.
/// {@endtemplate}
class SecureStorage extends AsyncStorageClient {
  /// {@macro secure_storage}
  SecureStorage() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  /// Writes the provided [key], [value] pair to the secure storage.
  @override
  Future<void> write(
    String key, {
    required Object value,
  }) async {
    try {
      return await _storage.write(key: key, value: value.toString());
    } catch (e) {
      return Future.value();
    }
  }

  /// Looks up the value for the provided [key] in the secure storage asynchrounously.
  @override
  Future<T?> read<T extends Object>(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value is T ? value! as T : null;
    } catch (e) {
      return null;
    }
  }

  /// Deletes the value for the provided [key] in the secure storage.
  @override
  Future<void> delete(String key) async {
    try {
      return await _storage.delete(key: key);
    } catch (e) {
      return Future.value();
    }
  }

  /// Deletes all keys from the secure storage.
  @override
  Future<void> clear() => _storage.deleteAll();
}
