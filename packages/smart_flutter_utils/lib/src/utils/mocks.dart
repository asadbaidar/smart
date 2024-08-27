import 'dart:async';

mixin MockCallback {
  int _counter = 0;

  bool called(int expected) => _counter == expected;
}

class MockValueCallBack with MockCallback {
  int call(String value) => _counter += 1;
}

class MockVoidCallBack with MockCallback {
  int call() => _counter += 1;
}

class MockFutureCallBack with MockCallback {
  Future<int> call() async => _counter += 1;
}
