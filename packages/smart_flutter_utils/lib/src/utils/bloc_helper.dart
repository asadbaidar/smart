import 'package:bloc/bloc.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

typedef OnDataState<V> = void Function(Data<V> data);
typedef OnErrorCallback<V> = Data<V> Function(Object error);

extension BlocBaseWhen<T> on BlocBase<T> {
  Future<void> when<V>(
    Data<V> data, {
    required FutureCallback<V> act,
    required OnDataState<V> emit,
    OnDataState<V>? onLoading,
    OnDataState<V>? onLoaded,
    OnDataState<V>? onFailure,
    Callback<Data<V>>? loading,
    OnValueCallback<Data<V>, V>? loaded,
    OnErrorCallback<V>? failure,
  }) async {
    final newData = loading?.call() ?? data.toLoading();
    (onLoading ?? emit)(newData);
    try {
      final result = await act();
      if (V.toString() == 'void') {
        (onLoaded ?? emit)(newData.toLoaded());
      } else {
        (onLoaded ??
            emit)(loaded?.call(result) ?? newData.toLoaded(value: result));
      }
    } catch (e) {
      (onFailure ?? emit)(failure?.call(e) ?? newData.toFailure(error: e));
    }
  }
}

mixin SafeBloc<T> on BlocBase<T> {
  @override
  void emit(T state) {
    if (isClosed) return;
    super.emit(state);
  }
}
