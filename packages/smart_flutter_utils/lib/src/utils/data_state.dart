part of 'utils.dart';

enum DataStatus {
  initial,
  loading,
  reloading,
  pageLoading,
  searching,
  loaded,
  canceled,
  failure,
  pageFailure,
  ;

  bool get isInitial => this == DataStatus.initial;

  bool get isNotInitial => !isInitial;

  bool get isLoading => this == DataStatus.loading;

  bool get isNotLoading => !isLoading;

  bool get isReloading => this == DataStatus.reloading;

  bool get isNotReloading => !isReloading;

  bool get isPageLoading => this == DataStatus.pageLoading;

  bool get isNotPageLoading => !isPageLoading;

  bool get isSearching => this == DataStatus.searching;

  bool get isNotSearching => !isSearching;

  bool get isLoaded => this == DataStatus.loaded;

  bool get isNotLoaded => !isLoaded;

  bool get isCanceled => this == DataStatus.canceled;

  bool get isNotCanceled => !isCanceled;

  bool get isFailure => this == DataStatus.failure;

  bool get isNotFailure => !isFailure;

  bool get isPageFailure => this == DataStatus.pageFailure;

  bool get isNotPageFailure => !isPageFailure;

  DataStatus toFailure() =>
      isPageLoading ? DataStatus.pageFailure : DataStatus.failure;
}

class DataState<T> extends Equatable {
  const DataState({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.status = DataStatus.initial,
    this.error,
  }) : extras = extras ?? const {};

  const DataState.initial({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.initial,
        extras = extras ?? const {};

  const DataState.loading({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.loading,
        extras = extras ?? const {};

  const DataState.reloading({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.reloading,
        extras = extras ?? const {};

  const DataState.pageLoading({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.pageLoading,
        extras = extras ?? const {};

  const DataState.searching({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.searching,
        extras = extras ?? const {};

  const DataState.loaded({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.loaded,
        extras = extras ?? const {};

  const DataState.canceled({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.canceled,
        extras = extras ?? const {};

  const DataState.failure({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.failure,
        extras = extras ?? const {};

  const DataState.pageFailure({
    this.key = '',
    this.data,
    JsonObject? extras,
    this.error,
  })  : status = DataStatus.pageFailure,
        extras = extras ?? const {};

  final String key;
  final T? data;
  final JsonObject extras;
  final DataStatus status;
  final dynamic error;

  DataState<T> copyWith({
    String? key,
    T? data,
    JsonObject? extras,
    DataStatus? status,
    dynamic error,
  }) {
    return DataState<T>(
      key: key ?? this.key,
      data:
          data != null && this.status.isPageLoading && status?.isLoaded == true
              ? ($cast<PagingList<dynamic>>(this.data)
                      ?.mergeWith(data as PagingList) ??
                  data) as T
              : data ?? this.data,
      extras: extras ?? this.extras,
      status: status ?? this.status,
      error: status?.isLoaded == true ? null : error ?? this.error,
    );
  }

  DataState<T> toLoading({
    String? key,
    T? data,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        data: data,
        extras: extras,
        status: DataStatus.loading,
      );

  DataState<T> toReloading({
    String? key,
    T? data,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        data: data,
        extras: extras,
        status: DataStatus.reloading,
      );

  DataState<T> toPageLoading({
    String? key,
    T? data,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        data: data,
        extras: extras,
        status: DataStatus.pageLoading,
      );

  DataState<T> toSearching({
    String? key,
    T? data,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        data: data,
        extras: extras,
        status: DataStatus.searching,
      );

  DataState<T> toLoaded({
    String? key,
    T? data,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        data: data,
        extras: extras,
        status: DataStatus.loaded,
      );

  DataState<T> toCanceled({
    String? key,
    dynamic error,
  }) =>
      copyWith(
        key: key,
        error: error,
        status: DataStatus.canceled,
      );

  DataState<T> toFailure({
    String? key,
    dynamic error,
  }) =>
      copyWith(
        key: key,
        error: error,
        status: DataStatus.failure,
      );

  DataState<T> toPageFailure({
    String? key,
    dynamic error,
  }) =>
      copyWith(
        key: key,
        error: error,
        status: DataStatus.pageFailure,
      );

  PageInfo get page =>
      data is PagingList ? (data! as PagingList).page : const PageInfo();

  String get errorMessage {
    final e = error;
    return isFailure || isPageFailure
        ? e is String
            ? e
            : e?.toString() ?? 'Something went wrong'
        : '';
  }

  bool get isInitial => status.isInitial;

  bool get isNotInitial => status.isNotInitial;

  bool get isLoading => status.isLoading;

  bool get isNotLoading => status.isNotLoading;

  bool get isReloading => status.isReloading;

  bool get isNotReloading => status.isNotReloading;

  bool get isPageLoading => status.isPageLoading;

  bool get isNotPageLoading => status.isNotPageLoading;

  bool get isSearching => status.isSearching;

  bool get isNotSearching => status.isNotSearching;

  bool get isLoaded => status.isLoaded;

  bool get isNotLoaded => status.isNotLoaded;

  bool get isCanceled => status.isCanceled;

  bool get isNotCanceled => status.isNotCanceled;

  bool get isFailure => status.isFailure;

  bool get isNotFailure => status.isNotFailure;

  bool get isPageFailure => status.isPageFailure;

  bool get isNotPageFailure => status.isNotPageFailure;

  bool get isEmpty {
    final vData = data;
    return vData == null ||
        vData is List && vData.isEmpty ||
        vData is String && vData.isEmpty;
  }

  bool get isNotEmpty => !isEmpty;

  bool get hasError => error?.toString().isNotEmpty == true;

  bool get hasNoError => !hasError;

  bool get isError => isEmpty || isFailure || hasError;

  bool get isNotError => !isError;

  bool get isReady =>
      (isLoaded ||
          (isReloading && hasNoError) ||
          isPageLoading ||
          isCanceled ||
          isPageFailure) &&
      isNotEmpty;

  bool get isNotReady => !isReady;

  bool get isReadyOrLoading => isReady || isLoading;

  bool get isNotReadyOrLoading => !isReadyOrLoading;

  @override
  List<Object?> get props => [
        key,
        data,
        extras,
        status,
        error,
      ];
}
