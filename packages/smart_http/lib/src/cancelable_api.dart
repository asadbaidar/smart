import 'package:bloc/bloc.dart';
import 'package:smart_http/smart_http.dart';

/// A mixin that provides a cancelable http client to cancel all the pending
/// http requests in the current http client.
mixin CancelableApiMixin {
  /// A [HttpApi] instance that is used to make the http requests.
  HttpApi get http;

  /// Cancels all the pending http requests in the current http client.
  Future<void> cancel() => http.cancel();
}

/// A mixin that provides a cancelable repository to cancel all the pending
/// responses in the current api.
mixin CancelableRepositoryMixin {
  /// A [CancelableApiMixin] instance that is used to get the response from the
  /// http client.
  CancelableApiMixin get api;

  /// Cancels all the pending responses in the current api.
  Future<void> cancel() => api.cancel();
}

/// A mixin that provides a cancelable bloc to cancel all the pending data
/// requests in the current repository.
mixin CancelableBlocMixin {
  /// A [CancelableRepositoryMixin] instance that is used to get the data
  /// from api.
  CancelableRepositoryMixin get repository;

  /// Cancels all the pending data requests in the current repository.
  Future<void> cancel() => repository.cancel();

  /// Provides a helper method to try-catch by separate handling of
  /// [CancelException] with [onCancel] callback.
  Future<void> tryIt(
    Future Function() task, {
    required void Function(dynamic) catchError,
    void Function()? onCancel,
  }) async {
    try {
      await task();
    } catch (e) {
      if (e is CancelException) {
        onCancel?.call();
        return;
      }
      catchError(e);
    }
  }
}

/// An abstraction that enables cancelable cubit to cancel the pending data
/// requests in the current repository with addition to automatically [cancel]
/// when the cubit is closed.
abstract class CancelableCubit<State> extends Cubit<State>
    with CancelableBlocMixin {
  CancelableCubit(super.initialState);

  @override
  void emit(State state) {
    if (isClosed) return;
    super.emit(state);
  }

  @override
  Future<void> close() async {
    await cancel();
    return super.close();
  }
}

/// An abstraction that enables cancelable bloc to cancel the pending data
/// requests in the current repository with addition to automatically [cancel]
/// when the bloc is closed.
abstract class CancelableBloc<Event, State> extends Bloc<Event, State>
    with CancelableBlocMixin {
  CancelableBloc(super.initialState);

  @override
  Future<void> close() async {
    await cancel();
    return super.close();
  }
}
