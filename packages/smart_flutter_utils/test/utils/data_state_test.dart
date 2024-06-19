import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

void main() {
  const data = 'data';
  const error = HttpException('erro');

  group('DataState', () {
    test('supports value equality', () {
      expect(const DataState<String>(), const DataState<String>());
    });

    group('initial factory', () {
      test('intializes state to initial state', () {
        expect(const DataState<String>.initial().status, DataStatus.initial);
      });

      test('intializes state to initial state with passed data', () {
        const dataState = DataState.initial(data: data);

        expect(dataState.status, DataStatus.initial);
        expect(dataState.data, data);
      });
    });

    group('loading factory', () {
      test('intializes state to loading state', () {
        expect(const DataState<String>.loading().status, DataStatus.loading);
      });

      test('intializes state to loading state with passed data', () {
        const dataState = DataState.loading(data: data);

        expect(dataState.status, DataStatus.loading);
        expect(dataState.data, data);
      });
    });

    group('reloading factory', () {
      test('intializes state to reloading state', () {
        expect(
          const DataState<String>.reloading().status,
          DataStatus.reloading,
        );
      });

      test('intializes state to reloading state with passed data', () {
        const dataState = DataState.reloading(data: data);

        expect(dataState.status, DataStatus.reloading);
        expect(dataState.data, data);
      });
    });

    group('loaded factory', () {
      test('intializes state to loaded state', () {
        expect(const DataState<String>.loaded().status, DataStatus.loaded);
      });

      test('intializes state to loaded state with passed data', () {
        const dataState = DataState.loaded(data: data);

        expect(dataState.status, DataStatus.loaded);
        expect(dataState.data, data);
      });
    });

    group('failure factory', () {
      test('intializes state to failure state', () {
        expect(const DataState<String>.failure().status, DataStatus.failure);
      });

      test('intializes state to failure state with passed data and error', () {
        const dataState = DataState.failure(data: data, error: error);

        expect(dataState.status, DataStatus.failure);
        expect(dataState.data, data);
        expect(dataState.error, error);
      });
    });

    group('toLoading', () {
      test('changes state to loading with object data', () {
        const DataState<String> state = DataState.loaded(data: data);
        final DataState<String> loadingState = state.toLoading();

        expect(loadingState.status, DataStatus.loading);
        expect(loadingState.data, data);
      });
    });

    group('toReloading', () {
      test('changes state to reloading with object data', () {
        const DataState<String> state = DataState.loaded(data: data);
        final DataState<String> loadingState = state.toReloading();

        expect(loadingState.status, DataStatus.reloading);
        expect(loadingState.data, data);
      });
    });

    group('toLoaded', () {
      test('changes state to loaded with passed data', () {
        const DataState<String> state = DataState.initial();
        final DataState<String> loadedState = state.toLoaded(data: data);

        expect(loadedState.status, DataStatus.loaded);
        expect(loadedState.data, data);
      });

      test('changes state to loaded with object data', () {
        const DataState<String> state = DataState.initial(data: data);
        final DataState<String> loadedState = state.toLoaded();

        expect(loadedState.status, DataStatus.loaded);
        expect(loadedState.data, data);
      });
    });

    group('toFailure', () {
      test('changes state to failure with object data and passed error', () {
        const DataState<String> state = DataState.loaded(data: data);
        final DataState<String> failure = state.toFailure(error: error);

        expect(failure.status, DataStatus.failure);
        expect(failure.data, data);
        expect(failure.error, error);
      });
    });

    group('copyWith', () {
      const data1 = 'data1';
      const state1 = DataStatus.loaded;
      final error1 = Exception('error1');

      const data2 = 'data2';
      const state2 = DataStatus.failure;
      final error2 = Exception('error2');

      test('return the same model when nothing passed', () {
        expect(const DataState<String>().copyWith(), const DataState<String>());
      });

      test('updates model properties with passed values', () {
        final apiState1 = DataState(
          data: data1,
          status: state1,
          error: error1,
        );

        final apiState2 = apiState1.copyWith(
          data: data2,
          status: state2,
          error: error2,
        );

        expect(apiState2.data, data2);
        expect(apiState2.status, state2);
        expect(apiState2.error, error2);
      });
    });
  });
}
