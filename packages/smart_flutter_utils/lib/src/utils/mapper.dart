import 'package:flutter/widgets.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

/// Returns [T] if instance of [T], otherwise null
T? $cast<T>(dynamic value) => value == null
    ? null
    : value is T
        ? value
        : null;

/// Parse [value] to [int] if possible, otherwise null
int? $castInt(dynamic value) =>
    value == null ? null : int.tryParse(value.toString());

/// Parse [value] to [bool] if possible, otherwise null
bool? $castBool(dynamic value) =>
    value == null ? null : bool.tryParse(value.toString());

/// Parse hex [value] to [Color] if possible, otherwise null
Color? $castColor(String? value) => value?.notBlank?.toColor();

/// [apply] mapping with [T] as parameter and [R] as return value
R? $mapTo<T, R>(T? object, R? Function(T it) apply) =>
    object != null ? apply(object) : null;

/// [apply] mapping with dynamic parameter and [R] as return value
R? $mapIt<R>(Object? object, R? Function(dynamic it) apply) =>
    object != null ? apply(object) : null;

List<T>? $mapList<T>(dynamic list, T Function(dynamic e) apply) =>
    (list as List?)?.map<T>(apply).toList();

List<R>? $mapToList<T, R>(List<T>? list, R Function(T it) apply) =>
    list?.map<R>(apply).toList();

extension ObjectMapperHelper on Object {
  /// [apply] mapping with [T] as parameter and [R] as return value
  R mapTo<T, R>(R Function(T it) apply) => apply(this as T);

  /// [apply] mapping with dynamic parameter and [R] as return value
  R mapIt<R>(R Function(dynamic it) apply) => apply(this);

  /// [apply] mapping on current list and [R] as return type of list elements
  List<R>? mapToList<T, R>(R Function(T it) apply) =>
      $cast<List<T>>(this)?.map<R>(apply).toList();
}

/// [ToModel] interface for standard mapping
abstract interface class ToModel<Model> {
  /// [toModel] mapping on implementer to return [Model]
  Model toModel();
}

extension EntityToModelList<E extends ToModel<dynamic>> on List<E> {
  /// [toModels] mapping on [entities] to return list of [M]
  List<M> toModels<M>() => map((e) => e.toModel() as M).toList();
}

/// [mapToModels] mapping on [entities] to return list of [M]
List<M> $mapToModels<E extends ToModel<M>, M>(List<E> entities) {
  return entities.map((e) => e.toModel()).toList();
}

/// [mapToModel] mapping on [entity] to return [M]
M $mapToModel<E extends ToModel<M>, M>(E entity) {
  return entity.toModel();
}

extension FromJsonArray on JsonArray {
  /// [apply] mapping on json array to return list of [R]
  List<R>? mapJsonArray<R>(R Function(JsonObject it) apply) =>
      $cast<JsonArray>(this)?.map<R>((e) => apply(e as JsonObject)).toList();
}

extension MapGetCast<K, V> on Map<K, V> {
  /// [get] value from map and cast it to [R]
  R? get<R>(K key) => $cast(this[key]);
}

extension ToNullable<T> on T? {
  /// Returns the same value, but change it to nullable type if not already.
  T? get nullable => this;
}
