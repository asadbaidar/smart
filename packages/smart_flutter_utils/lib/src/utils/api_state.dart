part of 'utils.dart';

enum ApiCallState {
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

  bool get isInitial => this == ApiCallState.initial;

  bool get isNotInitial => !isInitial;

  bool get isLoading => this == ApiCallState.loading;

  bool get isNotLoading => !isLoading;

  bool get isReloading => this == ApiCallState.reloading;

  bool get isNotReloading => !isReloading;

  bool get isPageLoading => this == ApiCallState.pageLoading;

  bool get isNotPageLoading => !isPageLoading;

  bool get isSearching => this == ApiCallState.searching;

  bool get isNotSearching => !isSearching;

  bool get isLoaded => this == ApiCallState.loaded;

  bool get isNotLoaded => !isLoaded;

  bool get isCanceled => this == ApiCallState.canceled;

  bool get isNotCanceled => !isCanceled;

  bool get isFailure => this == ApiCallState.failure;

  bool get isNotFailure => !isFailure;

  bool get isPageFailure => this == ApiCallState.pageFailure;

  bool get isNotPageFailure => !isPageFailure;

  ApiCallState toFailure() =>
      isPageLoading ? ApiCallState.pageFailure : ApiCallState.failure;
}

class ApiState<T> extends Equatable {
  const ApiState({
    this.data,
    this.state = ApiCallState.initial,
    this.error,
  });

  final T? data;
  final ApiCallState state;
  final dynamic error;

  factory ApiState.initial({T? data}) => ApiState(data: data);

  factory ApiState.loading({T? data}) => ApiState(
        data: data,
        state: ApiCallState.loading,
      );

  factory ApiState.reloading({T? data}) => ApiState(
        data: data,
        state: ApiCallState.reloading,
      );

  factory ApiState.loaded({T? data}) => ApiState(
        data: data,
        state: ApiCallState.loaded,
      );

  factory ApiState.canceled({T? data, dynamic error}) => ApiState(
        data: data,
        state: ApiCallState.canceled,
        error: error,
      );

  factory ApiState.failure({T? data, dynamic error}) => ApiState(
        data: data,
        state: ApiCallState.failure,
        error: error,
      );

  ApiState<T> copyWith({
    T? data,
    ApiCallState? state,
    dynamic error,
  }) {
    return ApiState<T>(
      data: data != null && this.state.isPageLoading && state?.isLoaded == true
          ? ($cast<PagingList>(this.data)?.mergeWith(data as PagingList) ??
              data) as T
          : data ?? this.data,
      state: state ?? this.state,
      error: state?.isLoaded == true ? null : error ?? this.error,
    );
  }

  ApiState<T> toLoading() => copyWith(state: ApiCallState.loading);

  ApiState<T> toReloading() => copyWith(state: ApiCallState.reloading);

  ApiState<T> toLoaded({T? data}) => copyWith(
        data: data,
        state: ApiCallState.loaded,
      );

  ApiState<T> toCanceled({dynamic error}) => copyWith(
        state: ApiCallState.canceled,
        error: error,
      );

  ApiState<T> toFailure({dynamic error}) => copyWith(
        state: ApiCallState.failure,
        error: error,
      );

  PageInfo get page =>
      data is PagingList ? (data as PagingList).page : const PageInfo();

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
    final vData = data;
    return vData == null || vData is List && vData.isEmpty;
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
  List<Object?> get props => [data, state, error];
}
