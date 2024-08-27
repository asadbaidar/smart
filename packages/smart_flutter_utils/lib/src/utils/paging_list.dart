import 'package:equatable/equatable.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

class PagingList<E> extends DelegatingList<E> {
  PagingList({
    required List<E>? items,
    PageInfo? page,
  })  : items = items ?? [],
        page = page ?? const PageInfo(),
        super(items ?? []);

  factory PagingList.empty() => PagingList(items: []);

  final List<E> items;
  final PageInfo page;

  PagingList<E> copyWith({
    List<E>? items,
    PageInfo? page,
  }) {
    return PagingList<E>(
      items: items ?? this.items,
      page: page ?? this.page,
    );
  }

  PagingList<E> mergeWith(PagingList<E> other) {
    return PagingList<E>(
      items: [...items, ...other.items],
      page: other.page.copyWith(),
    );
  }

  int get currentPage => page.current;

  int get pageSize => page.size;

  int get totalItems => page.totalItems;

  int get totalPages => page.totalPages;

  int get nextPage => page.next;

  bool get hasMore => page.hasMore;
}

class PageInfo extends Equatable {
  const PageInfo({
    this.start = 0,
    this.current = 0,
    this.size = 10,
    this.totalItems = 0,
  });

  final int start;
  final int current;
  final int size;
  final int totalItems;

  PageInfo copyWith({
    int? start,
    int? current,
    int? size,
    int? totalItems,
  }) {
    return PageInfo(
      start: start ?? this.start,
      current: current ?? this.current,
      size: size ?? this.size,
      totalItems: totalItems ?? this.totalItems,
    );
  }

  int get totalPages => (totalItems / size).ceil();

  bool get hasMore => current < totalPages + (start - 1);

  int get next => hasMore ? current + 1 : current;

  @override
  List<Object?> get props => [start, current, size, totalItems];
}
