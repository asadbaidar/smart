import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';

void main() {
  const data = "data";
  const error = HttpException("erro");

  group('ApiState', () {
    test('supports value equality', () {
      expect(const ApiState(), const ApiState());
    });

    group('initial factory', () {
      test('intializes state to initial state', () {
        expect(ApiState.initial().state, ApiCallState.initial);
      });

      test('intializes state to initial state with passed data', () {
        final apiState = ApiState.initial(data: data);

        expect(apiState.state, ApiCallState.initial);
        expect(apiState.data, data);
      });
    });

    group('loading factory', () {
      test('intializes state to loading state', () {
        expect(ApiState.loading().state, ApiCallState.loading);
      });

      test('intializes state to loading state with passed data', () {
        final apiState = ApiState.loading(data: data);

        expect(apiState.state, ApiCallState.loading);
        expect(apiState.data, data);
      });
    });

    group('reloading factory', () {
      test('intializes state to reloading state', () {
        expect(ApiState.reloading().state, ApiCallState.reloading);
      });

      test('intializes state to reloading state with passed data', () {
        final apiState = ApiState.reloading(data: data);

        expect(apiState.state, ApiCallState.reloading);
        expect(apiState.data, data);
      });
    });

    group('loaded factory', () {
      test('intializes state to loaded state', () {
        expect(ApiState.loaded().state, ApiCallState.loaded);
      });

      test('intializes state to loaded state with passed data', () {
        final apiState = ApiState.loaded(data: data);

        expect(apiState.state, ApiCallState.loaded);
        expect(apiState.data, data);
      });
    });

    group('failure factory', () {
      test('intializes state to failure state', () {
        expect(ApiState.failure().state, ApiCallState.failure);
      });

      test('intializes state to failure state with passed data and error', () {
        final apiState = ApiState.failure(data: data, error: error);

        expect(apiState.state, ApiCallState.failure);
        expect(apiState.data, data);
        expect(apiState.error, error);
      });
    });

    group('toLoading', () {
      test('changes state to loading with object data', () {
        final ApiState state = ApiState.loaded(data: data);
        final ApiState loadingState = state.toLoading();

        expect(loadingState.state, ApiCallState.loading);
        expect(loadingState.data, data);
      });
    });

    group('toReloading', () {
      test('changes state to reloading with object data', () {
        final ApiState state = ApiState.loaded(data: data);
        final ApiState loadingState = state.toReloading();

        expect(loadingState.state, ApiCallState.reloading);
        expect(loadingState.data, data);
      });
    });

    group('toLoaded', () {
      test('changes state to loaded with passed data', () {
        final ApiState state = ApiState.initial();
        final ApiState loadedState = state.toLoaded(data: data);

        expect(loadedState.state, ApiCallState.loaded);
        expect(loadedState.data, data);
      });

      test('changes state to loaded with object data', () {
        final ApiState state = ApiState.initial(data: data);
        final ApiState loadedState = state.toLoaded();

        expect(loadedState.state, ApiCallState.loaded);
        expect(loadedState.data, data);
      });
    });

    group('toFailure', () {
      test('changes state to failure with object data and passed error', () {
        final ApiState state = ApiState.loaded(data: data);
        final ApiState failure = state.toFailure(error: error);

        expect(failure.state, ApiCallState.failure);
        expect(failure.data, data);
        expect(failure.error, error);
      });
    });

    group('copyWith', () {
      const data1 = "data1";
      const state1 = ApiCallState.initial;
      final error1 = Exception("error1");

      const data2 = "data2";
      const state2 = ApiCallState.failure;
      final error2 = Exception("error2");

      test('return the same model when nothing passed', () {
        expect(const ApiState().copyWith(), const ApiState());
      });

      test('updates model properties with passed values', () {
        final apiState1 = ApiState(
          data: data1,
          state: state1,
          error: error1,
        );

        final apiState2 = apiState1.copyWith(
          data: data2,
          state: state2,
          error: error2,
        );

        expect(apiState2.data, data2);
        expect(apiState2.state, state2);
        expect(apiState2.error, error2);
      });
    });
  });
}
