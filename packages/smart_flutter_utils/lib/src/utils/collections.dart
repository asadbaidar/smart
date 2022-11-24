part of 'utils.dart';

extension MapToJsonString<K, V> on Map<K, V> {
  String get jsonString => jsonEncode(this);
}

extension ListToJsonString<E> on List<E> {
  String get jsonString => jsonEncode(this);
}

extension MapDynamicNullsafe<K> on Map<K, dynamic> {
  Map<K, dynamic> get replaceNullWithEmpty => isEmpty
      ? this
      : entries.map((e) => MapEntry(e.key, e.value ?? "")).toMap();
}

extension MapEntryIterableToMap<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() => Map<K, V>.fromEntries(this);
}

extension ListOperations<E> on List<E> {
  E? get(int? index) {
    if (index != null && index < length) {
      return this[index];
    }
    return null;
  }

  E insertOrAdd(int index, E element) {
    if (index < length) {
      insert(index, element);
    } else {
      add(element);
    }
    return element;
  }
}

extension IterableSortNum<E extends num> on Iterable<E> {
  List<E> sortedIt() => sortedByCompare<E>((e) => e, (a, b) => a.compareTo(b));
}

extension IterableSortElement<E extends Comparable<E>> on Iterable<E> {
  List<E> sortedIt() => sortedBy<E>((e) => e);
}

extension IterableOperations<E> on Iterable<E> {
  List<E> distinct([Function(E element)? by]) {
    final bySet = <dynamic>{};
    return where((x) => bySet.add(by != null ? by(x) : x)).toList();
  }

  E? reduceOrNull(E Function(E value, E element) combine) {
    try {
      return isEmpty ? null : reduce(combine);
    } catch (e) {
      return null;
    }
  }

  Iterable<E> exclude(bool Function(E element) where) =>
      expand((e) => where(e) ? [] : [e]);

  Iterable<E> get emptyExcluded => exclude((e) => e.toString().isEmpty);
}

extension EnumByNameFromIterable<E extends Enum> on Iterable<E> {
  /// Finds the enum value in this list with name [name].
  ///
  /// Goes through this collection looking for an enum with
  /// name [name], as reported by [EnumName.name].
  /// Returns the first value with the given name or null if none found.
  E? byNameOrNull(String name, [List<String>? others]) {
    for (var value in this) {
      if (value.name == name || others?.contains(value.name) == true) {
        return value;
      }
    }
    return null;
  }
}

extension IterableNotEmpty<E> on Iterable<E> {
  Iterable<E>? get notEmpty => isNotEmpty ? this : null;
}

extension SortEnumList<T extends Enum> on List<T> {
  void sortByName() => sort((a, b) => a.name.compareTo(b.name));

  void sortByIndex() => sort((a, b) => a.index.compareTo(b.index));
}

extension SortEnumIterable<T extends Enum> on Iterable<T> {
  List<T> sortedByName() => sorted((a, b) => a.name.compareTo(b.name));

  List<T> sortedByIndex() => sorted((a, b) => a.index.compareTo(b.index));
}
