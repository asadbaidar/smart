part of 'utils.dart';

enum DataState {
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

  bool get isInitial => this == DataState.initial;

  bool get isNotInitial => !isInitial;

  bool get isLoading => this == DataState.loading;

  bool get isNotLoading => !isLoading;

  bool get isReloading => this == DataState.reloading;

  bool get isNotReloading => !isReloading;

  bool get isPageLoading => this == DataState.pageLoading;

  bool get isNotPageLoading => !isPageLoading;

  bool get isSearching => this == DataState.searching;

  bool get isNotSearching => !isSearching;

  bool get isLoaded => this == DataState.loaded;

  bool get isNotLoaded => !isLoaded;

  bool get isCanceled => this == DataState.canceled;

  bool get isNotCanceled => !isCanceled;

  bool get isFailure => this == DataState.failure;

  bool get isNotFailure => !isFailure;

  bool get isPageFailure => this == DataState.pageFailure;

  bool get isNotPageFailure => !isPageFailure;

  DataState toFailure() =>
      isPageLoading ? DataState.pageFailure : DataState.failure;
}

class Data<T> extends Equatable {
  const Data({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.state = DataState.initial,
    this.error,
  }) : extras = extras ?? const {};

  const Data.initial({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.initial,
        extras = extras ?? const {};

  const Data.loading({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.loading,
        extras = extras ?? const {};

  const Data.reloading({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.reloading,
        extras = extras ?? const {};

  const Data.pageLoading({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.pageLoading,
        extras = extras ?? const {};

  const Data.searching({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.searching,
        extras = extras ?? const {};

  const Data.loaded({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.loaded,
        extras = extras ?? const {};

  const Data.canceled({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.canceled,
        extras = extras ?? const {};

  const Data.failure({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.failure,
        extras = extras ?? const {};

  const Data.pageFailure({
    this.key = '',
    this.value,
    JsonObject? extras,
    this.error,
  })  : state = DataState.pageFailure,
        extras = extras ?? const {};

  final String key;
  final T? value;
  final JsonObject extras;
  final DataState state;
  final dynamic error;

  Data<T> copyWith({
    String? key,
    T? value,
    JsonObject? extras,
    DataState? state,
    dynamic error,
  }) {
    return Data<T>(
      key: key ?? this.key,
      value:
          value != null && this.state.isPageLoading && state?.isLoaded == true
              ? ($cast<PagingList<dynamic>>(this.value)
                      ?.mergeWith(value as PagingList) ??
                  value) as T
              : value ?? this.value,
      extras: extras ?? this.extras,
      state: state ?? this.state,
      error: state?.isLoaded == true ? null : error ?? this.error,
    );
  }

  Data<T> toLoading({
    String? key,
    T? value,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        value: value,
        extras: extras,
        state: DataState.loading,
      );

  Data<T> toReloading({
    String? key,
    T? value,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        value: value,
        extras: extras,
        state: DataState.reloading,
      );

  Data<T> toPageLoading({
    String? key,
    T? value,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        value: value,
        extras: extras,
        state: DataState.pageLoading,
      );

  Data<T> toSearching({
    String? key,
    T? value,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        value: value,
        extras: extras,
        state: DataState.searching,
      );

  Data<T> toLoaded({
    String? key,
    T? value,
    JsonObject? extras,
  }) =>
      copyWith(
        key: key,
        value: value,
        extras: extras,
        state: DataState.loaded,
      );

  Data<T> toCanceled({
    String? key,
    dynamic error,
  }) =>
      copyWith(
        key: key,
        error: error,
        state: DataState.canceled,
      );

  Data<T> toFailure({
    String? key,
    dynamic error,
  }) =>
      copyWith(
        key: key,
        error: error,
        state: DataState.failure,
      );

  Data<T> toPageFailure({
    String? key,
    dynamic error,
  }) =>
      copyWith(
        key: key,
        error: error,
        state: DataState.pageFailure,
      );

  PageInfo get page =>
      value is PagingList ? (value! as PagingList).page : const PageInfo();

  String get errorMessage {
    final e = error;
    return isFailure || isPageFailure
        ? e is String
            ? e
            : e?.toString() ?? 'Something went wrong'
        : '';
  }

  bool get isInitial => state.isInitial;

  bool get isNotInitial => state.isNotInitial;

  bool get isLoading => state.isLoading;

  bool get isNotLoading => state.isNotLoading;

  bool get isReloading => state.isReloading;

  bool get isNotReloading => state.isNotReloading;

  bool get isPageLoading => state.isPageLoading;

  bool get isNotPageLoading => state.isNotPageLoading;

  bool get isSearching => state.isSearching;

  bool get isNotSearching => state.isNotSearching;

  bool get isLoaded => state.isLoaded;

  bool get isNotLoaded => state.isNotLoaded;

  bool get isCanceled => state.isCanceled;

  bool get isNotCanceled => state.isNotCanceled;

  bool get isFailure => state.isFailure;

  bool get isNotFailure => state.isNotFailure;

  bool get isPageFailure => state.isPageFailure;

  bool get isNotPageFailure => state.isNotPageFailure;

  bool get isEmpty {
    final value = this.value;
    return value == null ||
        value is List && value.isEmpty ||
        value is String && value.isEmpty;
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
        value,
        extras,
        state,
        error,
      ];
}

typedef OnData<T, R> = R Function(T data);

extension DataWhenState<T> on Data<T> {
  R when<R>({
    OnData<Data<T>, R>? initial,
    OnData<Data<T>, R>? loading,
    OnData<Data<T>, R>? reloading,
    OnData<Data<T>, R>? pageLoading,
    OnData<Data<T>, R>? searching,
    OnData<Data<T>, R>? loaded,
    OnData<Data<T>, R>? canceled,
    OnData<Data<T>, R>? failure,
    OnData<Data<T>, R>? pageFailure,
    required OnData<Data<T>, R> otherwise,
  }) {
    switch (state) {
      case DataState.initial:
        return initial?.call(this) ?? otherwise(this);
      case DataState.loading:
        return loading?.call(this) ?? otherwise(this);
      case DataState.reloading:
        return reloading?.call(this) ?? otherwise(this);
      case DataState.pageLoading:
        return pageLoading?.call(this) ?? otherwise(this);
      case DataState.searching:
        return searching?.call(this) ?? otherwise(this);
      case DataState.loaded:
        return loaded?.call(this) ?? otherwise(this);
      case DataState.canceled:
        return canceled?.call(this) ?? otherwise(this);
      case DataState.failure:
        return failure?.call(this) ?? otherwise(this);
      case DataState.pageFailure:
        return pageFailure?.call(this) ?? otherwise(this);
    }
  }
}
