import 'package:bloc/bloc.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

typedef OnDataValue<V> = void Function(Data<V> data);

extension BlocBaseWhen<T> on BlocBase<T> {
  Future<void> when<V>(
    Data<V> value, {
    required FutureCallback<V> act,
    required OnDataValue<V> emit,
    OnDataValue<V>? onLoading,
    OnDataValue<V>? onLoaded,
    OnDataValue<V>? onFailure,
    Callback<Data<V>>? loading,
    OnValueCallback<Data<V>, V>? loaded,
    OnValueCallback<Data<V>, Object>? failure,
  }) async {
    (onLoading ?? emit)(loading?.call() ?? value.toLoading());
    try {
      final result = await act();
      if (V.toString() == 'void') {
        (onLoaded ?? emit)(value.toLoaded());
      } else {
        (onLoaded ??
            emit)(loaded?.call(result) ?? value.toLoaded(value: result));
      }
    } catch (e) {
      (onFailure ?? emit)(failure?.call(e) ?? value.toFailure(error: e));
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
