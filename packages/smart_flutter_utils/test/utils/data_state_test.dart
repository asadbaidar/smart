
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';
import 'package:smart_http/smart_http.dart';

void main() {
  const value = 'value';
  const error = HttpException('erro');

  group('Data', () {
    test('supports value equality', () {
      expect(const Data<String>(), const Data<String>());
    });

    group('initial factory', () {
      test('intializes state to initial state', () {
        expect(const Data<String>.initial().state, DataState.initial);
      });

      test('intializes state to initial state with passed value', () {
        const data = Data.initial(value: value);

        expect(data.state, DataState.initial);
        expect(data.value, value);
      });
    });

    group('loading factory', () {
      test('intializes state to loading state', () {
        expect(const Data<String>.loading().state, DataState.loading);
      });

      test('intializes state to loading state with passed value', () {
        const data = Data.loading(value: value);

        expect(data.state, DataState.loading);
        expect(data.value, value);
      });
    });

    group('reloading factory', () {
      test('intializes state to reloading state', () {
        expect(
          const Data<String>.reloading().state,
          DataState.reloading,
        );
      });

      test('intializes state to reloading state with passed value', () {
        const data = Data.reloading(value: value);

        expect(data.state, DataState.reloading);
        expect(data.value, value);
      });
    });

    group('loaded factory', () {
      test('intializes state to loaded state', () {
        expect(const Data<String>.loaded().state, DataState.loaded);
      });

      test('intializes state to loaded state with passed value', () {
        const data = Data.loaded(value: value);

        expect(data.state, DataState.loaded);
        expect(data.value, value);
      });
    });

    group('failure factory', () {
      test('intializes state to failure state', () {
        expect(const Data<String>.failure().state, DataState.failure);
      });

      test('intializes state to failure state with passed value and error', () {
        const data = Data.failure(value: value, error: error);

        expect(data.state, DataState.failure);
        expect(data.value, value);
        expect(data.error, error);
      });
    });

    group('toLoading', () {
      test('changes state to loading with object value', () {
        const Data<String> data = Data.loaded(value: value);
        final Data<String> loading = data.toLoading();

        expect(loading.state, DataState.loading);
        expect(loading.value, value);
      });
    });

    group('toReloading', () {
      test('changes state to reloading with object value', () {
        const Data<String> data = Data.loaded(value: value);
        final Data<String> loading = data.toReloading();

        expect(loading.state, DataState.reloading);
        expect(loading.value, value);
      });
    });

    group('toLoaded', () {
      test('changes state to loaded with passed value', () {
        const Data<String> data = Data.initial();
        final Data<String> loaded = data.toLoaded(value: value);

        expect(loaded.state, DataState.loaded);
        expect(loaded.value, value);
      });

      test('changes state to loaded with object value', () {
        const Data<String> data = Data.initial(value: value);
        final Data<String> loaded = data.toLoaded();

        expect(loaded.state, DataState.loaded);
        expect(loaded.value, value);
      });
    });

    group('toFailure', () {
      test('changes state to failure with object value and passed error', () {
        const Data<String> data = Data.loaded(value: value);
        final Data<String> failure = data.toFailure(error: error);

        expect(failure.state, DataState.failure);
        expect(failure.value, value);
        expect(failure.error, error);
      });
    });

    group('copyWith', () {
      const value1 = 'value1';
      const state1 = DataState.loaded;
      final error1 = Exception('error1');

      const value2 = 'value2';
      const state2 = DataState.failure;
      final error2 = Exception('error2');

      test('return the same model when nothing passed', () {
        expect(const Data<String>().copyWith(), const Data<String>());
      });

      test('updates model properties with passed values', () {
        final data1 = Data(
          value: value1,
          state: state1,
          error: error1,
        );

        final data2 = data1.copyWith(
          value: value2,
          state: state2,
          error: error2,
        );

        expect(data2.value, value2);
        expect(data2.state, state2);
        expect(data2.error, error2);
      });
    });
  });
}
